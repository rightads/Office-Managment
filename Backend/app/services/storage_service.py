from __future__ import annotations

import abc
import hashlib
import hmac
import logging
import os
import time
import uuid
from typing import TYPE_CHECKING, Any

from app.core.config import settings
from app.core.exceptions import AppException

if TYPE_CHECKING:
    pass

logger = logging.getLogger(__name__)


class BaseStorageService(abc.ABC):
    """Abstract interface for task and application file storage."""

    @abc.abstractmethod
    async def upload_file(
        self,
        file_content: bytes,
        filename: str,
        mime_type: str,
        subfolder: str = "tasks",
    ) -> tuple[str, str]:
        """
        Save file content to the underlying storage provider.
        Returns:
            tuple[storage_key, public_or_internal_url]
        """
        pass

    @abc.abstractmethod
    def generate_signed_url(
        self,
        storage_key: str,
        filename: str,
        expires_in_seconds: int = 3600,
    ) -> str:
        """Generate a time-limited signed download URL."""
        pass

    @abc.abstractmethod
    async def delete_file(self, storage_key: str) -> bool:
        """Remove file from storage."""
        pass


class LocalStorageService(BaseStorageService):
    """Local disk storage implementation with cryptographic HMAC signed download URLs."""

    def __init__(self, base_path: str | None = None, secret_key: str | None = None) -> None:
        self.base_path = base_path or settings.LOCAL_STORAGE_PATH
        self.secret_key = (secret_key or settings.JWT_SECRET_KEY).encode("utf-8")
        os.makedirs(self.base_path, exist_ok=True)

    async def upload_file(
        self,
        file_content: bytes,
        filename: str,
        mime_type: str,
        subfolder: str = "tasks",
    ) -> tuple[str, str]:
        sanitized_filename = os.path.basename(filename).replace(" ", "_")
        unique_prefix = uuid.uuid4().hex[:12]
        stored_filename = f"{unique_prefix}_{sanitized_filename}"

        target_dir = os.path.join(self.base_path, subfolder)
        os.makedirs(target_dir, exist_ok=True)

        full_path = os.path.join(target_dir, stored_filename)
        # Normalize relative storage key with forward slashes
        storage_key = f"{subfolder}/{stored_filename}".replace("\\", "/")

        with open(full_path, "wb") as f:
            f.write(file_content)

        return storage_key, f"/uploads/{storage_key}"

    def generate_signature(self, storage_key: str, expires_at: int) -> str:
        message = f"{storage_key}:{expires_at}".encode()
        return hmac.new(self.secret_key, message, hashlib.sha256).hexdigest()

    def verify_signature(self, storage_key: str, expires_at: int, signature: str) -> bool:
        if time.time() > expires_at:
            return False
        expected = self.generate_signature(storage_key, expires_at)
        return hmac.compare_digest(expected, signature)

    def generate_signed_url(
        self,
        storage_key: str,
        filename: str,
        expires_in_seconds: int = 3600,
    ) -> str:
        expires_at = int(time.time()) + expires_in_seconds
        sig = self.generate_signature(storage_key, expires_at)
        return (
            f"/api/v1/tasks/attachments/download"
            f"?key={storage_key}&expires={expires_at}&signature={sig}&filename={filename}"
        )

    async def delete_file(self, storage_key: str) -> bool:
        full_path = os.path.join(self.base_path, storage_key)
        if os.path.exists(full_path):
            try:
                os.remove(full_path)
                return True
            except OSError as e:
                logger.error("Failed to delete local file %s: %s", full_path, e)
                return False
        return False


class S3StorageService(BaseStorageService):
    """AWS S3 / S3-compatible cloud storage implementation."""

    def __init__(self) -> None:
        if not settings.S3_BUCKET_NAME:
            raise AppException("S3_BUCKET_NAME must be configured for S3 storage.")
        self.bucket = settings.S3_BUCKET_NAME

    def _get_client(self) -> Any:
        try:
            import boto3  # type: ignore[import-not-found]
        except ImportError:
            raise AppException(
                "boto3 is required for S3 storage. Install boto3 or use local storage."
            ) from None

        kwargs: dict[str, Any] = {}
        if settings.S3_ENDPOINT_URL:
            kwargs["endpoint_url"] = settings.S3_ENDPOINT_URL
        if settings.S3_REGION:
            kwargs["region_name"] = settings.S3_REGION
        if settings.S3_ACCESS_KEY_ID and settings.S3_SECRET_ACCESS_KEY:
            kwargs["aws_access_key_id"] = settings.S3_ACCESS_KEY_ID
            kwargs["aws_secret_access_key"] = settings.S3_SECRET_ACCESS_KEY

        return boto3.client("s3", **kwargs)

    async def upload_file(
        self,
        file_content: bytes,
        filename: str,
        mime_type: str,
        subfolder: str = "tasks",
    ) -> tuple[str, str]:
        sanitized_filename = os.path.basename(filename).replace(" ", "_")
        storage_key = f"{subfolder}/{uuid.uuid4().hex}_{sanitized_filename}"

        client = self._get_client()
        client.put_object(
            Bucket=self.bucket,
            Key=storage_key,
            Body=file_content,
            ContentType=mime_type,
        )
        url = f"https://{self.bucket}.s3.amazonaws.com/{storage_key}"
        return storage_key, url

    def generate_signed_url(
        self,
        storage_key: str,
        filename: str,
        expires_in_seconds: int = 3600,
    ) -> str:
        client = self._get_client()
        url = client.generate_presigned_url(
            "get_object",
            Params={
                "Bucket": self.bucket,
                "Key": storage_key,
                "ResponseContentDisposition": f'attachment; filename="{filename}"',
            },
            ExpiresIn=expires_in_seconds,
        )
        return str(url)

    async def delete_file(self, storage_key: str) -> bool:
        client = self._get_client()
        try:
            client.delete_object(Bucket=self.bucket, Key=storage_key)
            return True
        except Exception as e:
            logger.error("Failed to delete S3 object %s: %s", storage_key, e)
            return False


def get_storage_service() -> BaseStorageService:
    """Factory selecting the storage backend according to configuration."""
    if settings.STORAGE_BACKEND == "s3":
        return S3StorageService()
    return LocalStorageService()

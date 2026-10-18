import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photo_picker_service.g.dart';

/// Represents a photo selected and compressed from camera or gallery.
@immutable
class PickedPhotoFile {
  const PickedPhotoFile({
    required this.fileName,
    required this.mimeType,
    required this.sizeBytes,
    required this.pathOrUri,
  });

  final String fileName;
  final String mimeType;
  final int sizeBytes;
  final String pathOrUri;
}

/// Reason a picked photo failed validation against [RuntimeAppConfig].
enum PhotoValidationError {
  exceedsMaxSize,
  unsupportedMimeType,
}

/// Injectable service for picking, compressing, and validating profile photos
/// against server-configured upload limits from `/api/v1/app/config`.
class PhotoPickerService {
  PhotoPickerService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  /// Picks and compresses an image from [source] (`camera` or `gallery`).
  /// Returns `null` if the user cancels the picker.
  Future<PickedPhotoFile?> pickCompressedPhoto(ImageSource source) async {
    try {
      final xFile = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );
      if (xFile == null) {
        return null;
      }

      final bytes = await xFile.readAsBytes();
      final resolvedMime = _resolveMimeType(xFile);
      final sanitizedName = xFile.name.trim().isEmpty
          ? 'avatar.jpg'
          : xFile.name.trim().replaceAll(' ', '_');

      return PickedPhotoFile(
        fileName: sanitizedName,
        mimeType: resolvedMime,
        sizeBytes: bytes.length,
        pathOrUri: '/uploads/avatars/$sanitizedName',
      );
    } on MissingPluginException {
      return null;
    } on PlatformException {
      return null;
    }
  }

  /// Validates [file] against `maxUploadMb` and `allowedUploadMimeTypes` from
  /// [config] (`GET /api/v1/app/config`). Returns `null` when valid.
  static PhotoValidationError? validatePickedPhoto(
    PickedPhotoFile file,
    RuntimeAppConfig config,
  ) {
    final normalizedMime = file.mimeType.trim().toLowerCase();
    final allowedMimes = config.allowedUploadMimeTypes
        .map((m) => m.trim().toLowerCase())
        .where((m) => m.isNotEmpty)
        .toSet();

    // Only allow image MIME types that are also permitted by server config.
    if (!normalizedMime.startsWith('image/') ||
        (allowedMimes.isNotEmpty && !allowedMimes.contains(normalizedMime))) {
      return PhotoValidationError.unsupportedMimeType;
    }

    final maxBytes = config.maxUploadMb * 1024 * 1024;
    if (file.sizeBytes > maxBytes) {
      return PhotoValidationError.exceedsMaxSize;
    }

    return null;
  }

  static String _resolveMimeType(XFile xFile) {
    final explicit = xFile.mimeType?.trim().toLowerCase();
    if (explicit != null && explicit.isNotEmpty) {
      return explicit;
    }
    final lowerName = xFile.name.isNotEmpty
        ? xFile.name.toLowerCase()
        : xFile.path.toLowerCase();
    if (lowerName.endsWith('.png')) {
      return 'image/png';
    }
    if (lowerName.endsWith('.webp')) {
      return 'image/webp';
    }
    if (lowerName.endsWith('.jpg') || lowerName.endsWith('.jpeg')) {
      return 'image/jpeg';
    }
    return 'application/octet-stream';
  }
}

@Riverpod(keepAlive: true)
PhotoPickerService photoPickerService(Ref ref) {
  return PhotoPickerService();
}

from __future__ import annotations

import datetime
import zoneinfo

from app.core.config import settings


def get_app_timezone() -> zoneinfo.ZoneInfo:
    """Return the ZoneInfo instance for the configured APP_TIMEZONE."""
    try:
        return zoneinfo.ZoneInfo(settings.APP_TIMEZONE)
    except Exception:
        return zoneinfo.ZoneInfo("UTC")


def now_utc() -> datetime.datetime:
    """Return the current timezone-aware UTC datetime."""
    return datetime.datetime.now(datetime.timezone.utc)


def to_app_timezone(dt: datetime.datetime) -> datetime.datetime:
    """Convert any timezone-aware datetime to the application local timezone."""
    tz = get_app_timezone()
    if dt.tzinfo is None:
        dt = dt.replace(tzinfo=datetime.timezone.utc)
    return dt.astimezone(tz)


def to_utc(dt: datetime.datetime) -> datetime.datetime:
    """Convert any timezone-aware datetime to UTC."""
    if dt.tzinfo is None:
        tz = get_app_timezone()
        dt = dt.replace(tzinfo=tz)
    return dt.astimezone(datetime.timezone.utc)


def get_local_today() -> datetime.date:
    """Return today's date evaluated in the application's configured timezone."""
    return now_utc().astimezone(get_app_timezone()).date()


def combine_date_time_to_utc(d: datetime.date, t: datetime.time) -> datetime.datetime:
    """
    Combine a date and time evaluated in the application local timezone,
    and return the corresponding UTC timezone-aware datetime.
    """
    tz = get_app_timezone()
    local_dt = datetime.datetime.combine(d, t, tzinfo=tz)
    return local_dt.astimezone(datetime.timezone.utc)

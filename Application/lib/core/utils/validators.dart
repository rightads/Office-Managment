import 'package:flutter/widgets.dart';
import 'package:right_ads/core/l10n/generated/app_localizations.dart';

/// Reusable form field validators whose user-visible error messages come
/// strictly from [AppLocalizations].
abstract final class AppValidators {
  static final RegExp _emailRegex = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
  );
  static final RegExp _phoneRegex = RegExp(r'^\+?[0-9\s\-()]{7,20}$');

  static FormFieldValidator<String> required(AppLocalizations l10n) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return l10n.validationRequired;
      }
      return null;
    };
  }

  static FormFieldValidator<String> email(AppLocalizations l10n) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return null;
      }
      if (!_emailRegex.hasMatch(value.trim())) {
        return l10n.validationEmail;
      }
      return null;
    };
  }

  static FormFieldValidator<String> minLength(AppLocalizations l10n, int min) {
    return (value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      if (value.length < min) {
        return l10n.validationMinLength(min);
      }
      return null;
    };
  }

  static FormFieldValidator<String> maxLength(AppLocalizations l10n, int max) {
    return (value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      if (value.length > max) {
        return l10n.validationMaxLength(max);
      }
      return null;
    };
  }

  static FormFieldValidator<String> numeric(AppLocalizations l10n) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return null;
      }
      if (num.tryParse(value.trim()) == null) {
        return l10n.validationNumeric;
      }
      return null;
    };
  }

  static FormFieldValidator<String> phone(AppLocalizations l10n) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return null;
      }
      if (!_phoneRegex.hasMatch(value.trim())) {
        return l10n.validationPhone;
      }
      return null;
    };
  }

  static FormFieldValidator<String> compose(
    List<FormFieldValidator<String>> validators,
  ) {
    return (value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }
}

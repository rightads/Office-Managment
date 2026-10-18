import 'package:right_ads/core/config/runtime_app_config.dart';

/// Violations evaluated dynamically against [PasswordPolicySummary] from
/// `GET /api/v1/app/config`.
enum PasswordPolicyViolation {
  tooShort,
  missingUppercase,
  missingLowercase,
  missingDigit,
  missingSpecial,
}

/// Evaluates candidate passwords against the server-provided
/// [PasswordPolicySummary] without hardcoding policy thresholds.
abstract final class PasswordPolicyValidator {
  static final RegExp _upperRegex = RegExp('[A-Z]');
  static final RegExp _lowerRegex = RegExp('[a-z]');
  static final RegExp _digitRegex = RegExp('[0-9]');
  static final RegExp _specialRegex = RegExp(r'[^A-Za-z0-9\s]');

  /// Returns all [PasswordPolicyViolation] items that [password] currently
  /// fails against [policy]. Empty list means [password] satisfies all rules.
  static List<PasswordPolicyViolation> evaluate(
    String password,
    PasswordPolicySummary policy,
  ) {
    final violations = <PasswordPolicyViolation>[];
    if (password.length < policy.minLength) {
      violations.add(PasswordPolicyViolation.tooShort);
    }
    if (policy.requireUppercase && !_upperRegex.hasMatch(password)) {
      violations.add(PasswordPolicyViolation.missingUppercase);
    }
    if (policy.requireLowercase && !_lowerRegex.hasMatch(password)) {
      violations.add(PasswordPolicyViolation.missingLowercase);
    }
    if (policy.requireDigit && !_digitRegex.hasMatch(password)) {
      violations.add(PasswordPolicyViolation.missingDigit);
    }
    if (policy.requireSpecial && !_specialRegex.hasMatch(password)) {
      violations.add(PasswordPolicyViolation.missingSpecial);
    }
    return violations;
  }

  /// Returns `true` if [password] satisfies every rule in [policy].
  static bool isValid(String password, PasswordPolicySummary policy) {
    return evaluate(password, policy).isEmpty;
  }
}

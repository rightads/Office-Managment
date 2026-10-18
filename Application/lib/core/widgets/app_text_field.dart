import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:right_ads/core/l10n/l10n.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    required this.label,
    this.controller,
    this.hint,
    this.helperText,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.readOnly = false,
    this.inputFormatters,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    super.key,
  });

  final String label;
  final TextEditingController? controller;
  final String? hint;
  final String? helperText;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int maxLines;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onTap;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscured;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.obscureText != widget.obscureText) {
      _obscured = widget.obscureText;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final effectiveSuffix = widget.obscureText
        ? IconButton(
            tooltip: _obscured
                ? l10n.passwordShowTooltip
                : l10n.passwordHideTooltip,
            icon: Icon(
              _obscured
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
            onPressed: () {
              setState(() {
                _obscured = !_obscured;
              });
            },
          )
        : widget.suffixIcon;

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscured,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      onTap: widget.onTap,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        helperText: widget.helperText,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: effectiveSuffix,
      ),
    );
  }
}

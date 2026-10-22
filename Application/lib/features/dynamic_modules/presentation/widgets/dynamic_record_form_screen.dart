import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/widgets/app_button.dart';
import 'package:right_ads/core/widgets/app_snackbar.dart';
import 'package:right_ads/core/widgets/app_text_field.dart';
import 'package:right_ads/core/widgets/confirm_dialog.dart';
import 'package:right_ads/features/dynamic_modules/data/dynamic_module_repository.dart';
import 'package:right_ads/features/dynamic_modules/domain/dynamic_module_models.dart';

/// Dynamic schema-driven create/edit form with validation and unsaved-changes guard.
class DynamicRecordFormScreen extends ConsumerStatefulWidget {
  const DynamicRecordFormScreen({
    required this.definition,
    this.initialRecord,
    super.key,
  });

  final DynamicModuleDefinition definition;
  final DynamicRecordModel? initialRecord;

  @override
  ConsumerState<DynamicRecordFormScreen> createState() =>
      _DynamicRecordFormScreenState();
}

class _DynamicRecordFormScreenState
    extends ConsumerState<DynamicRecordFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Map<String, dynamic> _formData;
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String> _serverErrors = <String, String>{};
  bool _isSaving = false;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _formData = Map<String, dynamic>.from(
      widget.initialRecord?.data ?? <String, dynamic>{},
    );

    // Populate default values if creating new record
    if (widget.initialRecord == null) {
      for (final f in widget.definition.fields) {
        if (f.defaultValue != null && !_formData.containsKey(f.key)) {
          _formData[f.key] = f.defaultValue;
        }
      }
    }

    // Initialize controllers for string/numeric fields
    for (final f in widget.definition.fields) {
      final initialText = _formData[f.key]?.toString() ?? '';
      _controllers[f.key] = TextEditingController(text: initialText);
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _markChanged() {
    if (!_hasChanges) {
      setState(() => _hasChanges = true);
    }
  }

  Future<bool> _onWillPop() async {
    if (!_hasChanges) return true;
    final l10n = context.l10n;
    final discard = await ConfirmDialog.show(
      context,
      title: l10n.dynamicModuleDiscardChangesTitle,
      message: l10n.dynamicModuleDiscardChangesMessage,
      confirmLabel: l10n.dynamicModuleDiscard,
      isDestructive: true,
    );
    return discard;
  }

  Future<void> _submit() async {
    _serverErrors.clear();
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    setState(() => _isSaving = true);
    final repo = ref.read(dynamicModuleRepositoryProvider);

    if (widget.initialRecord == null) {
      final (created, failure) = await repo.createRecord(
        widget.definition.code,
        data: _formData,
      );
      if (!mounted) return;
      setState(() => _isSaving = false);
      if (failure != null) {
        _handleFailure(failure.message ?? 'Failed to create record');
      } else {
        AppSnackbar.showSuccess(
          context,
          '${widget.definition.recordLabelSingular} created successfully',
        );
        Navigator.of(context).pop(true);
      }
    } else {
      final (updated, failure) = await repo.updateRecord(
        widget.definition.code,
        widget.initialRecord!.id,
        data: _formData,
      );
      if (!mounted) return;
      setState(() => _isSaving = false);
      if (failure != null) {
        _handleFailure(failure.message ?? 'Failed to update record');
      } else {
        AppSnackbar.showSuccess(
          context,
          '${widget.definition.recordLabelSingular} updated successfully',
        );
        Navigator.of(context).pop(true);
      }
    }
  }

  void _handleFailure(String msg) {
    AppSnackbar.showError(context, msg);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final isEdit = widget.initialRecord != null;
    final title = isEdit
        ? 'Edit ${widget.definition.recordLabelSingular}'
        : 'New ${widget.definition.recordLabelSingular}';

    // Group fields by section
    final sections = <String, List<DynamicModuleField>>{};
    for (final f in widget.definition.fields.where((f) => f.isActive)) {
      final sec = (f.section != null && f.section!.trim().isNotEmpty)
          ? f.section!.trim()
          : 'General Information';
      sections.putIfAbsent(sec, () => []).add(f);
    }
    for (final list in sections.values) {
      list.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    }

    return PopScope(
      canPop: !_hasChanges,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            TextButton(
              onPressed: _isSaving ? null : _submit,
              child: _isSaving
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.dynamicModuleSave),
            ),
          ],
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                ...sections.entries.expand((secEntry) {
                  return <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        secEntry.key,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: secEntry.value
                              .map(_buildFieldEditor)
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ];
                }),
                const SizedBox(height: 16),
                AppButton(
                  label: isEdit
                      ? l10n.dynamicFormUpdateRecord
                      : l10n.dynamicFormCreateRecord,
                  isLoading: _isSaving,
                  expanded: true,
                  onPressed: _submit,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldEditor(DynamicModuleField field) {
    final currentVal = _formData[field.key];
    final serverErr = _serverErrors[field.key];
    final ctrl = _controllers[field.key];

    switch (field.type) {
      case DynamicFieldType.text:
      case DynamicFieldType.phone:
      case DynamicFieldType.email:
      case DynamicFieldType.url:
      case DynamicFieldType.file:
      case DynamicFieldType.image:
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppTextField(
            label: '${field.label}${field.isRequired ? ' *' : ''}',
            controller: ctrl,
            errorText: serverErr,
            keyboardType: _getKeyboardType(field.type),
            validator: (val) => _validateStringField(field, val),
            onChanged: (val) {
              _formData[field.key] = val;
              _markChanged();
            },
          ),
        );

      case DynamicFieldType.longText:
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppTextField(
            label: '${field.label}${field.isRequired ? ' *' : ''}',
            controller: ctrl,
            errorText: serverErr,
            maxLines: 4,
            validator: (val) => _validateStringField(field, val),
            onChanged: (val) {
              _formData[field.key] = val;
              _markChanged();
            },
          ),
        );

      case DynamicFieldType.number:
      case DynamicFieldType.currency:
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppTextField(
            label: '${field.label}${field.isRequired ? ' *' : ''}',
            controller: ctrl,
            errorText: serverErr,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (val) => _validateNumberField(field, val),
            onChanged: (val) {
              final numVal = num.tryParse(val.trim());
              _formData[field.key] = numVal;
              _markChanged();
            },
          ),
        );

      case DynamicFieldType.singleSelect:
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              label: Text('${field.label}${field.isRequired ? ' *' : ''}'),
              errorText: serverErr,
            ),
            initialValue: currentVal?.toString(),
            items: field.options.map((opt) {
              return DropdownMenuItem<String>(
                value: opt.value,
                child: Text(opt.label),
              );
            }).toList(),
            validator: (val) {
              if (field.isRequired && (val == null || val.isEmpty)) {
                return context.l10n.dynamicFormSelectOption;
              }
              return null;
            },
            onChanged: (val) {
              setState(() {
                _formData[field.key] = val;
              });
              _markChanged();
            },
          ),
        );

      case DynamicFieldType.boolean:
        final boolVal =
            currentVal == true || currentVal.toString().toLowerCase() == 'true';
        return SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(field.label),
          value: boolVal,
          onChanged: (val) {
            setState(() {
              _formData[field.key] = val;
            });
            _markChanged();
          },
        );

      case DynamicFieldType.date:
      case DynamicFieldType.datetime:
        final dateStr = currentVal?.toString() ?? '';
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppTextField(
            label: '${field.label}${field.isRequired ? ' *' : ''}',
            controller: ctrl,
            errorText: serverErr,
            readOnly: true,
            suffixIcon: const Icon(Icons.calendar_today_outlined),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.tryParse(dateStr) ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                final iso =
                    '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
                setState(() {
                  _formData[field.key] = iso;
                  ctrl?.text = iso;
                });
                _markChanged();
              }
            },
            validator: (val) {
              if (field.isRequired && (val == null || val.trim().isEmpty)) {
                return context.l10n.dynamicFormPickDate;
              }
              return null;
            },
          ),
        );

      case DynamicFieldType.geoPoint:
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                label: '${field.label}${field.isRequired ? ' *' : ''}',
                controller: ctrl,
                errorText: serverErr,
                readOnly: true,
                validator: (val) {
                  if (field.isRequired && (val == null || val.trim().isEmpty)) {
                    return '${field.label} is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 6),
              OutlinedButton.icon(
                icon: const Icon(Icons.my_location, size: 16),
                label: Text(context.l10n.fieldActionCaptureGps),
                onPressed: () async {
                  try {
                    final position =
                        await geolocator.Geolocator.getCurrentPosition();
                    final coords =
                        '${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}';
                    setState(() {
                      _formData[field.key] = {
                        'lat': position.latitude,
                        'lng': position.longitude,
                      };
                      ctrl?.text = coords;
                    });
                    _markChanged();
                    if (mounted) {
                      AppSnackbar.showSuccess(
                        context,
                        context.l10n.fieldActionLocationCaptured(coords),
                      );
                    }
                  } catch (_) {
                    if (mounted) {
                      AppSnackbar.showError(
                        context,
                        context.l10n.fieldActionLaunchError,
                      );
                    }
                  }
                },
              ),
            ],
          ),
        );

      default:
        // Generic fallback field editor
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppTextField(
            label: '${field.label}${field.isRequired ? ' *' : ''}',
            controller: ctrl,
            errorText: serverErr,
            onChanged: (val) {
              _formData[field.key] = val;
              _markChanged();
            },
          ),
        );
    }
  }

  TextInputType _getKeyboardType(String type) {
    switch (type) {
      case DynamicFieldType.phone:
        return TextInputType.phone;
      case DynamicFieldType.email:
        return TextInputType.emailAddress;
      case DynamicFieldType.url:
        return TextInputType.url;
      default:
        return TextInputType.text;
    }
  }

  String? _validateStringField(DynamicModuleField field, String? val) {
    final str = val?.trim() ?? '';
    if (field.isRequired && str.isEmpty) {
      return '${field.label} is required';
    }
    if (field.validation != null) {
      final v = field.validation!;
      if (v.minLength != null && str.isNotEmpty && str.length < v.minLength!) {
        return '${field.label} must be at least ${v.minLength} characters';
      }
      if (v.maxLength != null && str.length > v.maxLength!) {
        return '${field.label} cannot exceed ${v.maxLength} characters';
      }
      if (v.regex != null && str.isNotEmpty) {
        final reg = RegExp(v.regex!);
        if (!reg.hasMatch(str)) {
          return v.regexMessage ?? '${field.label} has an invalid format';
        }
      }
    }
    return null;
  }

  String? _validateNumberField(DynamicModuleField field, String? val) {
    final str = val?.trim() ?? '';
    if (field.isRequired && str.isEmpty) {
      return '${field.label} is required';
    }
    if (str.isNotEmpty) {
      final numVal = num.tryParse(str);
      if (numVal == null) {
        return 'Please enter a valid number';
      }
      if (field.validation != null) {
        final v = field.validation!;
        if (v.min != null && numVal < v.min!) {
          return '${field.label} must be at least ${v.min}';
        }
        if (v.max != null && numVal > v.max!) {
          return '${field.label} cannot exceed ${v.max}';
        }
      }
    }
    return null;
  }
}

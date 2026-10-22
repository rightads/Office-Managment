import 'package:flutter/material.dart';

import 'package:right_ads/core/l10n/l10n.dart';

class HexColorPickerDialog extends StatefulWidget {
  const HexColorPickerDialog({this.initialColor, super.key});

  final String? initialColor;

  static const List<String> presetColors = [
    '#3B82F6', // Blue
    '#10B981', // Green
    '#F59E0B', // Amber
    '#EF4444', // Red
    '#8B5CF6', // Purple
    '#EC4899', // Pink
    '#6B7280', // Grey
    '#06B6D4', // Cyan
    '#14B8A6', // Teal
    '#F97316', // Orange
  ];

  @override
  State<HexColorPickerDialog> createState() => _HexColorPickerDialogState();
}

class _HexColorPickerDialogState extends State<HexColorPickerDialog> {
  late String _selectedHex;
  late TextEditingController _customHexCtrl;

  @override
  void initState() {
    super.initState();
    _selectedHex =
        widget.initialColor ?? HexColorPickerDialog.presetColors.first;
    _customHexCtrl = TextEditingController(text: _selectedHex);
  }

  @override
  void dispose() {
    _customHexCtrl.dispose();
    super.dispose();
  }

  Color _parseHex(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    try {
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (_) {
      return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(l10n.adminPickColor),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: HexColorPickerDialog.presetColors.map((hex) {
                final color = _parseHex(hex);
                final isSelected =
                    _selectedHex.toLowerCase() == hex.toLowerCase();
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedHex = hex;
                      _customHexCtrl.text = hex;
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white, size: 20)
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _customHexCtrl,
              decoration: InputDecoration(
                labelText: l10n.adminItemColor,
                hintText: l10n.adminColorHexHint,
                border: const OutlineInputBorder(),
              ),
              onChanged: (val) {
                setState(() => _selectedHex = val);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.adminCancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, _selectedHex),
          child: Text(l10n.adminSelect),
        ),
      ],
    );
  }
}

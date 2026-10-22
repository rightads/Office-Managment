import 'package:flutter/material.dart';

import 'package:right_ads/core/l10n/l10n.dart';

class GeoLocationPickerDialog extends StatefulWidget {
  const GeoLocationPickerDialog({
    this.initialLatitude,
    this.initialLongitude,
    this.initialRadius,
    super.key,
  });

  final double? initialLatitude;
  final double? initialLongitude;
  final double? initialRadius;

  @override
  State<GeoLocationPickerDialog> createState() =>
      _GeoLocationPickerDialogState();
}

class _GeoLocationPickerDialogState extends State<GeoLocationPickerDialog> {
  late TextEditingController _latCtrl;
  late TextEditingController _lngCtrl;
  late TextEditingController _radiusCtrl;

  @override
  void initState() {
    super.initState();
    _latCtrl = TextEditingController(
      text: widget.initialLatitude?.toString() ?? '28.6139',
    );
    _lngCtrl = TextEditingController(
      text: widget.initialLongitude?.toString() ?? '77.2090',
    );
    _radiusCtrl = TextEditingController(
      text: widget.initialRadius?.toString() ?? '100.0',
    );
  }

  @override
  void dispose() {
    _latCtrl.dispose();
    _lngCtrl.dispose();
    _radiusCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(l10n.adminLocationPickerDialogTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blue.withAlpha(20),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withAlpha(80)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on, size: 36, color: Colors.blue),
                    const SizedBox(height: 4),
                    Text(
                      l10n.adminGeofenceTarget,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _latCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: l10n.adminItemLatitude,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _lngCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: l10n.adminItemLongitude,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _radiusCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: l10n.adminItemRadius,
                border: const OutlineInputBorder(),
              ),
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
          onPressed: () {
            final lat = double.tryParse(_latCtrl.text);
            final lng = double.tryParse(_lngCtrl.text);
            final rad = double.tryParse(_radiusCtrl.text);
            if (lat != null && lng != null) {
              Navigator.pop(context, {
                'latitude': lat,
                'longitude': lng,
                'radius_meters': rad ?? 100.0,
              });
            }
          },
          child: Text(l10n.adminSelect),
        ),
      ],
    );
  }
}

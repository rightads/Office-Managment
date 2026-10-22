import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_colors.dart';
import '../application/master_data_controller.dart';
import '../domain/admin_models.dart';
import 'widgets/geo_location_picker_dialog.dart';
import 'widgets/hex_color_picker_dialog.dart';

class MasterDataCrudScreen extends ConsumerStatefulWidget {
  const MasterDataCrudScreen({
    required this.title,
    required this.basePath,
    super.key,
  });

  final String title;
  final String basePath;

  @override
  ConsumerState<MasterDataCrudScreen> createState() =>
      _MasterDataCrudScreenState();
}

class _MasterDataCrudScreenState extends ConsumerState<MasterDataCrudScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _search = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(masterDataControllerProvider(widget.basePath));
    final controller = ref.read(
      masterDataControllerProvider(widget.basePath).notifier,
    );
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    final filteredItems = state.items.where((i) {
      if (_search.isEmpty) return true;
      final q = _search.toLowerCase();
      final name = i.name?.toLowerCase() ?? '';
      final label = i.label?.toLowerCase() ?? '';
      final code = i.code?.toLowerCase() ?? '';
      final desc = i.description?.toLowerCase() ?? '';
      return name.contains(q) ||
          label.contains(q) ||
          code.contains(q) ||
          desc.contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.loadItems(widget.basePath),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: Text(l10n.adminAddNew),
        onPressed: () => _openItemDialog(null, controller, l10n),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: l10n.adminSearchInTitle(widget.title),
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              onChanged: (val) => setState(() => _search = val),
            ),
          ),
          Expanded(
            child: _buildBody(
              state,
              filteredItems,
              controller,
              isDesktop,
              l10n,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
    MasterDataState state,
    List<MasterDataItem> items,
    MasterDataController controller,
    bool isDesktop,
    AppLocalizations l10n,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.errorMessage!,
                style: const TextStyle(color: AppColors.error),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => controller.loadItems(widget.basePath),
                child: Text(l10n.adminClose),
              ),
            ],
          ),
        ),
      );
    }

    if (items.isEmpty) {
      return Center(child: Text(l10n.adminNoItemsFound));
    }

    return RefreshIndicator(
      onRefresh: () => controller.loadItems(widget.basePath),
      child: isDesktop
          ? _buildDataTable(items, controller, l10n)
          : _buildCardList(items, controller, l10n),
    );
  }

  Widget _buildDataTable(
    List<MasterDataItem> items,
    MasterDataController controller,
    AppLocalizations l10n,
  ) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text(l10n.adminItemName)),
            DataColumn(label: Text(l10n.adminItemCode)),
            DataColumn(label: Text(l10n.adminItemDescription)),
            DataColumn(label: Text(l10n.adminActionsHeader)),
          ],
          rows: items.map((i) {
            return DataRow(
              cells: [
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (i.color != null) ...[
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: _parseColor(i.color!),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(i.name ?? i.label ?? i.id),
                    ],
                  ),
                ),
                DataCell(Text(i.code ?? '-')),
                DataCell(Text(i.description ?? '-')),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        onPressed: () => _openItemDialog(i, controller, l10n),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          size: 20,
                          color: AppColors.error,
                        ),
                        onPressed: () => _confirmDelete(i, controller, l10n),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCardList(
    List<MasterDataItem> items,
    MasterDataController controller,
    AppLocalizations l10n,
  ) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, idx) {
        final i = items[idx];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: i.color != null
                ? Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: _parseColor(i.color!),
                      shape: BoxShape.circle,
                    ),
                  )
                : null,
            title: Text(
              i.name ?? i.label ?? i.code ?? i.id,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(i.description ?? i.address ?? i.code ?? ''),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () => _openItemDialog(i, controller, l10n),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    size: 20,
                    color: AppColors.error,
                  ),
                  onPressed: () => _confirmDelete(i, controller, l10n),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _parseColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    try {
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (_) {
      return Colors.blue;
    }
  }

  Future<void> _openItemDialog(
    MasterDataItem? item,
    MasterDataController controller,
    AppLocalizations l10n,
  ) async {
    final isEdit = item != null;
    final nameCtrl = TextEditingController(
      text: item?.name ?? item?.label ?? '',
    );
    final codeCtrl = TextEditingController(text: item?.code ?? '');
    final descCtrl = TextEditingController(text: item?.description ?? '');
    String? selectedColor = item?.color;
    double? lat = item?.latitude;
    double? lng = item?.longitude;
    double? rad = item?.radiusMeters;

    final isOfficeLoc = widget.basePath == '/office-locations';
    final hasColor =
        widget.basePath == '/task-statuses' ||
        widget.basePath == '/task-priorities' ||
        widget.basePath == '/attendance-statuses';

    final res = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlgState) => AlertDialog(
          title: Text(isEdit ? l10n.adminEditItem : l10n.adminAddNew),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.adminItemName,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                if (!isOfficeLoc) ...[
                  TextField(
                    controller: codeCtrl,
                    decoration: InputDecoration(
                      labelText: l10n.adminItemCode,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                TextField(
                  controller: descCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.adminItemDescription,
                    border: const OutlineInputBorder(),
                  ),
                ),
                if (hasColor) ...[
                  const SizedBox(height: 12),
                  ListTile(
                    title: Text(l10n.adminItemColor),
                    subtitle: Text(selectedColor ?? 'Default'),
                    trailing: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: selectedColor != null
                            ? _parseColor(selectedColor!)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                    onTap: () async {
                      final picked = await showDialog<String>(
                        context: context,
                        builder: (_) => HexColorPickerDialog(
                          initialColor: selectedColor,
                        ),
                      );
                      if (picked != null) {
                        setDlgState(() => selectedColor = picked);
                      }
                    },
                  ),
                ],
                if (isOfficeLoc) ...[
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.map),
                    label: Text(l10n.adminPickCoordinatesAndRadius),
                    onPressed: () async {
                      final picked = await showDialog<Map<String, double>>(
                        context: context,
                        builder: (_) => GeoLocationPickerDialog(
                          initialLatitude: lat,
                          initialLongitude: lng,
                          initialRadius: rad,
                        ),
                      );
                      if (picked != null) {
                        setDlgState(() {
                          lat = picked['latitude'];
                          lng = picked['longitude'];
                          rad = picked['radius_meters'];
                        });
                      }
                    },
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l10n.adminCancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l10n.adminSave),
            ),
          ],
        ),
      ),
    );

    if (res == true) {
      final data = <String, dynamic>{
        'name': nameCtrl.text.trim(),
        if (codeCtrl.text.isNotEmpty) 'code': codeCtrl.text.trim(),
        if (descCtrl.text.isNotEmpty) 'description': descCtrl.text.trim(),
        if (selectedColor != null) 'color': selectedColor,
        if (lat != null) 'latitude': lat,
        if (lng != null) 'longitude': lng,
        if (rad != null) 'radius_meters': rad,
      };

      if (isEdit) {
        final itemPath = '${widget.basePath}/${item!.id}';
        await controller.updateItem(itemPath, data);
      } else {
        await controller.createItem(widget.basePath, data);
      }
    }
  }

  Future<void> _confirmDelete(
    MasterDataItem item,
    MasterDataController controller,
    AppLocalizations l10n,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.adminDeleteItem),
        content: Text(l10n.adminDeleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.adminCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.adminConfirm),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final itemPath = '${widget.basePath}/${item.id}';
      await controller.deleteItem(itemPath);
    }
  }
}

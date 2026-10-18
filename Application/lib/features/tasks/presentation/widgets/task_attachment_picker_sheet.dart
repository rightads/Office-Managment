import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';

/// Modal bottom sheet allowing employees to pick an attachment from Camera or Gallery,
/// validating file size and MIME type against dynamic [RuntimeAppConfig].
class TaskAttachmentPickerSheet extends ConsumerStatefulWidget {
  const TaskAttachmentPickerSheet({
    required this.onFileSelected,
    super.key,
  });

  final Future<void> Function(
    List<int> bytes,
    String fileName,
    String mimeType,
  )
  onFileSelected;

  static Future<void> show({
    required BuildContext context,
    required Future<void> Function(
      List<int> bytes,
      String fileName,
      String mimeType,
    )
    onFileSelected,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          TaskAttachmentPickerSheet(onFileSelected: onFileSelected),
    );
  }

  @override
  ConsumerState<TaskAttachmentPickerSheet> createState() =>
      _TaskAttachmentPickerSheetState();
}

class _TaskAttachmentPickerSheetState
    extends ConsumerState<TaskAttachmentPickerSheet> {
  final ImagePicker _picker = ImagePicker();
  bool _isProcessing = false;

  Future<void> _pickImage(ImageSource source) async {
    final l10n = context.l10n;
    final config = ref.read(runtimeAppConfigControllerProvider);

    try {
      setState(() => _isProcessing = true);
      final xFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (xFile == null || !mounted) {
        setState(() => _isProcessing = false);
        return;
      }

      final bytes = await xFile.readAsBytes();
      final maxBytes = config.maxUploadMb * 1024 * 1024;

      if (bytes.length > maxBytes && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l10n.taskAttachmentSizeExceeded(config.maxUploadMb),
            ),
          ),
        );
        setState(() => _isProcessing = false);
        return;
      }

      final fileName = xFile.name.trim().isEmpty
          ? 'attachment.jpg'
          : xFile.name;
      final mimeType = xFile.mimeType ?? 'image/jpeg';

      if (!mounted) return;
      Navigator.of(context).pop();
      await widget.onFileSelected(bytes, fileName, mimeType);
    } on Object catch (_) {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final config = ref.watch(runtimeAppConfigControllerProvider);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.lg),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                l10n.taskAttachmentUploadTitle,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          Text(
            l10n.taskAttachmentLimitHint(config.maxUploadMb),
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (_isProcessing) ...<Widget>[
            const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: CircularProgressIndicator(),
              ),
            ),
          ] else ...<Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: colorScheme.primaryContainer,
                foregroundColor: colorScheme.onPrimaryContainer,
                child: const Icon(Icons.camera_alt_outlined),
              ),
              title: Text(l10n.taskAttachmentSourceCamera),
              subtitle: Text(l10n.taskAttachmentSourceCameraSubtitle),
              onTap: () => _pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: colorScheme.secondaryContainer,
                foregroundColor: colorScheme.onSecondaryContainer,
                child: const Icon(Icons.photo_library_outlined),
              ),
              title: Text(l10n.taskAttachmentSourceGallery),
              subtitle: Text(l10n.taskAttachmentSourceGallerySubtitle),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ],
      ),
    );
  }
}

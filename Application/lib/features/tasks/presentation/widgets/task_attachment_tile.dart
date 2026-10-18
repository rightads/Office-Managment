import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';
import 'package:url_launcher/url_launcher.dart';

/// Renders a single attachment item with file details, size, and open/download action.
class TaskAttachmentTile extends StatelessWidget {
  const TaskAttachmentTile({
    required this.attachment,
    super.key,
  });

  final TaskAttachmentModel attachment;

  static String formatBytes(int bytes) {
    if (bytes <= 0) return '0 B';
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  IconData _resolveFileIcon(String mime) {
    final lower = mime.toLowerCase();
    if (lower.startsWith('image/')) return Icons.image_outlined;
    if (lower.contains('pdf')) return Icons.picture_as_pdf_outlined;
    if (lower.contains('word') || lower.contains('doc')) {
      return Icons.description_outlined;
    }
    if (lower.contains('sheet') ||
        lower.contains('excel') ||
        lower.contains('csv')) {
      return Icons.table_chart_outlined;
    }
    if (lower.contains('zip') ||
        lower.contains('tar') ||
        lower.contains('compressed')) {
      return Icons.folder_zip_outlined;
    }
    return Icons.insert_drive_file_outlined;
  }

  Future<void> _openAttachment(BuildContext context) async {
    final uri = Uri.tryParse(attachment.downloadUrl);
    if (uri != null) {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.taskAttachmentOpenError),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final formattedTime = DateFormat(
      'd MMM y',
    ).format(attachment.createdAt.toLocal());
    final sizeStr = formatBytes(attachment.fileSizeBytes);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.6),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          child: Icon(_resolveFileIcon(attachment.mimeType)),
        ),
        title: Text(
          attachment.fileName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '$sizeStr • ${attachment.uploader.fullName} • $formattedTime',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.download_outlined),
          tooltip: l10n.taskAttachmentDownloadTooltip,
          onPressed: () => _openAttachment(context),
        ),
      ),
    );
  }
}

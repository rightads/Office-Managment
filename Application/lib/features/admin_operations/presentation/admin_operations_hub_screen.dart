import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/permissions/permission_codes.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/core/router/route_paths.dart';

class AdminOperationsHubScreen extends ConsumerWidget {
  const AdminOperationsHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.adminOperationsHubTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          if (ref.can(PermissionCodes.taskViewAll))
            Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.analytics, color: Colors.white),
                ),
                title: Text(
                  l10n.adminTaskReportsTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(l10n.adminTaskReportsSubtitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(RoutePaths.adminTaskReports),
              ),
            ),
          if (ref.can(PermissionCodes.leaveApprove))
            Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.flight_takeoff, color: Colors.white),
                ),
                title: Text(
                  l10n.adminLeaveApprovalsTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(l10n.adminLeaveApprovalsSubtitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(RoutePaths.adminLeaveApprovals),
              ),
            ),
          if (ref.can(PermissionCodes.announcementCreate))
            Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.deepOrange,
                  child: Icon(Icons.campaign, color: Colors.white),
                ),
                title: Text(
                  l10n.adminPublishAnnouncementTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(l10n.adminAnnouncementSubtitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(RoutePaths.adminAnnouncementPublish),
              ),
            ),
          if (ref.can(PermissionCodes.workReportsReview))
            Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.indigo,
                  child: Icon(Icons.assignment, color: Colors.white),
                ),
                title: Text(
                  l10n.adminWorkReportsReviewTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(l10n.adminWorkReportsReviewSubtitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(RoutePaths.adminWorkReportsReview),
              ),
            ),
        ],
      ),
    );
  }
}

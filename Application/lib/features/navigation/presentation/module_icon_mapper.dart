import 'package:flutter/material.dart';

/// Maps server-provided `icon_key` strings to Material 3 [IconData] pairs
/// (unselected + selected), with a safe fallback icon so unknown server keys
/// never fail or crash.
abstract final class ModuleIconMapper {
  static const IconData fallbackIcon = Icons.widgets_outlined;
  static const IconData fallbackSelectedIcon = Icons.widgets;

  static const Map<String, (IconData, IconData)> _iconMap =
      <String, (IconData, IconData)>{
        'home': (Icons.dashboard_outlined, Icons.dashboard),
        'attendance': (Icons.access_time_outlined, Icons.access_time_filled),
        'tasks': (Icons.task_alt_outlined, Icons.task_alt),
        'leave': (Icons.event_note_outlined, Icons.event_note),
        'work_reports': (Icons.assignment_outlined, Icons.assignment),
        'announcements': (Icons.campaign_outlined, Icons.campaign),
        'notifications': (Icons.notifications_outlined, Icons.notifications),
        'profile': (Icons.person_outline, Icons.person),
        'users': (Icons.group_outlined, Icons.group),
        'roles': (
          Icons.admin_panel_settings_outlined,
          Icons.admin_panel_settings,
        ),
        'settings': (Icons.settings_outlined, Icons.settings),
        'audit': (Icons.policy_outlined, Icons.policy),
        'clients': (Icons.business_outlined, Icons.business),
        'projects': (Icons.folder_outlined, Icons.folder),
        'leads': (Icons.contact_phone_outlined, Icons.contact_phone),
        'tickets': (Icons.support_agent_outlined, Icons.support_agent),
        'design': (Icons.palette_outlined, Icons.palette),
        'seo': (Icons.trending_up_outlined, Icons.trending_up),
        'gmb': (Icons.storefront_outlined, Icons.storefront),
        'invoices': (Icons.receipt_long_outlined, Icons.receipt_long),
        'recruitment': (Icons.badge_outlined, Icons.badge),
      };

  static IconData resolveIcon(String iconKey) {
    final normalized = iconKey.trim().toLowerCase();
    return _iconMap[normalized]?.$1 ?? fallbackIcon;
  }

  static IconData resolveSelectedIcon(String iconKey) {
    final normalized = iconKey.trim().toLowerCase();
    return _iconMap[normalized]?.$2 ?? fallbackSelectedIcon;
  }
}

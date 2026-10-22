import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/features/super_admin/domain/super_admin_models.dart';

void main() {
  group('Super Admin Models Tests', () {
    test('PermissionModel deserialization', () {
      final json = {
        'id': 'perm_1',
        'code': 'users.manage_roles',
        'description': 'Manage user roles and permissions',
      };

      final model = PermissionModel.fromJson(json);
      expect(model.id, 'perm_1');
      expect(model.code, 'users.manage_roles');
      expect(model.description, 'Manage user roles and permissions');
    });

    test('RoleDetailModel deserialization and system role check', () {
      final json = {
        'id': 'role_2',
        'name': 'Super Admin',
        'description': 'All permissions granted',
        'is_system': true,
        'user_count': 3,
        'permissions': [
          {
            'id': 'p1',
            'code': 'users.manage_roles',
            'description': 'Desc 1',
          },
          {
            'id': 'p2',
            'code': 'system.manage_settings',
            'description': 'Desc 2',
          },
        ],
      };

      final model = RoleDetailModel.fromJson(json);
      expect(model.id, 'role_2');
      expect(model.name, 'Super Admin');
      expect(model.isSystem, isTrue);
      expect(model.userCount, 3);
      expect(model.permissions.length, 2);
    });

    test('SystemSettingModel deserialization', () {
      final json = {
        'key': 'app.allow_registration',
        'value': 'false',
        'description': 'Allow open registration',
      };

      final model = SystemSettingModel.fromJson(json);
      expect(model.key, 'app.allow_registration');
      expect(model.value, 'false');
      expect(model.description, 'Allow open registration');
    });

    test('AuditLogItemModel deserialization with old/new data', () {
      final json = {
        'id': '42',
        'actor_id': 'user-123',
        'actor_email': 'admin@agency.com',
        'action': 'UPDATE',
        'entity_type': 'role',
        'entity_id': '2',
        'old_data': {'name': 'Old Role'},
        'new_data': {'name': 'New Role'},
        'ip_address': '127.0.0.1',
        'created_at': '2026-10-22T10:00:00Z',
      };

      final model = AuditLogItemModel.fromJson(json);
      expect(model.id, '42');
      expect(model.action, 'UPDATE');
      expect(model.oldData?['name'], 'Old Role');
      expect(model.newData?['name'], 'New Role');
    });

    test('NotificationTemplateModel deserialization', () {
      final json = {
        'id': 'tpl_5',
        'code': 'leave_approved',
        'title_template': 'Leave Approved: {{employee_name}}',
        'body_template':
            'Your leave request for {{days}} days has been approved.',
        'channel_push': true,
        'channel_email': false,
        'channel_sms': false,
        'is_active': true,
      };

      final model = NotificationTemplateModel.fromJson(json);
      expect(model.id, 'tpl_5');
      expect(model.code, 'leave_approved');
      expect(model.channelPush, isTrue);
      expect(model.channelEmail, isFalse);
    });
  });
}

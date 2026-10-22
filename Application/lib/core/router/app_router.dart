import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/widgets/dev_gallery_screen.dart';
import 'package:right_ads/core/widgets/splash_screen.dart';
import 'package:right_ads/features/admin/domain/admin_models.dart';
import 'package:right_ads/features/admin/presentation/employee_bulk_import_screen.dart';
import 'package:right_ads/features/admin/presentation/employee_detail_screen.dart';
import 'package:right_ads/features/admin/presentation/employee_form_screen.dart';
import 'package:right_ads/features/admin/presentation/employee_list_screen.dart';
import 'package:right_ads/features/admin/presentation/master_data_crud_screen.dart';
import 'package:right_ads/features/admin/presentation/master_data_hub_screen.dart';
import 'package:right_ads/features/admin_attendance/presentation/admin_attendance_dashboard_screen.dart';
import 'package:right_ads/features/admin_attendance/presentation/admin_employee_monthly_screen.dart';
import 'package:right_ads/features/admin_attendance/presentation/admin_employee_yearly_screen.dart';
import 'package:right_ads/features/admin_attendance/presentation/admin_monthly_overview_matrix_screen.dart';
import 'package:right_ads/features/admin_operations/presentation/admin_announcement_create_screen.dart';
import 'package:right_ads/features/admin_operations/presentation/admin_leave_approvals_screen.dart';
import 'package:right_ads/features/admin_operations/presentation/admin_operations_hub_screen.dart';
import 'package:right_ads/features/admin_operations/presentation/admin_task_reports_screen.dart';
import 'package:right_ads/features/admin_operations/presentation/admin_work_reports_review_screen.dart';
import 'package:right_ads/features/auth/application/session_controller.dart';
import 'package:right_ads/features/auth/domain/entities/auth_state.dart';
import 'package:right_ads/features/auth/presentation/force_change_password_screen.dart';
import 'package:right_ads/features/auth/presentation/forgot_password_screen.dart';
import 'package:right_ads/features/auth/presentation/login_screen.dart';
import 'package:right_ads/features/auth/presentation/reset_password_screen.dart';
import 'package:right_ads/features/communication/presentation/announcement_detail_screen.dart';
import 'package:right_ads/features/communication/presentation/announcements_screen.dart';
import 'package:right_ads/features/communication/presentation/notifications_screen.dart';
import 'package:right_ads/features/leaves/presentation/leave_detail_screen.dart';
import 'package:right_ads/features/leaves/presentation/leaves_screen.dart';
import 'package:right_ads/features/navigation/presentation/adaptive_shell_screen.dart';
import 'package:right_ads/features/navigation/presentation/forbidden_screen.dart';
import 'package:right_ads/features/navigation/presentation/force_update_screen.dart';
import 'package:right_ads/features/tasks/presentation/task_detail_screen.dart';
import 'package:right_ads/features/tasks/presentation/tasks_screen.dart';
import 'package:right_ads/features/work_reports/presentation/work_report_detail_screen.dart';
import 'package:right_ads/features/work_reports/presentation/work_reports_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final refreshListenable = ValueNotifier<int>(0);
  ref
    ..listen<AuthState>(
      sessionControllerProvider,
      (_, _) => refreshListenable.value++,
    )
    ..listen<RuntimeAppConfig>(
      runtimeAppConfigControllerProvider,
      (_, _) => refreshListenable.value++,
    )
    ..onDispose(refreshListenable.dispose);

  const unauthenticatedAllowedPaths = <String>{
    RoutePaths.login,
    RoutePaths.forgotPassword,
    RoutePaths.resetPassword,
  };

  return GoRouter(
    initialLocation: RoutePaths.splash,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final authState = ref.read(sessionControllerProvider);
      final config = ref.read(runtimeAppConfigControllerProvider);
      final currentPath = state.uri.path;

      if (config.forceUpdate && currentPath != RoutePaths.forceUpdate) {
        return RoutePaths.forceUpdate;
      }

      if (authState is AuthLoading) {
        return currentPath == RoutePaths.splash ? null : RoutePaths.splash;
      }

      if (authState is AuthUnauthenticated) {
        if (unauthenticatedAllowedPaths.contains(currentPath)) {
          return null;
        }
        return RoutePaths.login;
      }

      if (authState is AuthMustChangePassword) {
        return currentPath == RoutePaths.forceChangePassword
            ? null
            : RoutePaths.forceChangePassword;
      }

      if (authState is AuthAuthenticated) {
        if (unauthenticatedAllowedPaths.contains(currentPath) ||
            currentPath == RoutePaths.splash ||
            currentPath == RoutePaths.forceChangePassword) {
          return RoutePaths.home;
        }
        return null;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.forceUpdate,
        builder: (context, state) => const ForceUpdateScreen(),
      ),
      GoRoute(
        path: RoutePaths.forbidden,
        builder: (context, state) => const ForbiddenScreen(),
      ),
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: RoutePaths.resetPassword,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: RoutePaths.forceChangePassword,
        builder: (context, state) => const ForceChangePasswordScreen(),
      ),
      GoRoute(
        path: RoutePaths.home,
        builder: (context, state) => const AdaptiveShellScreen(),
      ),
      GoRoute(
        path: RoutePaths.tasks,
        builder: (context, state) => const TasksScreen(isRootNavigation: false),
      ),
      GoRoute(
        path: RoutePaths.taskDetail,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return TaskDetailScreen(taskId: id);
        },
      ),
      GoRoute(
        path: RoutePaths.leaves,
        builder: (context, state) => const LeavesScreen(),
      ),
      GoRoute(
        path: RoutePaths.leaveDetail,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return LeaveDetailScreen(leaveId: id);
        },
      ),
      GoRoute(
        path: RoutePaths.holidays,
        builder: (context, state) =>
            const LeavesScreen(initialTab: LeavesInitialTab.holidays),
      ),
      GoRoute(
        path: RoutePaths.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: RoutePaths.announcements,
        builder: (context, state) => const AnnouncementsScreen(),
      ),
      GoRoute(
        path: RoutePaths.announcementDetail,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return AnnouncementDetailScreen(announcementId: id);
        },
      ),
      GoRoute(
        path: RoutePaths.workReports,
        builder: (context, state) => const WorkReportsScreen(),
      ),
      GoRoute(
        path: RoutePaths.workReportDetail,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return WorkReportDetailScreen(reportId: id);
        },
      ),

      // Admin Routes (Prompt 12)
      GoRoute(
        path: RoutePaths.adminEmployees,
        builder: (context, state) => const EmployeeListScreen(),
      ),
      GoRoute(
        path: RoutePaths.adminEmployeeCreate,
        builder: (context, state) => const EmployeeFormScreen(),
      ),
      GoRoute(
        path: RoutePaths.adminEmployeesBulkImport,
        builder: (context, state) => const EmployeeBulkImportScreen(),
      ),
      GoRoute(
        path: RoutePaths.adminEmployeeDetailPattern,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return EmployeeDetailScreen(employeeId: id);
        },
      ),
      GoRoute(
        path: RoutePaths.adminEmployeeEditPattern,
        builder: (context, state) {
          final emp = state.extra is EmployeeItem
              ? state.extra as EmployeeItem
              : null;
          return EmployeeFormScreen(initialEmployee: emp);
        },
      ),
      GoRoute(
        path: RoutePaths.adminMasterDataHub,
        builder: (context, state) => const MasterDataHubScreen(),
      ),
      GoRoute(
        path: RoutePaths.adminMasterDataCrud,
        builder: (context, state) {
          final extra = state.extra is Map<String, dynamic>
              ? state.extra as Map<String, dynamic>
              : <String, dynamic>{};
          return MasterDataCrudScreen(
            title: extra['title'] as String? ?? 'Master Data',
            basePath: extra['basePath'] as String? ?? '/departments',
          );
        },
      ),

      // Admin Attendance & Reports (Prompt 13)
      GoRoute(
        path: RoutePaths.adminAttendanceDashboard,
        builder: (context, state) => const AdminAttendanceDashboardScreen(),
      ),
      GoRoute(
        path: RoutePaths.adminAttendanceMatrix,
        builder: (context, state) => const AdminMonthlyOverviewMatrixScreen(),
      ),
      GoRoute(
        path: RoutePaths.adminEmployeeMonthlyPattern,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return AdminEmployeeMonthlyScreen(employeeId: id);
        },
      ),
      GoRoute(
        path: RoutePaths.adminEmployeeYearlyPattern,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return AdminEmployeeYearlyScreen(employeeId: id);
        },
      ),

      // Admin Operations (Prompt 14)
      GoRoute(
        path: RoutePaths.adminOperationsHub,
        builder: (context, state) => const AdminOperationsHubScreen(),
      ),
      GoRoute(
        path: RoutePaths.adminTaskReports,
        builder: (context, state) => const AdminTaskReportsScreen(),
      ),
      GoRoute(
        path: RoutePaths.adminLeaveApprovals,
        builder: (context, state) => const AdminLeaveApprovalsScreen(),
      ),
      GoRoute(
        path: RoutePaths.adminAnnouncementPublish,
        builder: (context, state) => const AdminAnnouncementCreateScreen(),
      ),
      GoRoute(
        path: RoutePaths.adminWorkReportsReview,
        builder: (context, state) => const AdminWorkReportsReviewScreen(),
      ),

      if (kDebugMode)
        GoRoute(
          path: RoutePaths.devGallery,
          builder: (context, state) => const DevGalleryScreen(),
        ),
    ],
  );
}

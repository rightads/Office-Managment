import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/features/tasks/data/task_repository.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';

class _FakeHttpClientAdapter implements HttpClientAdapter {
  _FakeHttpClientAdapter(this._handler);

  final Future<ResponseBody> Function(RequestOptions options) _handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    return _handler(options);
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  group('TaskRepository Tests', () {
    late Dio dio;
    late TaskRepository repository;
    RequestOptions? capturedOptions;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'https://api.test.com/api/v1'));
      repository = TaskRepository(dio: dio);
    });

    test(
      'getMyTasks parses page response and passes query parameters correctly',
      () async {
        dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
          capturedOptions = options;
          final responseMap = {
            'items': [
              {
                'id': 'task-1',
                'title': 'Design Banner',
                'status': {
                  'id': 'st-1',
                  'code': 'in_progress',
                  'label': 'In Progress',
                  'color': '#3B82F6',
                  'order': 2,
                  'is_terminal': false,
                },
                'priority': {
                  'id': 'pr-1',
                  'code': 'high',
                  'label': 'High',
                  'color': '#EF4444',
                  'weight': 3,
                },
                'assigner': {
                  'id': 'u-1',
                  'employee_code': 'EMP001',
                  'full_name': 'Manager Bob',
                  'email': 'bob@agency.com',
                },
                'assignees': [
                  {
                    'id': 'u-2',
                    'employee_code': 'EMP002',
                    'full_name': 'Alice Designer',
                    'email': 'alice@agency.com',
                  },
                ],
                'due_at': '2026-10-25T18:00:00Z',
                'is_overdue': false,
                'is_active': true,
                'created_at': '2026-10-18T10:00:00Z',
                'updated_at': '2026-10-18T12:00:00Z',
              },
            ],
            'total': 1,
            'page': 1,
            'page_size': 20,
            'pages': 1,
          };
          return ResponseBody.fromString(
            jsonEncode(responseMap),
            200,
            headers: {
              Headers.contentTypeHeader: [Headers.jsonContentType],
            },
          );
        });

        final filter = TaskFilterState(
          search: 'Banner',
          statusId: 'st-1',
          priorityId: 'pr-1',
          departmentId: 'dept-1',
          clientId: 'cli-1',
          projectId: 'proj-1',
          dueFrom: DateTime.parse('2026-10-20T00:00:00Z'),
          dueTo: DateTime.parse('2026-10-30T00:00:00Z'),
          isOverdue: false,
        );

        final (response, failure) = await repository.getMyTasks(
          filter: filter,
        );

        expect(failure, isNull);
        expect(response, isNotNull);
        expect(response!.total, 1);
        expect(response.items.length, 1);
        expect(response.items.first.id, 'task-1');
        expect(response.items.first.title, 'Design Banner');
        expect(response.items.first.status.label, 'In Progress');
        expect(response.items.first.status.color, '#3B82F6');
        expect(response.items.first.priority.label, 'High');

        expect(capturedOptions?.queryParameters['search'], 'Banner');
        expect(capturedOptions?.queryParameters['status_id'], 'st-1');
        expect(capturedOptions?.queryParameters['priority_id'], 'pr-1');
        expect(capturedOptions?.queryParameters['department_id'], 'dept-1');
        expect(capturedOptions?.queryParameters['client_id'], 'cli-1');
        expect(capturedOptions?.queryParameters['project_id'], 'proj-1');
        expect(
          capturedOptions?.queryParameters['due_from'],
          '2026-10-20T00:00:00.000Z',
        );
        expect(
          capturedOptions?.queryParameters['due_to'],
          '2026-10-30T00:00:00.000Z',
        );
      },
    );

    test('getTaskDetail fetches single task successfully', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        final data = {
          'id': 'task-1',
          'title': 'Design Banner',
          'description': 'Create standard 300x250 web banner',
          'status': {
            'id': 'st-1',
            'code': 'open',
            'label': 'Open',
            'color': '#10B981',
            'order': 1,
            'is_terminal': false,
          },
          'priority': {
            'id': 'pr-1',
            'code': 'normal',
            'label': 'Normal',
            'color': '#3B82F6',
            'weight': 2,
          },
          'assigner': {
            'id': 'u-1',
            'employee_code': 'EMP001',
            'full_name': 'Manager Bob',
            'email': 'bob@agency.com',
          },
          'assignees': <Map<String, dynamic>>[],
          'is_active': true,
          'created_at': '2026-10-18T10:00:00Z',
          'updated_at': '2026-10-18T10:00:00Z',
        };
        return ResponseBody.fromString(
          jsonEncode(data),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final (task, failure) = await repository.getTaskDetail('task-1');
      expect(failure, isNull);
      expect(task, isNotNull);
      expect(task!.title, 'Design Banner');
      expect(task.description, 'Create standard 300x250 web banner');
    });

    test('getTaskStatuses returns server statuses in order', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        final data = <Map<String, dynamic>>[
          {
            'id': 'st-1',
            'code': 'todo',
            'label': 'Todo',
            'order': 1,
            'color': '#A3E635',
            'is_terminal': false,
          },
          {
            'id': 'st-2',
            'code': 'done',
            'label': 'Done',
            'order': 2,
            'color': '#22C55E',
            'is_terminal': true,
          },
        ];
        return ResponseBody.fromString(
          jsonEncode(data),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final (statuses, failure) = await repository.getTaskStatuses();
      expect(failure, isNull);
      expect(statuses, isNotNull);
      expect(statuses!.length, 2);
      expect(statuses.first.label, 'Todo');
      expect(statuses.last.isTerminal, true);
    });

    test(
      'updateTaskStatus posts correct payload and returns updated task',
      () async {
        dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
          capturedOptions = options;
          final data = {
            'id': 'task-1',
            'title': 'Design Banner',
            'status': {
              'id': 'st-done',
              'code': 'completed',
              'label': 'Completed',
              'color': '#22C55E',
              'order': 3,
              'is_terminal': true,
            },
            'priority': {
              'id': 'pr-1',
              'code': 'high',
              'label': 'High',
              'color': '#EF4444',
              'weight': 3,
            },
            'completed_at': '2026-10-18T18:00:00Z',
            'assigner': {
              'id': 'u-1',
              'employee_code': 'EMP001',
              'full_name': 'Manager Bob',
              'email': 'bob@agency.com',
            },
            'assignees': <Map<String, dynamic>>[],
            'is_active': true,
            'created_at': '2026-10-18T10:00:00Z',
            'updated_at': '2026-10-18T18:00:00Z',
          };
          return ResponseBody.fromString(
            jsonEncode(data),
            200,
            headers: {
              Headers.contentTypeHeader: [Headers.jsonContentType],
            },
          );
        });

        final (task, failure) = await repository.updateTaskStatus(
          taskId: 'task-1',
          toStatusId: 'st-done',
          remarks: 'All banner assets delivered.',
        );

        expect(failure, isNull);
        expect(task, isNotNull);
        expect(task!.status.id, 'st-done');
        expect(task.completedAt, DateTime.parse('2026-10-18T18:00:00Z'));
        expect(capturedOptions?.data, {
          'to_status_id': 'st-done',
          'remarks': 'All banner assets delivered.',
        });
      },
    );

    test('addTaskComment posts comment and returns created model', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final data = {
          'id': 'comm-1',
          'task_id': 'task-1',
          'author': {
            'id': 'u-2',
            'employee_code': 'EMP002',
            'full_name': 'Alice Designer',
            'email': 'alice@agency.com',
          },
          'comment': 'Draft v1 uploaded for review.',
          'created_at': '2026-10-18T14:30:00Z',
        };
        return ResponseBody.fromString(
          jsonEncode(data),
          201,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final (comment, failure) = await repository.addTaskComment(
        taskId: 'task-1',
        comment: 'Draft v1 uploaded for review.',
      );

      expect(failure, isNull);
      expect(comment, isNotNull);
      expect(comment!.id, 'comm-1');
      expect(comment.comment, 'Draft v1 uploaded for review.');
      expect(capturedOptions?.data, {
        'comment': 'Draft v1 uploaded for review.',
      });
    });

    test('uploadTaskAttachment posts FormData correctly', () async {
      dio.httpClientAdapter = _FakeHttpClientAdapter((options) async {
        capturedOptions = options;
        final data = {
          'id': 'att-1',
          'task_id': 'task-1',
          'file_name': 'mockup.png',
          'file_size_bytes': 1024,
          'mime_type': 'image/png',
          'download_url': 'https://s3.example.com/mockup.png',
          'uploader': {
            'id': 'u-2',
            'employee_code': 'EMP002',
            'full_name': 'Alice Designer',
            'email': 'alice@agency.com',
          },
          'created_at': '2026-10-18T15:00:00Z',
        };
        return ResponseBody.fromString(
          jsonEncode(data),
          201,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final bytes = Uint8List.fromList([1, 2, 3, 4]);
      final (attachment, failure) = await repository.uploadTaskAttachment(
        taskId: 'task-1',
        fileBytes: bytes,
        fileName: 'mockup.png',
      );

      expect(failure, isNull);
      expect(attachment, isNotNull);
      expect(attachment!.fileName, 'mockup.png');
      expect(capturedOptions?.data, isA<FormData>());
    });
  });
}

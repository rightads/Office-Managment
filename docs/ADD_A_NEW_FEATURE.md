# Developer Guide: Adding a New Feature

This step-by-step tutorial demonstrates how to add a new feature to the Right Ads mobile application following the Part B non-negotiable architectural rules.

---

## 1. Register Permission Codes

If the feature requires permission gating, register its permission code in `lib/core/permissions/permission_codes.dart`. This catalog must strictly mirror backend permissions:

```dart
abstract final class PermissionCodes {
  // Existing permissions...
  
  // New feature permissions
  static const String invoicesView = 'invoices.view';
  static const String invoicesCreate = 'invoices.create';
}
```

Verify contract compliance by running:
```bash
flutter test test/core/network/openapi_contract_test.dart
```

---

## 2. Implement Feature Layers

Create a new directory in `lib/features/<feature_name>/`:

### A. Domain Layer (`domain/`)
Create Freezed models and business validators. Never use Flutter UI dependencies here:

```dart
// lib/features/invoices/domain/invoice_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_models.freezed.dart';
part 'invoice_models.g.dart';

@freezed
abstract class InvoiceModel with _$InvoiceModel {
  const factory InvoiceModel({
    required String id,
    @JsonKey(name: 'invoice_number') required String invoiceNumber,
    required double amount,
    required String status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _InvoiceModel;

  factory InvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceModelFromJson(json);
}
```

### B. Data Layer (`data/`)
Create the repository and its Riverpod provider:

```dart
// lib/features/invoices/data/invoice_repository.dart
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:right_ads/core/network/dio_provider.dart';
import '../domain/invoice_models.dart';

part 'invoice_repository.g.dart';

class InvoiceRepository {
  InvoiceRepository(this._dio);
  final Dio _dio;

  Future<List<InvoiceModel>> getInvoices() async {
    final response = await _dio.get<List<dynamic>>('/api/v1/invoices');
    return response.data!
        .map((e) => InvoiceModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

@Riverpod(keepAlive: true)
InvoiceRepository invoiceRepository(Ref ref) {
  return InvoiceRepository(ref.watch(dioProvider));
}
```

### C. Application Layer (`application/`)
Create the Riverpod controller and UI state:

```dart
// lib/features/invoices/application/invoice_list_controller.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/invoice_repository.dart';
import '../domain/invoice_models.dart';

part 'invoice_list_controller.freezed.dart';
part 'invoice_list_controller.g.dart';

@freezed
abstract class InvoiceListState with _$InvoiceListState {
  const factory InvoiceListState({
    @Default(<InvoiceModel>[]) List<InvoiceModel> invoices,
    @Default(true) bool isLoading,
    String? errorMessage,
  }) = _InvoiceListState;
}

@riverpod
class InvoiceListController extends _$InvoiceListController {
  @override
  InvoiceListState build() {
    state = const InvoiceListState();
    loadInvoices();
    return state;
  }

  Future<void> loadInvoices() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final items = await ref.read(invoiceRepositoryProvider).getInvoices();
      state = state.copyWith(invoices: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}
```

### D. Presentation Layer (`presentation/`)
1. **Localization**: Add any new UI string keys to `lib/core/l10n/arb/app_en.arb`:
   ```json
   "invoicesTitle": "Invoices",
   "@invoicesTitle": { "description": "Title for invoices screen" }
   ```
2. **Build Screen**:
   ```dart
   // lib/features/invoices/presentation/invoice_list_screen.dart
   import 'package:flutter/material.dart';
   import 'package:flutter_riverpod/flutter_riverpod.dart';
   import 'package:right_ads/core/l10n/l10n.dart';
   import 'package:right_ads/core/permissions/permission_gate.dart';
   import 'package:right_ads/core/permissions/permission_codes.dart';
   import '../application/invoice_list_controller.dart';

   class InvoiceListScreen extends ConsumerWidget {
     const InvoiceListScreen({super.key});

     @override
     Widget build(BuildContext context, WidgetRef ref) {
       final l10n = context.l10n;
       final state = ref.watch(invoiceListControllerProvider);

       return Scaffold(
         appBar: AppBar(title: Text(l10n.invoicesTitle)),
         body: state.isLoading
             ? const Center(child: CircularProgressIndicator())
             : ListView.builder(
                 itemCount: state.invoices.length,
                 itemBuilder: (context, index) {
                   final inv = state.invoices[index];
                   return ListTile(
                     title: Text(inv.invoiceNumber),
                     subtitle: Text('\$${inv.amount.toStringAsFixed(2)}'),
                   );
                 },
               ),
         floatingActionButton: PermissionGate(
           permission: PermissionCodes.invoicesCreate,
           child: FloatingActionButton(
             onPressed: () {/* Navigate to create */},
             child: const Icon(Icons.add),
           ),
         ),
       );
     }
   }
   ```

---

## 3. Register Route in `AppRouter`

In `lib/core/navigation/app_router.dart`:
```dart
GoRoute(
  path: '/invoices',
  name: 'invoices',
  builder: (context, state) => const InvoiceListScreen(),
),
```

---

## 4. Run Code Generation & Quality Checks

Always execute code generation and strict quality checks:
```bash
# 1. Generate Freezed & Riverpod files
dart run build_runner build --delete-conflicting-outputs

# 2. Format code
dart format .

# 3. Analyze for strict lints
flutter analyze --fatal-infos --fatal-warnings

# 4. Verify no hardcoded user strings crept into widgets
flutter test test/core/l10n/no_hardcoded_strings_test.dart

# 5. Run full test suite with coverage
flutter test --coverage
```

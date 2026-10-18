import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('No Hardcoded User-Facing Strings in Widgets (Part B Rule 1)', () {
    final disallowedPatterns = <String, RegExp>{
      'Text("...") literal': RegExp(
        r'''\bText\s*\(\s*(['"])(?!\$)[^'"]+\1''',
      ),
      'Tooltip(message: "...") literal': RegExp(
        r'''\bTooltip\s*\([^)]*\bmessage\s*:\s*(['"])[^'"]+\1''',
      ),
      'Semantics(label: "...") literal': RegExp(
        r'''\bSemantics\s*\([^)]*\blabel\s*:\s*(['"])[^'"]+\1''',
      ),
      'InputDecoration(labelText/hintText/helperText/errorText: "...") literal':
          RegExp(
            r'''\b(labelText|hintText|helperText|errorText)\s*:\s*(['"])[^'"]+\2''',
          ),
      'AppBar(title: Text("...")) literal': RegExp(
        r'''\btitle\s*:\s*(const\s+)?Text\s*\(\s*(['"])[^'"]+\2''',
      ),
    };

    test('widget and presentation files contain zero raw UI string literals', () {
      final libDir = Directory('lib');
      expect(libDir.existsSync(), isTrue);

      final violations = <String>[];

      for (final entity in libDir.listSync(recursive: true)) {
        if (entity is! File || !entity.path.endsWith('.dart')) continue;

        final normalizedPath = entity.path.replaceAll(r'\', '/');
        if (normalizedPath.endsWith('.g.dart') ||
            normalizedPath.endsWith('.freezed.dart') ||
            normalizedPath.contains('/l10n/generated/')) {
          continue;
        }

        final isWidgetOrPresentationFile =
            normalizedPath.contains('/widgets/') ||
            normalizedPath.contains('/presentation/') ||
            normalizedPath.endsWith('lib/app.dart');

        if (!isWidgetOrPresentationFile) continue;

        final content = entity.readAsStringSync();
        for (final entry in disallowedPatterns.entries) {
          final matches = entry.value.allMatches(content);
          for (final match in matches) {
            violations.add(
              '$normalizedPath -> ${entry.key}: ${match.group(0)}',
            );
          }
        }
      }

      expect(
        violations,
        isEmpty,
        reason:
            'Found raw user-facing string literals in widgets. Move all strings to ARB files:\n${violations.join('\n')}',
      );
    });
  });
}

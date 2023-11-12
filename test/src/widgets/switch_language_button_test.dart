import 'package:appflowy_code_block/appflowy_code_block.dart';
import 'package:appflowy_code_block/src/service/actions_service.dart';
import 'package:appflowy_code_block/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import '../../helpers/pump_app.dart';

void main() {
  final node = codeBlockNode(language: 'dart');
  final editorState = EditorState.blank();
  final actionsService = ActionsService(editorState: editorState, node: node);

  group('SwitchLanguageButton', () {
    Widget buildSubject() {
      return SizedBox(
        width: 200,
        height: 200,
        child: SwitchLanguageButton(
          editorState: editorState,
          actionsService: actionsService,
        ),
      );
    }

    group('constructor', () {
      test('works properly', () {
        expect(
          buildSubject,
          returnsNormally,
        );
      });
    });

    group('renders properly', () {
      testWidgets(' if not yet clicked', (tester) async {
        await tester.pumpWidgetInApp(buildSubject());

        expect(find.byType(ButtonWithTrailingIcon), findsOneWidget);
        expect(find.byType(FullScreenOverlayEntry), findsNothing);
        expect(find.byType(SelectableItemListMenu), findsNothing);
      });
    });
  });
}

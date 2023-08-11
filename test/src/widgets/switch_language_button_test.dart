import 'package:code_block/src/service/actions_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:code_block/code_block.dart';
import 'package:code_block/src/widgets/widgets.dart';
import 'package:flowy_infra_ui/flowy_infra_ui.dart';

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

    group('popover', () {
      testWidgets('renders properly', (tester) async {
        await tester.pumpWidgetInApp(buildSubject());

        expect(find.byType(SwitchLanguageButton), findsOneWidget);
        expect(find.byType(AppFlowyPopover), findsOneWidget);
        expect(find.byType(FlowyTextButton), findsOneWidget);
        expect(find.byType(SelectableItemListMenu), findsNothing);
      });

      testWidgets('shows language menu', (tester) async {
        await tester.pumpWidgetInApp(buildSubject());

        await tester.tap(find.byType(FlowyTextButton));
        await tester.pumpAndSettle();
        expect(find.byType(SelectableItemListMenu), findsOneWidget);
      });

      testWidgets('shows language option', (tester) async {
        await tester.pumpWidgetInApp(buildSubject());

        await tester.tap(find.byType(FlowyTextButton));
        await tester.pumpAndSettle();

        expect(find.byType(SelectableItem), findsAtLeastNWidgets(1));

        //finds a selectableItem widget with text languages[1]
        final languageOption = find.descendant(
          of: find.byType(SelectableItem),
          matching: find.text(languages[1], findRichText: true),
        );

        expect(languageOption, findsOneWidget);

        //TODO: clicking the language option should close the popup.

        // await tester.tap(languageOption);

        // await tester.pumpAndSettle();
        // expect(find.byType(SelectableItemListMenu), findsNothing);
      });
    });
  });
}

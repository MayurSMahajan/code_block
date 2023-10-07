import 'dart:io';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:code_block/code_block.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/infra/testable_editor.dart';

void main() {
  group('navigation_commands...', () {
    group('only move', () {
      group('to the start', () {
        testWidgets('from end, in single line codeblock', (tester) async {
          const text = "initial code";
          final initialCodeblockDelta = Delta()..insert(text);
          final editor = tester.editor
            ..initializeWithCodeblock(
              delta: initialCodeblockDelta,
            );

          await editor.startTesting();

          expect(editor.documentRootLen, 1);

          final node = editor.nodeAtPath([0]);
          expect(node, isNotNull);
          expect(node!.type, CodeBlockKeys.type);
          expect(node.delta!.toPlainText(), text);

          await editor.updateSelection(
            Selection.collapsed(Position(path: [0], offset: text.length)),
          );

          expect(
            editor.editorState.selection,
            Selection.collapsed(
              Position(path: [0], offset: text.length),
            ),
          );

          // type shift in windows/linux and cmd + arrow left in mac
          await pressNavigatingKey(editor);

          await tester.pumpAndSettle();

          expect(
            editor.editorState.selection,
            Selection.collapsed(
              Position(path: [0], offset: 0),
            ),
          );

          await editor.dispose();
        });

        testWidgets('from middle, in single line codeblock', (tester) async {
          const text = "initial code";
          final initialCodeblockDelta = Delta()..insert(text);
          final editor = tester.editor
            ..initializeWithCodeblock(
              delta: initialCodeblockDelta,
            );

          await editor.startTesting();

          await editor.updateSelection(
            Selection.collapsed(
              Position(
                path: [0],
                offset: (text.length / 2).truncate(),
              ),
            ),
          );

          expect(
            editor.editorState.selection,
            Selection.collapsed(
              Position(
                path: [0],
                offset: (text.length / 2).truncate(),
              ),
            ),
          );

          // type shift in windows/linux and cmd + arrow left in mac
          await pressNavigatingKey(editor);

          await tester.pumpAndSettle();

          expect(
            editor.editorState.selection,
            Selection.collapsed(
              Position(
                path: [0],
                offset: 0,
              ),
            ),
          );

          await editor.dispose();
        });

        // before adding these navigation shortcuts
        // pressing home from the end of the last line of codeblock, would have
        // navigated to the start of the first line
        //
        // but now we expect it to go to the start of its own line.
        // note multiple lines in codblock are treated as the same path.
        testWidgets('from end, in multiline codeblock', (tester) async {
          const text = "initial\ncode";
          final initialCodeblockDelta = Delta()..insert(text);
          final editor = tester.editor
            ..initializeWithCodeblock(
              delta: initialCodeblockDelta,
            );

          await editor.startTesting();

          await editor.updateSelection(
            Selection.collapsed(Position(path: [0], offset: text.length)),
          );

          expect(
            editor.editorState.selection,
            Selection.collapsed(Position(path: [0], offset: text.length)),
          );

          // type shift in windows/linux and cmd + arrow left in mac
          await pressNavigatingKey(editor);

          await tester.pumpAndSettle();

          // we expect offset 8 since that is where the line break is.
          expect(
            editor.editorState.selection,
            Selection.collapsed(
              Position(
                path: [0],
                offset: 8,
              ),
            ),
          );

          await editor.dispose();
        });
      });

      group('to the end', () {
        testWidgets('from start, in single line codeblock', (tester) async {
          const text = "initial code";
          final initialCodeblockDelta = Delta()..insert(text);
          final editor = tester.editor
            ..initializeWithCodeblock(
              delta: initialCodeblockDelta,
            );

          await editor.startTesting();

          await editor.updateSelection(
            Selection.collapsed(Position(path: [0], offset: 0)),
          );

          expect(
            editor.editorState.selection,
            Selection.collapsed(Position(path: [0], offset: 0)),
          );

          // type shift in windows/linux and cmd + arrow left in mac
          await pressNavigatingKey(editor, moveToEnd: true);

          await tester.pumpAndSettle();

          expect(
            editor.editorState.selection,
            Selection.collapsed(
              Position(path: [0], offset: text.length),
            ),
          );

          await editor.dispose();
        });

        testWidgets('from start, in multiline codeblock', (tester) async {
          const text = "initial\ncode";
          final initialCodeblockDelta = Delta()..insert(text);
          final editor = tester.editor
            ..initializeWithCodeblock(
              delta: initialCodeblockDelta,
            );

          await editor.startTesting();

          await editor.updateSelection(
            Selection.collapsed(Position(path: [0], offset: 0)),
          );

          expect(
            editor.editorState.selection,
            Selection.collapsed(Position(path: [0], offset: 0)),
          );

          // type shift in windows/linux and cmd + arrow left in mac
          await pressNavigatingKey(editor, moveToEnd: true);

          await tester.pumpAndSettle();

          // we expect offset 7 since that is where the line break is.
          expect(
            editor.editorState.selection,
            Selection.collapsed(
              Position(
                path: [0],
                offset: 7,
              ),
            ),
          );

          await editor.dispose();
        });
      });
    });

    group('move and select', () {
      group('to the start', () {
        testWidgets('from end, in single line codeblock', (tester) async {
          const text = "initial code";
          final initialCodeblockDelta = Delta()..insert(text);
          final editor = tester.editor
            ..initializeWithCodeblock(
              delta: initialCodeblockDelta,
            );

          await editor.startTesting();

          await editor.updateSelection(
            Selection.collapsed(Position(path: [0], offset: text.length)),
          );

          expect(
            editor.editorState.selection,
            Selection.collapsed(Position(path: [0], offset: text.length)),
          );

          // type shift in windows/linux and cmd + arrow left in mac
          await pressNavigatingKey(editor, shouldSelect: true);

          await tester.pumpAndSettle();

          expect(
            editor.editorState.selection,
            Selection.single(path: [0], startOffset: 0, endOffset: text.length),
          );

          await editor.dispose();
        });

        testWidgets('from end, in multiline codeblock', (tester) async {
          const text = "initial\ncode";
          final initialCodeblockDelta = Delta()..insert(text);
          final editor = tester.editor
            ..initializeWithCodeblock(
              delta: initialCodeblockDelta,
            );

          await editor.startTesting();

          await editor.updateSelection(
            Selection.collapsed(Position(path: [0], offset: text.length)),
          );

          expect(
            editor.editorState.selection,
            Selection.collapsed(Position(path: [0], offset: text.length)),
          );

          // type shift in windows/linux and cmd + arrow left in mac
          await pressNavigatingKey(editor, shouldSelect: true);

          await tester.pumpAndSettle();

          // we expect offset 8 since that is where the line break is.
          expect(
            editor.editorState.selection,
            Selection.single(
              path: [0],
              startOffset: 8,
              endOffset: text.length,
            ),
          );

          await editor.dispose();
        });
      });

      group('to the end', () {
        testWidgets('from start, in single line codeblock', (tester) async {
          const text = "initial code";
          final initialCodeblockDelta = Delta()..insert(text);
          final editor = tester.editor
            ..initializeWithCodeblock(
              delta: initialCodeblockDelta,
            );

          await editor.startTesting();

          await editor.updateSelection(
            Selection.collapsed(Position(path: [0], offset: 0)),
          );

          expect(
            editor.editorState.selection,
            Selection.collapsed(Position(path: [0], offset: 0)),
          );

          // type shift in windows/linux and cmd + arrow left in mac
          await pressNavigatingKey(editor, shouldSelect: true, moveToEnd: true);

          await tester.pumpAndSettle();

          expect(
            editor.editorState.selection,
            Selection.single(path: [0], startOffset: 0, endOffset: text.length),
          );

          await editor.dispose();
        });

        testWidgets('from start, in multiline codeblock', (tester) async {
          const text = "initial\ncode";
          final initialCodeblockDelta = Delta()..insert(text);
          final editor = tester.editor
            ..initializeWithCodeblock(
              delta: initialCodeblockDelta,
            );

          await editor.startTesting();

          await editor.updateSelection(
            Selection.collapsed(Position(path: [0], offset: 0)),
          );

          expect(
            editor.editorState.selection,
            Selection.collapsed(Position(path: [0], offset: 0)),
          );

          // type shift in windows/linux and cmd + arrow left in mac
          await pressNavigatingKey(editor, shouldSelect: true, moveToEnd: true);

          await tester.pumpAndSettle();

          // we expect offset 8 since that is where the line break is.
          expect(
            editor.editorState.selection,
            Selection.single(
              path: [0],
              startOffset: 0,
              endOffset: 7,
            ),
          );

          await editor.dispose();
        });
      });
    });
  });
}

Future<void> pressNavigatingKey(
  TestableEditor editor, {
  bool shouldSelect = false,
  bool moveToEnd = false,
}) async {
  if (moveToEnd) {
    await editor.pressKey(
      key: Platform.isMacOS
          ? LogicalKeyboardKey.arrowRight
          : LogicalKeyboardKey.end,
      isMetaPressed: Platform.isMacOS,
      isShiftPressed: shouldSelect,
    );
  } else {
    await editor.pressKey(
      key: Platform.isMacOS
          ? LogicalKeyboardKey.arrowLeft
          : LogicalKeyboardKey.home,
      isMetaPressed: Platform.isMacOS,
      isShiftPressed: shouldSelect,
    );
  }
}

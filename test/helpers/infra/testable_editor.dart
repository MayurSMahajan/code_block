import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_editor/src/editor/editor_component/service/ime/text_input_service.dart';
import 'package:appflowy_code_block/appflowy_code_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_test/flutter_test.dart';

import '../util/util.dart';

class TestableEditor {
  TestableEditor({
    required this.tester,
  });

  final WidgetTester tester;

  EditorState get editorState => _editorState;
  late EditorState _editorState;

  Document get document => _editorState.document;
  int get documentRootLen => document.root.children.length;

  Selection? get selection => _editorState.selection;

  MockIMEInput? _ime;
  MockIMEInput get ime {
    return _ime ??= MockIMEInput(
      editorState: editorState,
      tester: tester,
    );
  }

  final appFlowyEditorLocalizations =
      AppFlowyEditorLocalizations.load(const Locale('en'));

  final List<SelectionMenuItem> slashMenuItems = [
    ...standardSelectionMenuItems,
    codeBlockItem,
  ];

  List<CharacterShortcutEvent> get characterShortcutEvents => [
        // code block
        ...codeBlockCharacterEvents,

        // customize the slash menu command
        customSlashCommand(
          slashMenuItems,
        ),

        ...standardCharacterShortcutEvents
          ..removeWhere(
            (element) => element == slashCommand,
          ), // remove the default slash command.
      ];

  final List<CommandShortcutEvent> commandShortcutEvents = [
    ...codeBlockCommandEvents,
    ...standardCommandShortcutEvents,
  ];

  Future<TestableEditor> startTesting({
    Locale locale = const Locale('en'),
    bool autoFocus = false,
    bool editable = true,
    bool shrinkWrap = false,
    bool withFloatingToolbar = false,
    bool inMobile = false,
    ScrollController? scrollController,
    Widget Function(Widget child)? wrapper,
    TargetPlatform? platform,
  }) async {
    Map<String, BlockComponentBuilder> blockComponentBuilders =
        _customBlockComponentBuilders(editorState);

    if (withFloatingToolbar) {
      scrollController ??= ScrollController();
    }

    final editorScrollController = EditorScrollController(
      editorState: editorState,
      shrinkWrap: shrinkWrap,
      scrollController: scrollController,
    );

    Widget editor = AppFlowyEditor(
      editorState: editorState,
      editable: editable,
      characterShortcutEvents: characterShortcutEvents,
      commandShortcutEvents: commandShortcutEvents,
      blockComponentBuilders: blockComponentBuilders,
      autoFocus: autoFocus,
      shrinkWrap: shrinkWrap,
      editorScrollController: editorScrollController,
      editorStyle:
          inMobile ? const EditorStyle.mobile() : const EditorStyle.desktop(),
    );
    if (withFloatingToolbar) {
      if (inMobile) {
        final items = [
          textDecorationMobileToolbarItem,
          headingMobileToolbarItem,
          todoListMobileToolbarItem,
          listMobileToolbarItem,
          linkMobileToolbarItem,
          quoteMobileToolbarItem,
          codeMobileToolbarItem,
        ];
        editor = Column(
          children: [
            Expanded(
              child: AppFlowyEditor(
                editorStyle: const EditorStyle.mobile(),
                editorState: editorState,
                editorScrollController: editorScrollController,
              ),
            ),
            MobileToolbar(
              editorState: editorState,
              toolbarItems: items,
            ),
          ],
        );
      } else {
        editor = FloatingToolbar(
          items: [
            paragraphItem,
            ...headingItems,
            ...markdownFormatItems,
            quoteItem,
            bulletedListItem,
            numberedListItem,
            linkItem,
            buildTextColorItem(),
            buildHighlightColorItem()
          ],
          editorState: editorState,
          editorScrollController: editorScrollController,
          textDirection: null,
          child: editor,
        );
      }
    }

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(platform: platform),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          AppFlowyEditorLocalizations.delegate,
        ],
        supportedLocales: AppFlowyEditorLocalizations.delegate.supportedLocales,
        locale: locale,
        home: Scaffold(
          body: wrapper == null
              ? editor
              : wrapper(
                  editor,
                ),
        ),
      ),
    );
    await tester.pump();
    return this;
  }

  void initialize() {
    _editorState = EditorState(
      document: Document.blank(),
    );
  }

  void initializeWithDocment(Document document) {
    _editorState = EditorState(
      document: document,
    );
  }

  void initializeWithCodeblock({Delta? delta, String? language}) {
    _editorState = EditorState(
        document: Document(
      root: pageNode(
        children: [
          codeBlockNode(
            delta: delta,
            language: language,
          ),
        ],
      ),
    ));
  }

  Future<void> dispose() async {
    _ime = null;
    // Workaround: to wait all the debounce calls expire.
    //  https://github.com/flutter/flutter/issues/11181#issuecomment-568737491
    await tester.pumpAndSettle(const Duration(seconds: 1));
  }

  void addNode(Node node) {
    _editorState.document.root.insert(node);
  }

  void addParagraph({
    TextBuilder? builder,
    String? initialText,
    NodeDecorator? decorator,
  }) {
    addParagraphs(
      1,
      builder: builder,
      initialText: initialText,
      decorator: decorator,
    );
  }

  void addParagraphs(
    int count, {
    TextBuilder? builder,
    String? initialText,
    NodeDecorator? decorator,
  }) {
    _editorState.document.addParagraphs(
      count,
      builder: builder,
      initialText: initialText,
      decorator: decorator,
    );
  }

  void addEmptyParagraph() {
    _editorState.document.addParagraph(initialText: '');
  }

  Future<void> updateSelection(Selection? selection) async {
    _editorState.updateSelectionWithReason(
      selection,
      reason: SelectionUpdateReason.uiEvent,
    );
    await tester.pumpAndSettle();
  }

  Node? nodeAtPath(Path path) {
    return _editorState.getNodeAtPath(path);
  }

  final keyToCharacterMap = {
    LogicalKeyboardKey.space: ' ',
    LogicalKeyboardKey.backquote: '`',
    LogicalKeyboardKey.tilde: '~',
    LogicalKeyboardKey.asterisk: '*',
    LogicalKeyboardKey.underscore: '_',
  };
  Future<void> pressKey({
    String? character,
    LogicalKeyboardKey? key,
    bool isControlPressed = false,
    bool isShiftPressed = false,
    bool isAltPressed = false,
    bool isMetaPressed = false,
  }) async {
    if (key != null) {
      if (isControlPressed) {
        await simulateKeyDownEvent(LogicalKeyboardKey.control);
      }
      if (isShiftPressed) {
        await simulateKeyDownEvent(LogicalKeyboardKey.shift);
      }
      if (isAltPressed) {
        await simulateKeyDownEvent(LogicalKeyboardKey.alt);
      }
      if (isMetaPressed) {
        await simulateKeyDownEvent(LogicalKeyboardKey.meta);
      }
      if (keyToCharacterMap.containsKey(key)) {
        final character = keyToCharacterMap[key]!;
        await ime.typeText(character);
      } else {
        await simulateKeyDownEvent(key);
        await simulateKeyUpEvent(key);
      }
      if (isControlPressed) {
        await simulateKeyUpEvent(LogicalKeyboardKey.control);
      }
      if (isShiftPressed) {
        await simulateKeyUpEvent(LogicalKeyboardKey.shift);
      }
      if (isAltPressed) {
        await simulateKeyUpEvent(LogicalKeyboardKey.alt);
      }
      if (isMetaPressed) {
        await simulateKeyUpEvent(LogicalKeyboardKey.meta);
      }
    } else if (character != null) {
      await ime.typeText(character);
    }
    await tester.pumpAndSettle();
  }

  Map<String, BlockComponentBuilder> _customBlockComponentBuilders(
    EditorState editorState,
  ) {
    final customBlockComponentBuilderMap = {
      CodeBlockKeys.type: CodeBlockComponentBuilder(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: 36,
        ),
        editorState: editorState,
      ),
    };

    final builders = {
      ...standardBlockComponentBuilderMap,
      ...customBlockComponentBuilderMap,
    };

    return builders;
  }
}

extension TestableEditorExtension on WidgetTester {
  TestableEditor get editor => TestableEditor(tester: this)..initialize();

  EditorState get editorState => editor.editorState;
}

class MockIMEInput {
  MockIMEInput({
    required this.editorState,
    required this.tester,
  });

  final EditorState editorState;
  final WidgetTester tester;

  TextInputService get imeInput {
    final keyboardService = tester.state(find.byType(KeyboardServiceWidget))
        as KeyboardServiceWidgetState;
    return keyboardService.textInputService;
  }

  Future<void> typeText(String text) async {
    final selection = editorState.selection;
    if (selection == null) {
      return;
    }
    // if the selection is collapsed, do insertion.
    //  else if the selection is not collapsed, do replacement.
    if (selection.isCollapsed) {
      await insertText(text);
    } else {
      await replaceText(text);
    }
  }

  Future<void> insertText(String text) async {
    final selection = editorState.selection;
    if (selection == null || !selection.isCollapsed) {
      return;
    }
    final node = editorState.getNodeAtPath(selection.end.path);
    final delta = node?.delta;
    if (delta == null) {
      return;
    }
    await imeInput.apply([
      TextEditingDeltaInsertion(
        oldText: ' ${delta.toPlainText()}',
        textInserted: text,
        insertionOffset: selection.startIndex + 1,
        selection: TextSelection.collapsed(
          offset: selection.startIndex + 1 + text.length,
        ),
        composing: TextRange.empty,
      )
    ]);
    await tester.pumpAndSettle();
  }

  Future<void> replaceText(String text) async {
    final selection = editorState.selection?.normalized;
    if (selection == null || selection.isCollapsed) {
      return;
    }
    final texts = editorState.getTextInSelection(selection).join('\n');
    await imeInput.apply([
      TextEditingDeltaReplacement(
        oldText: ' $texts',
        replacementText: text,
        replacedRange: TextSelection(
          baseOffset: selection.startIndex + 1,
          extentOffset: selection.endIndex + 1,
        ),
        selection: TextSelection.collapsed(
          offset: selection.startIndex + 1 + text.length,
        ),
        composing: TextRange.empty,
      )
    ]);
    await tester.pumpAndSettle();
  }
}

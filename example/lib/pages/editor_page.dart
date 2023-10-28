import 'package:code_block/code_block.dart';
import 'package:flutter/material.dart';
import 'package:appflowy_editor/appflowy_editor.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({super.key});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final editorState = EditorState(
    document: Document(root: pageNode(children: [codeBlockNode()])),
  );
  late final List<SelectionMenuItem> slashMenuItems = [
    ...standardSelectionMenuItems,
    codeBlockItem,
  ];
  late final Map<String, BlockComponentBuilder> blockComponentBuilders;
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

  @override
  void initState() {
    super.initState();
    blockComponentBuilders = _customBlockComponentBuilders(editorState);
  }

  @override
  Widget build(BuildContext context) {
    return AppFlowyEditor(
      editorState: editorState,
      autoFocus: true,
      characterShortcutEvents: characterShortcutEvents,
      commandShortcutEvents: commandShortcutEvents,
      blockComponentBuilders: blockComponentBuilders,
    );
  }
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

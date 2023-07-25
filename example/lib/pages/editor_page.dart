import 'package:code_block/code_block.dart';
import 'package:flutter/material.dart';
import 'package:appflowy_editor/appflowy_editor.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({super.key});

  @override
  State<EditorPage> createState() => EditorPageState();
}

class EditorPageState extends State<EditorPage> {
  final editorState = EditorState.blank(withInitialText: true);
  late final List<SelectionMenuItem> slashMenuItems;
  late final Map<String, BlockComponentBuilder> blockComponentBuilders;

  @override
  void initState() {
    super.initState();
    slashMenuItems = _customSlashMenuItems();
    blockComponentBuilders = _customBlockComponentBuilders(editorState);
  }

  @override
  Widget build(BuildContext context) {
    return AppFlowyEditor(
      editorState: editorState,
      autoFocus: true,
      characterShortcutEvents: [...standardCharacterShortcutEvents],
      commandShortcutEvents: [...standardCommandShortcutEvents],
      blockComponentBuilders: blockComponentBuilders,
      footer: const SizedBox(height: 200),
    );
  }
}

Map<String, BlockComponentBuilder> _customBlockComponentBuilders(
  EditorState editorState,
) {
  final configuration = BlockComponentConfiguration(
    padding: (_) => const EdgeInsets.symmetric(vertical: 5.0),
  );
  final customBlockComponentBuilderMap = {
    CodeBlockKeys.type: CodeBlockComponentBuilder(
      configuration: configuration,
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

List<SelectionMenuItem> _customSlashMenuItems() {
  final items = [...standardSelectionMenuItems];

  return [
    ...items,
    codeBlockItem,
  ];
}

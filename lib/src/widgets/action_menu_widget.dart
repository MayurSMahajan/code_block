import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:code_block/src/widgets/switch_language_button.dart';
import 'package:flutter/material.dart';

class ActionMenuWidget extends StatelessWidget {
  const ActionMenuWidget({
    super.key,
    required this.editorState,
    required this.node,
  });

  final EditorState editorState;
  final Node node;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SwitchLanguageButton(node: node, editorState: editorState),
        ActionsContainer(node: node, editorState: editorState),
      ],
    );
  }
}

class ActionsContainer extends StatelessWidget {
  const ActionsContainer({
    super.key,
    required this.editorState,
    required this.node,
  });

  final EditorState editorState;
  final Node node;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.copy_all)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.download)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.upload)),
      ],
    );
  }
}

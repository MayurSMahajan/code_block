import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_popover/appflowy_popover.dart';
import 'package:code_block/src/widgets/selectable_item_list_menu.dart';
import 'package:code_block/utils/utils.dart';
import 'package:flowy_infra_ui/flowy_infra_ui.dart';
import 'package:flutter/material.dart';
import 'package:highlight/highlight.dart' as highlight;

class CodeBlockComponentBuilder extends BlockComponentBuilder {
  CodeBlockComponentBuilder({
    this.configuration = const BlockComponentConfiguration(),
    this.padding = const EdgeInsets.all(0),
    required this.editorState,
  });

  @override
  final BlockComponentConfiguration configuration;

  final EdgeInsets padding;

  final EditorState editorState;

  @override
  BlockComponentWidget build(BlockComponentContext blockComponentContext) {
    final node = blockComponentContext.node;
    return CodeBlockComponentWidget(
      key: node.key,
      editorState: editorState,
      node: node,
      configuration: configuration,
      padding: padding,
      showActions: showActions(node),
      actionBuilder: (context, state) => actionBuilder(
        blockComponentContext,
        state,
      ),
    );
  }

  @override
  bool validate(Node node) => node.delta != null;
}

class CodeBlockComponentWidget extends BlockComponentStatefulWidget {
  const CodeBlockComponentWidget({
    super.key,
    required super.node,
    super.showActions,
    super.actionBuilder,
    super.configuration = const BlockComponentConfiguration(),
    this.padding = const EdgeInsets.all(0),
    required this.editorState,
  });

  final EdgeInsets padding;
  final EditorState editorState;

  @override
  State<CodeBlockComponentWidget> createState() =>
      _CodeBlockComponentWidgetState();
}

class _CodeBlockComponentWidgetState extends State<CodeBlockComponentWidget>
    with SelectableMixin, DefaultSelectableMixin, BlockComponentConfigurable {
  // the key used to forward focus to the richtext child
  @override
  final forwardKey = GlobalKey(debugLabel: 'flowy_rich_text');

  @override
  GlobalKey<State<StatefulWidget>> blockComponentKey = GlobalKey(
    debugLabel: CodeBlockKeys.type,
  );

  @override
  BlockComponentConfiguration get configuration => widget.configuration;

  @override
  GlobalKey<State<StatefulWidget>> get containerKey => node.key;

  @override
  Node get node => widget.node;

  final popoverController = PopoverController();

  late final editorState = widget.editorState;

  String? get language => node.attributes[CodeBlockKeys.language] as String?;
  String? autoDetectLanguage;

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: Colors.grey.withOpacity(0.1),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSwitchLanguageButton(context),
          _buildCodeBlock(context),
        ],
      ),
    );

    child = Padding(
      key: blockComponentKey,
      padding: padding,
      child: child,
    );

    if (widget.actionBuilder != null) {
      child = BlockComponentActionWrapper(
        node: widget.node,
        actionBuilder: widget.actionBuilder!,
        child: child,
      );
    }

    return child;
  }

  Widget _buildCodeBlock(BuildContext context) {
    final delta = node.delta ?? Delta();
    final content = delta.toPlainText();

    final result = highlight.highlight.parse(
      content,
      language: language,
      autoDetection: language == null,
    );
    autoDetectLanguage = language ?? result.language;

    final codeNodes = result.nodes;
    if (codeNodes == null) {
      throw Exception('Code block parse error.');
    }
    final codeTextSpans = _convert(codeNodes);
    return Padding(
      padding: widget.padding,
      child: AppFlowyRichText(
        key: forwardKey,
        node: widget.node,
        editorState: editorState,
        placeholderText: placeholderText,
        lineHeight: 1.5,
        textSpanDecorator: (textSpan) => TextSpan(
          style: textStyle,
          children: codeTextSpans,
        ),
        placeholderTextSpanDecorator: (textSpan) => TextSpan(
          style: textStyle,
        ),
      ),
    );
  }

  Widget _buildSwitchLanguageButton(BuildContext context) {
    const maxWidth = 100.0;
    return AppFlowyPopover(
      controller: popoverController,
      child: Container(
        width: maxWidth,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FlowyTextButton(
          '${language ?? 'Auto'} ',
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 4.0,
          ),
          constraints: const BoxConstraints(maxWidth: maxWidth),
          fontColor: Theme.of(context).colorScheme.onBackground,
          fillColor: Colors.transparent,
          mainAxisAlignment: MainAxisAlignment.start,
          onPressed: () {},
        ),
      ),
      popupBuilder: (BuildContext context) {
        return SelectableItemListMenu(
          items: languages.map((e) => e).toList(),
          selectedIndex: languages.indexOf(language ?? ''),
          onSelected: (index) {
            updateLanguage(languages[index]);
            popoverController.close();
          },
        );
      },
    );
  }

  Future<void> updateLanguage(String language) async {
    final transaction = editorState.transaction
      ..updateNode(node, {
        CodeBlockKeys.language: language == 'auto' ? null : language,
      })
      ..afterSelection = Selection.collapse(
        node.path,
        node.delta?.length ?? 0,
      );
    await editorState.apply(transaction);
  }

  // Copy from flutter.highlight package.
  // https://github.com/git-touch/highlight.dart/blob/master/flutter_highlight/lib/flutter_highlight.dart
  List<TextSpan> _convert(List<highlight.Node> nodes) {
    final List<TextSpan> spans = [];
    var currentSpans = spans;
    final List<List<TextSpan>> stack = [];

    void traverse(highlight.Node node) {
      if (node.value != null) {
        currentSpans.add(
          node.className == null
              ? TextSpan(text: node.value)
              : TextSpan(
                  text: node.value,
                  style: builtInCodeBlockTheme[node.className!],
                ),
        );
      } else if (node.children != null) {
        final List<TextSpan> tmp = [];
        currentSpans.add(
          TextSpan(
            children: tmp,
            style: builtInCodeBlockTheme[node.className!],
          ),
        );
        stack.add(currentSpans);
        currentSpans = tmp;

        for (final n in node.children!) {
          traverse(n);
          if (n == node.children!.last) {
            currentSpans = stack.isEmpty ? spans : stack.removeLast();
          }
        }
      }
    }

    for (final node in nodes) {
      traverse(node);
    }

    return spans;
  }
}

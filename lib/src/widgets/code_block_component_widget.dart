import 'package:appflowy_code_block/src/service/actions_service.dart';
import 'package:flutter/material.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_code_block/src/widgets/widgets.dart';
import 'package:appflowy_code_block/src/utils/utils.dart';
import 'package:highlight/highlight.dart' as highlight;

/// `CodeBlockComponentWidget` is the widget responsible for painting the
/// actual codeblock onto AppFlowy Editor. This is made possible because
/// it implements `BlockComponentStatefulWidget` from AppFlowyEditor.
///
class CodeBlockComponentWidget extends BlockComponentStatefulWidget {
  const CodeBlockComponentWidget({
    super.key,
    required super.node,
    super.showActions,
    super.actionBuilder,
    super.configuration = const BlockComponentConfiguration(),
    this.padding = const EdgeInsets.all(0),
    required this.editorState,
    required this.style,
  });

  final EdgeInsets padding;
  final EditorState editorState;
  final CodeBlockStyle style;

  @override
  State<CodeBlockComponentWidget> createState() =>
      _CodeBlockComponentWidgetState();
}

class _CodeBlockComponentWidgetState extends State<CodeBlockComponentWidget>
    with
        SelectableMixin,
        DefaultSelectableMixin,
        BlockComponentConfigurable,
        BlockComponentTextDirectionMixin {
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

  // final popoverController = PopoverController();

  late final ActionsService actionsService;

  @override
  late final editorState = widget.editorState;

  String? get language => node.attributes[CodeBlockKeys.language] as String?;
  String? autoDetectLanguage;

  bool showActions = false;

  @override
  void initState() {
    super.initState();
    actionsService = ActionsService(editorState: editorState, node: node);
  }

  @override
  Widget build(BuildContext context) {
    return BlockComponentActionWrapper(
      node: widget.node,
      actionBuilder: widget.actionBuilder!,
      child: Padding(
        key: blockComponentKey,
        padding: padding,
        child: InkWell(
          onTap: () {},
          onHover: (hover) {
            setState(() {
              showActions = hover;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: widget.style.background,
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                showActions
                    ? ActionMenuWidget(
                        actionsService: actionsService,
                        editorState: editorState,
                      )
                    : const SizedBox(height: 40),
                _buildCodeBlock(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCodeBlock(BuildContext context) {
    final delta = node.delta ?? Delta();
    final content = delta.toPlainText();
    final isLightMode = Theme.of(context).brightness == Brightness.light;

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
    final codeTextSpans = _convert(codeNodes, isLightMode: isLightMode);
    return Padding(
      padding: widget.padding,
      child: AppFlowyRichText(
        key: forwardKey,
        delegate: this,
        node: widget.node,
        editorState: editorState,
        placeholderText: placeholderText,
        lineHeight: 1.5,
        textSpanDecorator: (textSpan) => TextSpan(
          style: textStyle.copyWith(
            height: 1.5,
            color: Colors.black,
          ),
          children: codeTextSpans,
        ),
        placeholderTextSpanDecorator: (textSpan) => TextSpan(
          style: textStyle,
        ),
        cursorColor: widget.style.cursorColor,
        selectionColor: widget.style.selectionColor,
      ),
    );
  }

  // Copy from flutter.highlight package.
  // https://github.com/git-touch/highlight.dart/blob/master/flutter_highlight/lib/flutter_highlight.dart
  List<TextSpan> _convert(
    List<highlight.Node> nodes, {
    bool isLightMode = true,
  }) {
    final List<TextSpan> spans = [];
    var currentSpans = spans;
    final List<List<TextSpan>> stack = [];

    final codeblockTheme = isLightMode ? defaultLightTheme : defaultDarkTheme;

    void traverse(highlight.Node node) {
      if (node.value != null) {
        currentSpans.add(
          node.className == null
              ? TextSpan(text: node.value)
              : TextSpan(
                  text: node.value,
                  style: codeblockTheme[node.className!],
                ),
        );
      } else if (node.children != null) {
        final List<TextSpan> tmp = [];
        currentSpans.add(
          TextSpan(
            children: tmp,
            style: codeblockTheme[node.className!],
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

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:code_block/src/service/actions_service.dart';
import 'package:flutter/material.dart';
import 'package:code_block/src/widgets/selectable_item_list_menu.dart';
import 'package:code_block/src/utils/utils.dart';

class SwitchLanguageButton extends StatefulWidget {
  const SwitchLanguageButton({
    super.key,
    required this.actionsService,
    required this.editorState,
  });

  final ActionsService actionsService;
  final EditorState editorState;

  @override
  State<SwitchLanguageButton> createState() => _SwitchLanguageButtonState();
}

class _SwitchLanguageButtonState extends State<SwitchLanguageButton> {
  String? get language => widget.actionsService.language;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => showActionMenu(
        context: context,
        editorState: widget.editorState,
        actionsService: widget.actionsService,
      ),
      label: Container(
        constraints: const BoxConstraints(maxWidth: 120),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Text(
          language ?? 'auto',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      icon: const Icon(Icons.arrow_drop_down),
    );
  }
}

void showActionMenu({
  required BuildContext context,
  required EditorState editorState,
  required ActionsService actionsService,
  String selectedLanguage = 'auto',
}) {
  final Offset pos =
      (context.findRenderObject() as RenderBox).localToGlobal(Offset.zero);
  final rect = Rect.fromLTWH(
    pos.dx,
    pos.dy,
    context.size?.width ?? 0,
    context.size?.height ?? 0,
  );
  OverlayEntry? overlay;

  var (top, bottom, left) = positionFromRect(rect, editorState);
  top = top != null ? top - 6 : top;

  void dismissOverlay() {
    overlay?.remove();
    overlay = null;
  }

  overlay = FullScreenOverlayEntry(
    top: top,
    bottom: bottom,
    left: left,
    builder: (context) {
      return Container(
        width: 140,
        height: 240,
        decoration: buildOverlayDecoration(context),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: SelectableItemListMenu(
          items: languages.map((e) => e).toList(),
          selectedIndex: languages.indexOf(selectedLanguage),
          onSelected: (index) {
            actionsService.updateLanguage(languages[index]);
            dismissOverlay();
          },
        ),
      );
    },
  ).build();
  Overlay.of(context).insert(overlay!);
}

(double?, double?, double?) positionFromRect(
  Rect rect,
  EditorState editorState,
) {
  final left = rect.left + 10;
  double? top;
  double? bottom;
  final offset = rect.center;
  final editorOffset = editorState.renderBox!.localToGlobal(Offset.zero);
  final editorHeight = editorState.renderBox!.size.height;
  final threshold = editorOffset.dy + editorHeight - 200;
  if (offset.dy > threshold) {
    bottom = editorOffset.dy + editorHeight - rect.top - 5;
  } else {
    top = rect.bottom + 5;
  }

  return (top, bottom, left);
}

BoxDecoration buildOverlayDecoration(BuildContext context) {
  return BoxDecoration(
    color: Theme.of(context).cardColor,
    borderRadius: BorderRadius.circular(6),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade800,
        blurRadius: 10,
        offset: const Offset(0, 2),
      ),
    ],
  );
}

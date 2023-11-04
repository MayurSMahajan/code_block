import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_code_block/src/service/actions_service.dart';
import 'package:appflowy_code_block/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SwitchLanguageButton extends StatelessWidget {
  const SwitchLanguageButton({
    super.key,
    required this.actionsService,
    required this.editorState,
  });

  final ActionsService actionsService;
  final EditorState editorState;

  @override
  Widget build(BuildContext context) {
    return ButtonWithTrailingIcon(
      onTap: () => showActionMenu(
        context: context,
        editorState: editorState,
        actionsService: actionsService,
      ),
      text: actionsService.language ?? 'auto',
      icon: const Icon(
        Icons.expand_more,
        size: 16,
      ),
    );
  }

  void showActionMenu({
    required BuildContext context,
    required EditorState editorState,
    required ActionsService actionsService,
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
        return LanguageSearchWidget(
          actionsService: actionsService,
          dismissCall: dismissOverlay,
        );
      },
    ).build();
    Overlay.of(context).insert(overlay!);
  }
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

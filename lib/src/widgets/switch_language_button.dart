import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_code_block/src/service/actions_service.dart';
import 'package:appflowy_code_block/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// Widget that displays the current selected programming Language
/// If clicked, it should open a list of all available programming languages
/// supported by the codeblock.
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
      onTap: () {
        if (PlatformExtension.isMobile) {
          // show bottom modal sheet with Language selection widget.
          showFlowyMobileBottomSheet(
            context,
            title: 'Select Language',
            actionsService: actionsService,
          );
        } else {
          return showActionMenu(
            context: context,
            editorState: editorState,
            actionsService: actionsService,
          );
        }
      },
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

Future<T?> showFlowyMobileBottomSheet<T>(
  BuildContext context, {
  required String title,
  required ActionsService actionsService,
}) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _BottomSheetTitle(title),
          const SizedBox(
            height: 16,
          ),
          LanguageSearchWidget(
            actionsService: actionsService,
            dismissCall: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}

class _BottomSheetTitle extends StatelessWidget {
  const _BottomSheetTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textTheme.labelSmall,
        ),
        IconButton(
          icon: Icon(
            Icons.close,
            color: theme.hintColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

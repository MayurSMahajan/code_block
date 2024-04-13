import 'package:flutter/material.dart';

/// An utility widget to show an icon button with hover effect
/// Used in the action menu container.
class ActionMenuIconBtn extends StatefulWidget {
  const ActionMenuIconBtn({
    required this.onTap,
    required this.icon,
    this.text = '',
    super.key,
  });

  final VoidCallback onTap;
  final Icon icon;
  final String text;

  @override
  State<ActionMenuIconBtn> createState() => _ActionMenuIconBtnState();
}

class _ActionMenuIconBtnState extends State<ActionMenuIconBtn> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(
        () => isHovered = true,
      ),
      onExit: (_) => setState(
        () => isHovered = false,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            curve: Curves.ease,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:
                  isHovered ? Theme.of(context).hoverColor : Colors.transparent,
            ),
            child: Tooltip(
              message: widget.text,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.icon,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

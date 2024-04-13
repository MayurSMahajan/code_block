import 'package:flutter/material.dart';

// Define an enum for icon states
enum IconState { normal, clicked }

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

class _ActionMenuIconBtnState extends State<ActionMenuIconBtn>
    with TickerProviderStateMixin {
  bool isHovered = false;
  IconState _iconState = IconState.normal;
  late AnimationController _controller;
  // ignore: unused_field
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _iconAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _toggleIconState();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleIconState() {
    setState(() {
      if (_iconState == IconState.normal) {
        _iconState = IconState.clicked;
        _controller.forward();
      } else {
        _iconState = IconState.normal;
        _controller.reverse();
      }
    });
  }

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
          onTapDown: (_) => _toggleIconState(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
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
                    _iconState == IconState.normal
                        ? widget.icon
                        : const Icon(
                            Icons.done,
                            color: Colors.green,
                          )
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

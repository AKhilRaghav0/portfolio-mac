import 'package:flutter/material.dart';

class DesktopWindow extends StatelessWidget {
  final String windowId;
  final String title;
  final Widget content;
  final double width;
  final double height;
  final double x;
  final double y;
  final bool isMaximized;
  final bool isActive;

  const DesktopWindow({
    super.key,
    required this.windowId,
    required this.title,
    required this.content,
    required this.width,
    required this.height,
    required this.x,
    required this.y,
    required this.isMaximized,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Window title bar
            Container(
              height: 30,
              decoration: const BoxDecoration(
                color: Color(0xFFE5E5E5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  _WindowButton(color: Colors.red),
                  const SizedBox(width: 8),
                  _WindowButton(color: Colors.yellow),
                  const SizedBox(width: 8),
                  _WindowButton(color: Colors.green),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Window content
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}

class _WindowButton extends StatelessWidget {
  final Color color;

  const _WindowButton({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
} 
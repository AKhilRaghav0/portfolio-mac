import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Dock extends StatelessWidget {
  const Dock({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DockIcon(icon: CupertinoIcons.folder, label: 'Finder'),
            _DockIcon(icon: CupertinoIcons.textformat, label: 'Terminal'),
            _DockIcon(icon: CupertinoIcons.mail, label: 'Mail'),
            _DockIcon(icon: CupertinoIcons.globe, label: 'Safari'),
          ],
        ),
      ),
    );
  }
}

class _DockIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DockIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
} 
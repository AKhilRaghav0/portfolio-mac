import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/desktop_provider.dart';

class MenuBar extends StatelessWidget {
  const MenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DesktopProvider>(
      builder: (context, desktopProvider, child) {
        return Container(
          height: 28,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.85),
            border: const Border(
              bottom: BorderSide(
                color: Color(0xFF404040),
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              // Left side - Apple logo and app menus
              Expanded(
                child: Row(
                  children: [
                    // Apple Menu
                    _MenuButton(
                      icon: Icons.apple,
                      onPressed: () => _showAppleMenu(context),
                    ),
                    const SizedBox(width: 16),
                    
                    // App name
                    Text(
                      'Akhil Raghav',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                    const SizedBox(width: 24),
                    
                    // Menu items
                    _MenuButton(
                      text: 'File',
                      onPressed: () => _showFileMenu(context),
                    ),
                    _MenuButton(
                      text: 'Edit',
                      onPressed: () => _showEditMenu(context),
                    ),
                    _MenuButton(
                      text: 'View',
                      onPressed: () => _showViewMenu(context),
                    ),
                    _MenuButton(
                      text: 'Window',
                      onPressed: () => _showWindowMenu(context),
                    ),
                    _MenuButton(
                      text: 'Help',
                      onPressed: () => _showHelpMenu(context),
                    ),
                  ],
                ),
              ),
              
              // Right side - Status items
              Row(
                children: [
                  // Control Center button
                  _StatusButton(
                    icon: CupertinoIcons.control,
                    onPressed: desktopProvider.toggleControlCenter,
                  ),
                  
                  // WiFi
                  _StatusButton(
                    icon: desktopProvider.wifiEnabled 
                        ? CupertinoIcons.wifi 
                        : CupertinoIcons.wifi_slash,
                  ),
                  
                  // Battery
                  _StatusButton(
                    icon: CupertinoIcons.battery_full,
                  ),
                  
                  // Time
                  _StatusButton(
                    text: _formatTime(DateTime.now()),
                    onPressed: desktopProvider.toggleNotificationCenter,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatTime(DateTime time) {
    return DateFormat('EEE MMM d  h:mm a').format(time);
  }

  void _showAppleMenu(BuildContext context) {
    // Implementation for Apple menu
  }

  void _showFileMenu(BuildContext context) {
    // Implementation for File menu
  }

  void _showEditMenu(BuildContext context) {
    // Implementation for Edit menu
  }

  void _showViewMenu(BuildContext context) {
    // Implementation for View menu
  }

  void _showWindowMenu(BuildContext context) {
    // Implementation for Window menu
  }

  void _showHelpMenu(BuildContext context) {
    // Implementation for Help menu
  }
}

class _MenuButton extends StatefulWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback? onPressed;

  const _MenuButton({
    this.text,
    this.icon,
    this.onPressed,
  });

  @override
  State<_MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<_MenuButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.white.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: widget.text != null
              ? Text(
                  widget.text!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                )
              : Icon(
                  widget.icon,
                  color: Colors.white,
                  size: 16,
                ),
        ),
      ),
    );
  }
}

class _StatusButton extends StatefulWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback? onPressed;

  const _StatusButton({
    this.text,
    this.icon,
    this.onPressed,
  });

  @override
  State<_StatusButton> createState() => _StatusButtonState();
}

class _StatusButtonState extends State<_StatusButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.white.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: widget.text != null
              ? Text(
                  widget.text!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : Icon(
                  widget.icon,
                  color: Colors.white,
                  size: 14,
                ),
        ),
      ),
    );
  }
} 
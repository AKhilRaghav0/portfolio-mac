import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../providers/desktop_provider.dart';
import '../providers/app_provider.dart';
import '../widgets/menu_bar.dart' as macos_menu;
import '../widgets/dock.dart';
import '../widgets/control_center.dart';
import '../widgets/notification_center.dart';
import '../widgets/desktop_window.dart';

class MacOSDesktop extends StatefulWidget {
  const MacOSDesktop({super.key});

  @override
  State<MacOSDesktop> createState() => _MacOSDesktopState();
}

class _MacOSDesktopState extends State<MacOSDesktop> {
  Timer? _timeTimer;

  @override
  void initState() {
    super.initState();
    _startTimeUpdates();
    
    // Initialize chat after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppProvider>().initializeChat();
    });
  }

  @override
  void dispose() {
    _timeTimer?.cancel();
    super.dispose();
  }

  void _startTimeUpdates() {
    _timeTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        context.read<DesktopProvider>().updateSystemStats();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<DesktopProvider>(
        builder: (context, desktopProvider, child) {
          return Stack(
            children: [
              // Dynamic Sonoma Wallpaper
              Positioned.fill(
                child: AnimatedContainer(
                  duration: const Duration(seconds: 2),
                  decoration: BoxDecoration(
                    gradient: desktopProvider.currentWallpaper.gradient,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withValues(alpha: 0.05),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.1),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              // Menu Bar
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: macos_menu.MenuBar(),
              ),
              
              // Center welcome text
              Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '🍎 Welcome to macOS Portfolio',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Akhil Raghav - Full Stack Developer',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Click the Control Center icon in the menu bar!',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Desktop Windows
              ...desktopProvider.openWindows
                  .where((window) => !window.isMinimized)
                  .map((window) => DesktopWindow(
                        key: ValueKey(window.id),
                        windowId: window.id,
                        title: window.title,
                        content: window.content,
                        width: window.size.width,
                        height: window.size.height,
                        x: window.position.dx,
                        y: window.position.dy,
                        isMaximized: window.isMaximized,
                        isActive: window.id == desktopProvider.activeWindow?.id,
                      )),
              
              // Control Center
              if (desktopProvider.controlCenterVisible)
                const Positioned(
                  top: 30,
                  right: 16,
                  child: ControlCenter(),
                ),
              
              // Notification Center
              if (desktopProvider.notificationCenterVisible)
                const Positioned(
                  top: 30,
                  right: 16,
                  child: NotificationCenter(),
                ),
              
              // Dock
              const Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Dock(),
              ),
              
              // Click outside to close panels
              if (desktopProvider.controlCenterVisible || 
                  desktopProvider.notificationCenterVisible)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      desktopProvider.hideAllOverlays();
                    },
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _getWallpaperWidget(String wallpaperPath) {
    if (wallpaperPath.startsWith('gradient_')) {
      // Handle gradient backgrounds
      return Container(
        decoration: BoxDecoration(
          gradient: _getGradientForWallpaper(wallpaperPath),
        ),
      );
    } else {
      // Handle image backgrounds
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _getWallpaperImage(wallpaperPath),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }

  ImageProvider _getWallpaperImage(String wallpaperPath) {
    // Check if it's an asset or network image
    if (wallpaperPath.startsWith('assets/')) {
      return AssetImage(wallpaperPath);
    } else if (wallpaperPath.startsWith('http')) {
      return NetworkImage(wallpaperPath);
    } else {
      // Default fallback - create a gradient
      return const NetworkImage('https://via.placeholder.com/1920x1080/1e3c72/ffffff?text=macOS+Portfolio');
    }
  }

  LinearGradient _getGradientForWallpaper(String gradientType) {
    switch (gradientType) {
      case 'gradient_blue':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1e3c72),
            Color(0xFF2a5298),
          ],
        );
      case 'gradient_purple':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF667eea),
            Color(0xFF764ba2),
          ],
        );
      default:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1e3c72),
            Color(0xFF2a5298),
          ],
        );
    }
  }
} 
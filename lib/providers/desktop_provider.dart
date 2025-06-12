import 'package:flutter/material.dart';

class DesktopProvider extends ChangeNotifier {
  // Control Center States
  bool _wifiEnabled = true;
  bool _bluetoothEnabled = true;
  bool _airdropEnabled = false;
  bool _doNotDisturbEnabled = false;
  double _brightness = 0.8;
  double _volume = 0.6;
  
  // Window Management
  final List<WindowInstance> _openWindows = [];
  WindowInstance? _activeWindow;
  
  // Desktop Customization
  int _currentWallpaperIndex = 0;
  final List<SonomaWallpaper> _wallpapers = [
    SonomaWallpaper(
      name: 'Sonoma',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF1A1A2E),
          Color(0xFF16213E),
          Color(0xFF0F3460),
          Color(0xFF533A7B),
        ],
      ),
    ),
    SonomaWallpaper(
      name: 'Ventura',
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF667EEA),
          Color(0xFF764BA2),
          Color(0xFF667EEA),
        ],
      ),
    ),
    SonomaWallpaper(
      name: 'Monterey',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF2E3192),
          Color(0xFF1BFFFF),
          Color(0xFF2E3192),
        ],
      ),
    ),
    SonomaWallpaper(
      name: 'Big Sur',
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF9796F0),
          Color(0xFFFBC7D4),
          Color(0xFF9796F0),
        ],
      ),
    ),
    SonomaWallpaper(
      name: 'Catalina',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF134E5E),
          Color(0xFF71B280),
          Color(0xFF134E5E),
        ],
      ),
    ),
  ];
  
  // UI States
  bool _controlCenterVisible = false;
  bool _notificationCenterVisible = false;
  bool _spotlightVisible = false;
  bool _dockVisible = true;
  bool _menuBarVisible = true;
  
  // Stage Manager (Sonoma feature)
  bool _stageManagerEnabled = false;
  final List<String> _stageManagerGroups = [];
  
  // Focus Modes
  String _currentFocusMode = 'Do Not Disturb';
  final List<String> _focusModes = [
    'Do Not Disturb',
    'Work',
    'Personal',
    'Gaming',
    'Sleep',
  ];
  
  // Continuity Features
  bool _handoffEnabled = true;
  bool _universalClipboardEnabled = true;
  bool _sidecarEnabled = false;
  
  // System Performance
  double _cpuUsage = 0.15;
  double _memoryUsage = 0.45;
  double _storageUsage = 0.67;
  int _batteryLevel = 85;
  bool _isCharging = false;
  
  // Getters
  bool get wifiEnabled => _wifiEnabled;
  bool get bluetoothEnabled => _bluetoothEnabled;
  bool get airdropEnabled => _airdropEnabled;
  bool get doNotDisturbEnabled => _doNotDisturbEnabled;
  double get brightness => _brightness;
  double get volume => _volume;
  
  List<WindowInstance> get openWindows => _openWindows;
  WindowInstance? get activeWindow => _activeWindow;
  
  SonomaWallpaper get currentWallpaper => _wallpapers[_currentWallpaperIndex];
  List<SonomaWallpaper> get wallpapers => _wallpapers;
  int get currentWallpaperIndex => _currentWallpaperIndex;
  
  bool get controlCenterVisible => _controlCenterVisible;
  bool get notificationCenterVisible => _notificationCenterVisible;
  bool get spotlightVisible => _spotlightVisible;
  bool get dockVisible => _dockVisible;
  bool get menuBarVisible => _menuBarVisible;
  
  bool get stageManagerEnabled => _stageManagerEnabled;
  List<String> get stageManagerGroups => _stageManagerGroups;
  
  String get currentFocusMode => _currentFocusMode;
  List<String> get focusModes => _focusModes;
  
  bool get handoffEnabled => _handoffEnabled;
  bool get universalClipboardEnabled => _universalClipboardEnabled;
  bool get sidecarEnabled => _sidecarEnabled;
  
  double get cpuUsage => _cpuUsage;
  double get memoryUsage => _memoryUsage;
  double get storageUsage => _storageUsage;
  int get batteryLevel => _batteryLevel;
  bool get isCharging => _isCharging;
  
  // Control Center Actions
  void toggleWifi() {
    _wifiEnabled = !_wifiEnabled;
    notifyListeners();
  }
  
  void toggleBluetooth() {
    _bluetoothEnabled = !_bluetoothEnabled;
    notifyListeners();
  }
  
  void toggleAirdrop() {
    _airdropEnabled = !_airdropEnabled;
    notifyListeners();
  }
  
  void toggleDoNotDisturb() {
    _doNotDisturbEnabled = !_doNotDisturbEnabled;
    notifyListeners();
  }
  
  void setBrightness(double value) {
    _brightness = value.clamp(0.0, 1.0);
    notifyListeners();
  }
  
  void setVolume(double value) {
    _volume = value.clamp(0.0, 1.0);
    notifyListeners();
  }
  
  // Window Management
  void openWindow(String appName, String title, Widget content) {
    final window = WindowInstance(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      appName: appName,
      title: title,
      content: content,
      position: Offset(
        100 + (_openWindows.length * 30),
        100 + (_openWindows.length * 30),
      ),
      size: const Size(800, 600),
    );
    
    _openWindows.add(window);
    _activeWindow = window;
    notifyListeners();
  }
  
  void closeWindow(String windowId) {
    _openWindows.removeWhere((window) => window.id == windowId);
    if (_activeWindow?.id == windowId) {
      _activeWindow = _openWindows.isNotEmpty ? _openWindows.last : null;
    }
    notifyListeners();
  }
  
  void setActiveWindow(WindowInstance window) {
    _activeWindow = window;
    // Move to front
    _openWindows.remove(window);
    _openWindows.add(window);
    notifyListeners();
  }
  
  void minimizeWindow(String windowId) {
    final window = _openWindows.firstWhere((w) => w.id == windowId);
    window.isMinimized = true;
    if (_activeWindow?.id == windowId) {
      _activeWindow = _openWindows.where((w) => !w.isMinimized).isNotEmpty
          ? _openWindows.where((w) => !w.isMinimized).last
          : null;
    }
    notifyListeners();
  }
  
  void restoreWindow(String windowId) {
    final window = _openWindows.firstWhere((w) => w.id == windowId);
    window.isMinimized = false;
    _activeWindow = window;
    notifyListeners();
  }
  
  void moveWindow(String windowId, Offset newPosition) {
    final window = _openWindows.firstWhere((w) => w.id == windowId);
    window.position = newPosition;
    notifyListeners();
  }
  
  void resizeWindow(String windowId, Size newSize) {
    final window = _openWindows.firstWhere((w) => w.id == windowId);
    window.size = newSize;
    notifyListeners();
  }
  
  // Wallpaper Management
  void setWallpaper(int index) {
    if (index >= 0 && index < _wallpapers.length) {
      _currentWallpaperIndex = index;
      notifyListeners();
    }
  }
  
  void nextWallpaper() {
    _currentWallpaperIndex = (_currentWallpaperIndex + 1) % _wallpapers.length;
    notifyListeners();
  }
  
  // UI Control
  void toggleControlCenter() {
    _controlCenterVisible = !_controlCenterVisible;
    if (_controlCenterVisible) {
      _notificationCenterVisible = false;
      _spotlightVisible = false;
    }
    notifyListeners();
  }
  
  void toggleNotificationCenter() {
    _notificationCenterVisible = !_notificationCenterVisible;
    if (_notificationCenterVisible) {
      _controlCenterVisible = false;
      _spotlightVisible = false;
    }
    notifyListeners();
  }
  
  void toggleSpotlight() {
    _spotlightVisible = !_spotlightVisible;
    if (_spotlightVisible) {
      _controlCenterVisible = false;
      _notificationCenterVisible = false;
    }
    notifyListeners();
  }
  
  void hideAllOverlays() {
    _controlCenterVisible = false;
    _notificationCenterVisible = false;
    _spotlightVisible = false;
    notifyListeners();
  }
  
  void toggleDock() {
    _dockVisible = !_dockVisible;
    notifyListeners();
  }
  
  void toggleMenuBar() {
    _menuBarVisible = !_menuBarVisible;
    notifyListeners();
  }
  
  // Stage Manager (Sonoma Feature)
  void toggleStageManager() {
    _stageManagerEnabled = !_stageManagerEnabled;
    notifyListeners();
  }
  
  void addStageManagerGroup(String groupName) {
    if (!_stageManagerGroups.contains(groupName)) {
      _stageManagerGroups.add(groupName);
      notifyListeners();
    }
  }
  
  void removeStageManagerGroup(String groupName) {
    _stageManagerGroups.remove(groupName);
    notifyListeners();
  }
  
  // Focus Modes
  void setFocusMode(String mode) {
    if (_focusModes.contains(mode)) {
      _currentFocusMode = mode;
      _doNotDisturbEnabled = mode != 'Do Not Disturb';
      notifyListeners();
    }
  }
  
  // Continuity Features
  void toggleHandoff() {
    _handoffEnabled = !_handoffEnabled;
    notifyListeners();
  }
  
  void toggleUniversalClipboard() {
    _universalClipboardEnabled = !_universalClipboardEnabled;
    notifyListeners();
  }
  
  void toggleSidecar() {
    _sidecarEnabled = !_sidecarEnabled;
    notifyListeners();
  }
  
  // System Monitoring (Simulated)
  void updateSystemStats() {
    _cpuUsage = (0.1 + (DateTime.now().millisecond / 1000) * 0.4).clamp(0.0, 1.0);
    _memoryUsage = (0.3 + (DateTime.now().second / 60) * 0.4).clamp(0.0, 1.0);
    _batteryLevel = (_batteryLevel + (DateTime.now().second % 2 == 0 ? -1 : 1)).clamp(0, 100);
    notifyListeners();
  }
  
  void toggleCharging() {
    _isCharging = !_isCharging;
    notifyListeners();
  }
}

class WindowInstance {
  final String id;
  final String appName;
  final String title;
  final Widget content;
  Offset position;
  Size size;
  bool isMinimized;
  bool isMaximized;
  bool isFullscreen;
  
  WindowInstance({
    required this.id,
    required this.appName,
    required this.title,
    required this.content,
    required this.position,
    required this.size,
    this.isMinimized = false,
    this.isMaximized = false,
    this.isFullscreen = false,
  });
}

class SonomaWallpaper {
  final String name;
  final LinearGradient gradient;
  
  const SonomaWallpaper({
    required this.name,
    required this.gradient,
  });
} 
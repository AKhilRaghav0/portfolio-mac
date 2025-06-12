import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/desktop_provider.dart';

class ControlCenter extends StatefulWidget {
  const ControlCenter({super.key});

  @override
  State<ControlCenter> createState() => _ControlCenterState();
}

class _ControlCenterState extends State<ControlCenter>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _itemsController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _itemsController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _animationController.forward();
    Future.delayed(const Duration(milliseconds: 100), () {
      _itemsController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _itemsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DesktopProvider>(
      builder: (context, desktopProvider, child) {
        return GestureDetector(
          onTap: () {}, // Prevent clicks from propagating
          child: Container(
            width: 380,
            height: 640,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 60,
                  offset: const Offset(0, 20),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: GlassmorphicContainer(
                width: 380,
                height: 640,
                borderRadius: 24,
                blur: 40,
                alignment: Alignment.bottomCenter,
                border: 2,
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.25),
                    Colors.white.withValues(alpha: 0.1),
                    Colors.white.withValues(alpha: 0.05),
                  ],
                ),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.4),
                    Colors.white.withValues(alpha: 0.2),
                    Colors.white.withValues(alpha: 0.1),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0.15),
                        Colors.white.withValues(alpha: 0.05),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Title
                        _buildTitle(),
                        
                        const SizedBox(height: 24),
                        
                        // Connectivity Section
                        _buildConnectivitySection(desktopProvider)
                            .animate(controller: _itemsController)
                            .fadeIn(delay: 100.ms, duration: 300.ms)
                            .slideY(begin: 0.3, end: 0),
                        
                        const SizedBox(height: 20),
                        
                        // Control Toggles
                        _buildControlToggles(desktopProvider)
                            .animate(controller: _itemsController)
                            .fadeIn(delay: 200.ms, duration: 300.ms)
                            .slideY(begin: 0.3, end: 0),
                        
                        const SizedBox(height: 20),
                        
                        // Sliders Section
                        _buildSlidersSection(desktopProvider)
                            .animate(controller: _itemsController)
                            .fadeIn(delay: 300.ms, duration: 300.ms)
                            .slideY(begin: 0.3, end: 0),
                        
                        const SizedBox(height: 20),
                        
                        // Media Controls
                        _buildMediaControls()
                            .animate(controller: _itemsController)
                            .fadeIn(delay: 400.ms, duration: 300.ms)
                            .slideY(begin: 0.3, end: 0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
              .animate(controller: _animationController)
              .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutCubic)
              .fadeIn(curve: Curves.easeOut),
        );
      },
    );
  }

  Widget _buildTitle() {
    return const Row(
      children: [
        Text(
          'Control Center',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildConnectivitySection(DesktopProvider desktopProvider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildLargeToggle(
                  icon: CupertinoIcons.wifi,
                  title: 'Wi-Fi',
                  subtitle: desktopProvider.wifiEnabled ? 'Home Network' : 'Off',
                  isEnabled: desktopProvider.wifiEnabled,
                  onTap: desktopProvider.toggleWifi,
                  color: const Color(0xFF007AFF),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildLargeToggle(
                  icon: FontAwesomeIcons.bluetooth,
                  title: 'Bluetooth',
                  subtitle: desktopProvider.bluetoothEnabled ? 'On' : 'Off',
                  isEnabled: desktopProvider.bluetoothEnabled,
                  onTap: desktopProvider.toggleBluetooth,
                  color: const Color(0xFF007AFF),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildLargeToggle(
                  icon: CupertinoIcons.antenna_radiowaves_left_right,
                  title: 'AirDrop',
                  subtitle: desktopProvider.airdropEnabled ? 'Contacts Only' : 'Off',
                  isEnabled: desktopProvider.airdropEnabled,
                  onTap: desktopProvider.toggleAirdrop,
                  color: const Color(0xFF007AFF),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildLargeToggle(
                  icon: CupertinoIcons.personalhotspot,
                  title: 'Hotspot',
                  subtitle: 'Off',
                  isEnabled: false,
                  onTap: () {},
                  color: const Color(0xFF34C759),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLargeToggle({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isEnabled,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isEnabled 
              ? color.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isEnabled 
                ? color.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.1),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isEnabled ? color : Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const Spacer(),
                if (isEnabled)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFF34C759),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlToggles(DesktopProvider desktopProvider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildSmallToggle(
              icon: CupertinoIcons.moon_fill,
              label: 'Focus',
              isEnabled: desktopProvider.doNotDisturbEnabled,
              onTap: desktopProvider.toggleDoNotDisturb,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSmallToggle(
              icon: CupertinoIcons.lock_rotation,
              label: 'Stage Manager',
              isEnabled: false,
              onTap: () {},
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSmallToggle(
              icon: CupertinoIcons.camera,
              label: 'Screen Mirroring',
              isEnabled: false,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallToggle({
    required IconData icon,
    required String label,
    required bool isEnabled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        decoration: BoxDecoration(
          color: isEnabled 
              ? const Color(0xFF5E5CE6).withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isEnabled 
                ? const Color(0xFF5E5CE6).withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isEnabled ? const Color(0xFF5E5CE6) : Colors.white.withValues(alpha: 0.7),
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlidersSection(DesktopProvider desktopProvider) {
    return Column(
      children: [
        _buildSonnaSlider(
          'Display',
          CupertinoIcons.brightness,
          desktopProvider.brightness,
          desktopProvider.setBrightness,
        ),
        const SizedBox(height: 16),
        _buildSonnaSlider(
          'Sound',
          CupertinoIcons.volume_up,
          desktopProvider.volume,
          desktopProvider.setVolume,
        ),
      ],
    );
  }

  Widget _buildSonnaSlider(
    String title,
    IconData icon,
    double value,
    ValueChanged<double> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '${(value * 100).round()}%',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white.withValues(alpha: 0.2),
              thumbColor: Colors.white,
              trackHeight: 6,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
            ),
            child: Slider(
              value: value,
              onChanged: onChanged,
              min: 0,
              max: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaControls() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  CupertinoIcons.music_note_2,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'No Music Playing',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Open Music to control playback',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMediaButton(CupertinoIcons.backward_fill),
              _buildMediaButton(CupertinoIcons.play_fill, isLarge: true),
              _buildMediaButton(CupertinoIcons.forward_fill),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMediaButton(IconData icon, {bool isLarge = false}) {
    return Container(
      padding: EdgeInsets.all(isLarge ? 16 : 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: isLarge ? 0.25 : 0.15),
        borderRadius: BorderRadius.circular(isLarge ? 24 : 20),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: isLarge ? 28 : 20,
      ),
    );
  }
} 
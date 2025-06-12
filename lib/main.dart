import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/macos_desktop.dart';
import 'providers/desktop_provider.dart';
import 'providers/app_provider.dart';

void main() {
  runApp(const MacOSPortfolioApp());
}

class MacOSPortfolioApp extends StatelessWidget {
  const MacOSPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DesktopProvider()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MaterialApp(
        title: 'Akhil Raghav - macOS Portfolio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          textTheme: GoogleFonts.interTextTheme(
            ThemeData.dark().textTheme,
          ).apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF007AFF),
            secondary: Color(0xFF5AC8FA),
            surface: Color(0xFF1C1C1E),
            onSurface: Colors.white,
          ),
        ),
        home: const MacOSDesktop(),
      ),
    );
  }
}

class SimpleDesktop extends StatelessWidget {
  const SimpleDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1e3c72),
              Color(0xFF2a5298),
            ],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '🍎 macOS Portfolio',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
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
                'Flutter Web Portfolio',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

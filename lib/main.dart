import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'presentation/screens/floating_window.dart';
import 'presentation/screens/settings_screen.dart';

/// Entry point for the main app - shows settings screen
void main() {
  runApp(
    // ProviderScope is necessary for Riverpod to work
    ProviderScope(
      child: const MainApp(),
    ),
  );
}

/// Entry point for the floating overlay window
@pragma("vm:entry-point")
void overlayMain() {
  runApp(
    // ProviderScope is also needed for providers within the overlay
    ProviderScope(
      child: const FloatingWindowApp(),
    ),
  );
}

/// Main app that shows when the user wants to access settings
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Huh App Settings',
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        // Modern dark theme for night viewing
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      home: const SettingsScreen(),
    );
  }
}

/// Floating window app that shows the voice interface
class FloatingWindowApp extends StatelessWidget {
  const FloatingWindowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Huh Voice Assistant',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const FloatingWindow(),
      debugShowCheckedModeBanner: false,
    );
  }
}
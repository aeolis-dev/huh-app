import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/screens/floating_window.dart';
import 'presentation/screens/settings_screen.dart';
import 'presentation/theme/app_theme.dart';
import 'domain/providers/settings_provider.dart';

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
class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watches the settings provider to react to theme changes
    final isDarkMode = ref.watch(appSettingsProvider.select((s) => s.isDarkMode));

    return MaterialApp(
      title: 'Huh App Settings',
      // Dynamically switches between light and dark theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const SettingsScreen(),
    );
  }
}

/// Floating window app that shows the voice interface
class FloatingWindowApp extends ConsumerWidget {
  const FloatingWindowApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watches the settings provider to ensure consistent theming
    final isDarkMode = ref.watch(appSettingsProvider.select((s) => s.isDarkMode));

    return MaterialApp(
      title: 'Huh Voice Assistant',
      // Dynamically switches between light and dark theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const FloatingWindow(),
      debugShowCheckedModeBanner: false,
    );
  }
}
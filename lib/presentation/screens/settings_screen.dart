import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'dart:io';

import '../../domain/providers/settings_provider.dart';
import '../../domain/providers/answer_provider.dart';

/// Settings screen for configuring the app
/// This is the full-screen interface for settings
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  /// Requests overlay permission and shows the floating window
  Future<void> _launchFloatingWindow(BuildContext context) async {
    // Checks if overlay permission is granted
    final hasPermission = await FlutterOverlayWindow.isPermissionGranted();
    
    if (!hasPermission) {
      // Requests permission
      final granted = await FlutterOverlayWindow.requestPermission();
      if (granted != true) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Overlay permission is required for floating window'),
            ),
          );
        }
        return;
      }
    }
    
    // Shows floating window
    await FlutterOverlayWindow.showOverlay(
      enableDrag: true,
      overlayTitle: "Huh Voice Assistant",
      overlayContent: 'Voice recording active',
      flag: OverlayFlag.defaultFlag,
      visibility: NotificationVisibility.visibilityPublic,
             positionGravity: PositionGravity.auto,
    );
    
    // Closes the main app after launching the floating window
    exit(0);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    final answer = ref.watch(answerProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Huh App Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick launch section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _launchFloatingWindow(context),
                        icon: const Icon(Icons.mic),
                        label: const Text('Launch Voice Assistant'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Settings section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Preferences',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Theme settings
                    Card(
                      child: SwitchListTile(
                        title: const Text('Dark Mode'),
                        subtitle: const Text('Enables dark theme for night viewing'),
                        value: settings.isDarkMode,
                        secondary: const Icon(Icons.palette),
                        onChanged: (value) {
                          ref.read(appSettingsProvider.notifier).toggleDarkMode();
                        },
                      ),
                    ),
                    
                    const Divider(),
                    
                    // Response length setting
                    ListTile(
                      title: const Text('Response Length'),
                      subtitle: Text('Current: ${settings.responseLength.displayName}'),
                      trailing: DropdownButton<ResponseLength>(
                        value: settings.responseLength,
                        onChanged: (ResponseLength? newValue) {
                          if (newValue != null) {
                            ref.read(appSettingsProvider.notifier)
                                .updateResponseLength(newValue);
                          }
                        },
                        items: ResponseLength.values.map((ResponseLength length) {
                          return DropdownMenuItem<ResponseLength>(
                            value: length,
                            child: Text(length.displayName),
                          );
                        }).toList(),
                      ),
                    ),
                    
                    const Divider(),
                    
                    // Auto-close setting
                    SwitchListTile(
                      title: const Text('Auto-close after response'),
                      subtitle: const Text('Automatically closes window after getting answer'),
                      value: settings.isAutoCloseEnabled,
                      onChanged: (value) {
                        ref.read(appSettingsProvider.notifier).toggleAutoClose();
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Last answer section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Last Answer',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ref.read(answerProvider.notifier).clearAnswer();
                          },
                          icon: const Icon(Icons.clear),
                          tooltip: 'Clear answer',
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                      ),
                      child: Text(
                        answer,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Exit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  exit(0);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Close App'),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
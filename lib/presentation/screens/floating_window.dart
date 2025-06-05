import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

import '../../domain/providers/voice_provider.dart';
import '../../domain/providers/answer_provider.dart';

/// Floating window UI for voice recording
/// This is the main interface that appears as an overlay
class FloatingWindow extends ConsumerStatefulWidget {
  const FloatingWindow({super.key});

  @override
  ConsumerState<FloatingWindow> createState() => _FloatingWindowState();
}

class _FloatingWindowState extends ConsumerState<FloatingWindow> {
  @override
  void initState() {
    super.initState();
    // Starts recording immediately when the floating window opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startRecording();
    });
  }

  /// Starts voice recording
  Future<void> _startRecording() async {
    await ref.read(voiceRecordingProvider.notifier).startRecording();
  }

  /// Handles "Done" button press - stops recording and sends to ChatGPT
  Future<void> _handleDone() async {
    final voiceNotifier = ref.read(voiceRecordingProvider.notifier);
    final answerNotifier = ref.read(answerProvider.notifier);
    
    // Stops recording and gets the transcribed text
    final transcribedText = await voiceNotifier.stopRecording();
    
    if (transcribedText.isNotEmpty) {
      try {
        // Sends to ChatGPT (placeholder implementation)
        final response = await ref.read(chatGptResponseProvider(transcribedText).future);
        
        // Stores the answer
        await answerNotifier.updateAnswer(response);
        
        // Closes the floating window
        FlutterOverlayWindow.closeOverlay();
      } catch (e) {
        // Handles error - a snackbar might be shown or an error message stored
        await answerNotifier.updateAnswer('Error: ${e.toString()}');
        FlutterOverlayWindow.closeOverlay();
      }
    } else {
      // No speech detected, closes the window
      FlutterOverlayWindow.closeOverlay();
    }
  }

  /// Handles settings button press - opens the main app
  void _handleSettings() {
    // Cancels current recording
    ref.read(voiceRecordingProvider.notifier).cancelRecording();
    
    // Closes overlay and opens main app for settings
    FlutterOverlayWindow.closeOverlay();
    
    // TODO: Implement launching the main app (SettingsScreen) here.
    // Platform channels will be needed to send an intent to open the main activity.
    // Example: MethodChannel('com.example.huh_app/app_launcher').invokeMethod('launchMainApp');
  }

  @override
  Widget build(BuildContext context) {
    // Watches the voice recording state to update UI
    final voiceState = ref.watch(voiceRecordingProvider);
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 280,
          height: 120,
          decoration: BoxDecoration(
            // Glassy, translucent effect
            color: Colors.black.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top row with settings and done buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Settings button
                        IconButton(
                          onPressed: _handleSettings,
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white70,
                            size: 20,
                          ),
                        ),
                        // Recording indicator
                        Expanded(
                          child: Center(
                            child: voiceState.isRecording
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Listening...',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Text(
                                    'Ready',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                          ),
                        ),
                        // Done button
                        IconButton(
                          onPressed: _handleDone,
                          icon: const Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Voice text display
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          voiceState.recognizedText.isEmpty
                              ? 'Speak your question...'
                              : voiceState.recognizedText,
                          style: TextStyle(
                            color: voiceState.recognizedText.isEmpty
                                ? Colors.white54
                                : Colors.white,
                            fontSize: 11,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    // TODO: Consider displaying the received answer on the floating window here.
                    // This would involve watching the answerProvider and displaying its value.
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
} 
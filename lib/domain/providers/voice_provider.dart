import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'voice_provider.g.dart';

/// Provider that manages voice recording state
/// This is a Notifier provider - it holds mutable state and provides methods to modify it
@riverpod
class VoiceRecording extends _$VoiceRecording {
  late SpeechToText _speechToText;

  @override
  VoiceRecordingState build() {
    // Initializes the speech recognition engine
    _speechToText = SpeechToText();
    _initializeSpeech();
    
    // Returns initial state - not recording, no text
    return const VoiceRecordingState(
      isRecording: false,
      recognizedText: '',
      isInitialized: false,
    );
  }

  /// Initializes speech recognition permissions and availability
  Future<void> _initializeSpeech() async {
    final available = await _speechToText.initialize();
    state = state.copyWith(isInitialized: available);
  }

  /// Starts recording voice input
  Future<void> startRecording() async {
    if (!state.isInitialized) return;
    
    await _speechToText.listen(
      onResult: (result) {
        // Updates state with recognized text as user speaks
        state = state.copyWith(
          recognizedText: result.recognizedWords,
          isRecording: true,
        );
      },
    );
    
    state = state.copyWith(isRecording: true);
  }

  /// Stops recording and returns the final text
  Future<String> stopRecording() async {
    await _speechToText.stop();
    final finalText = state.recognizedText;
    
    // Resets state after stopping
    state = state.copyWith(
      isRecording: false,
      recognizedText: '',
    );
    
    return finalText;
  }

  /// Cancels recording without returning text
  void cancelRecording() {
    _speechToText.cancel();
    state = state.copyWith(
      isRecording: false,
      recognizedText: '',
    );
  }
}

/// Immutable state class for voice recording
/// Using copyWith pattern for state updates (common in Flutter/Riverpod)
class VoiceRecordingState {
  final bool isRecording;
  final String recognizedText;
  final bool isInitialized;

  const VoiceRecordingState({
    required this.isRecording,
    required this.recognizedText,
    required this.isInitialized,
  });

  VoiceRecordingState copyWith({
    bool? isRecording,
    String? recognizedText,
    bool? isInitialized,
  }) {
    return VoiceRecordingState(
      isRecording: isRecording ?? this.isRecording,
      recognizedText: recognizedText ?? this.recognizedText,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
} 
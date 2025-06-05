# huh app Voice Assistant

A Flutter-based voice assistant app that provides quick AI-powered answers through an elegant floating window interface.

## Overview

huh app is designed for instant voice queries with AI responses. Simply launch the floating window, speak your question, and get concise answers without interrupting your current workflow.

## How It Works

1. **Launch**: Tap the app icon to open settings, then tap "Launch Voice Assistant"
2. **Speak**: The floating window appears and immediately starts listening
3. **Submit**: Tap the green checkmark when finished speaking
4. **Receive**: AI processes the question and stores the answer
5. **Access**: The last answer can be viewed in the settings screen

## Architecture

Built with **Riverpod 3** state management and clean architecture principles:

```
lib/
├── main.dart                     # App entry points (main + overlay)
├── domain/                       # Business logic
│   └── providers/                # Riverpod providers
│       ├── voice_provider.dart   # Voice recording state management
│       ├── answer_provider.dart  # AI response storage and retrieval
│       ├── settings_provider.dart # App preferences management
│       └── *.g.dart             # Generated provider code
└── presentation/                 # UI layer
    └── screens/
        ├── floating_window.dart  # Overlay interface implementation
        └── settings_screen.dart  # Configuration screen implementation
```

## Riverpod 3 Implementation

### State Management

The app uses Riverpod's code generation for type-safe, efficient state management.

```dart
// Voice recording provider - manages speech-to-text state
@riverpod
class VoiceRecording extends _$VoiceRecording {
  @override
  VoiceRecordingState build() {
    // Initializes with default state
    return const VoiceRecordingState(
      isRecording: false,
      recognizedText: '',
      isInitialized: false,
    );
  }
  
  // Methods to start/stop recording, update recognized text
}

// Answer storage provider - persists AI responses
@riverpod
class Answer extends _$Answer {
  @override
  String build() {
    _loadSavedAnswer(); // Loads from storage on startup
    return 'No answer yet';
  }
  
  // Methods to update and persist answers
}
```

### Key Benefits

- **Auto-dispose**: Providers automatically clean up when not needed
- **Type Safety**: Generated code ensures compile-time correctness
- **Reactive Updates**: UI automatically rebuilds when state changes
- **Testing**: Easy to mock providers for unit tests

### Adding ChatGPT Integration

1. Obtain an OpenAI API key from [OpenAI Platform](https://platform.openai.com/)

2. Update `lib/domain/providers/answer_provider.dart`:
```dart
@riverpod
Future<String> chatGptResponse(Ref ref, String prompt) async {
  final client = http.Client();
  
  final response = await client.post(
    Uri.parse('https://api.openai.com/v1/chat/completions'),
    headers: {
      'Authorization': 'Bearer YOUR_API_KEY',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'model': 'gpt-3.5-turbo',
      'messages': [
        {'role': 'user', 'content': prompt}
      ],
      'max_tokens': 150,
    }),
  );
  
  // Parse and return response
}
```

## Permissions

The app requires the following permissions:
- **Microphone**: For voice recording
- **System Alert Window**: For the floating overlay (requested automatically)

## Development

### Code Generation

When modifying providers, regenerate code:
```bash
# Watches for changes during development
dart run build_runner watch

# Performs one-time generation
dart run build_runner build
```

### Testing

```bash
flutter test
```
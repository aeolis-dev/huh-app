import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http; // Uncomment when integrating ChatGPT API
// import 'dart:convert'; // Uncomment when integrating ChatGPT API

part 'answer_provider.g.dart';

/// Provider that manages the current answer from ChatGPT
/// This stores the answer both in memory and persistently
@riverpod
class Answer extends _$Answer {
  @override
  String build() {
    // Loads saved answer on startup
    _loadSavedAnswer();
    return 'No answer yet'; // Default state
  }

  /// Loads previously saved answer from storage
  Future<void> _loadSavedAnswer() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAnswer = prefs.getString('last_answer') ?? 'No answer yet';
    state = savedAnswer;
  }

  /// Updates answer and saves to storage
  Future<void> updateAnswer(String newAnswer) async {
    state = newAnswer;
    
    // Persists to storage for next app launch
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_answer', newAnswer);
  }

  /// Clears the current answer
  Future<void> clearAnswer() async {
    state = 'No answer yet';
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('last_answer');
  }
}

/// Placeholder for ChatGPT service - actual API call to be implemented later
/// This demonstrates how Riverpod can manage async operations
@riverpod
Future<String> chatGptResponse(Ref ref, String prompt) async {
  // TODO: Implement actual ChatGPT API call here.
  // This will require uncommenting the 'http' and 'dart:convert' imports above.
  // The API key should be securely stored (e.g., as environment variables, not hardcoded).
  // Example structure (uncomment and fill in details):
  /*
  final apiKey = 'YOUR_OPENAI_API_KEY';
  final client = http.Client();
  
  try {
    final response = await client.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          // TODO: Consider adding system messages based on user settings (e.g., responseLength)
          {'role': 'user', 'content': prompt}
        ],
        'max_tokens': 150, // Adjust as needed
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // TODO: Handle cases where choices list might be empty or content is null
      return data['choices'][0]['message']['content'] as String;
    } else {
      throw Exception('Failed to load response: ${response.statusCode} ${response.body}');
    }
  } finally {
    client.close();
  }
  */

  // For now, simulates API delay and returns mock response
  await Future.delayed(const Duration(seconds: 2));
  
  return 'Mock response to: "$prompt"\n\nThis is where the ChatGPT answer will appear once the API call is implemented.';
} 
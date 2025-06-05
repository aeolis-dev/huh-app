import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_provider.g.dart';

/// Provider that manages app settings
/// This demonstrates how to persist settings across app launches
@riverpod
class AppSettings extends _$AppSettings {
  @override
  AppSettingsState build() {
    // Loads saved settings on startup
    _loadSettings();
    return const AppSettingsState(
      isDarkMode: true, // Defaults to dark mode for night viewing
      responseLength: ResponseLength.concise,
      isAutoCloseEnabled: true,
    );
  }

  /// Loads settings from persistent storage
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    state = AppSettingsState(
      isDarkMode: prefs.getBool('dark_mode') ?? true,
      responseLength: ResponseLength.values[prefs.getInt('response_length') ?? 0],
      isAutoCloseEnabled: prefs.getBool('auto_close') ?? true,
    );
  }

  /// Saves settings to persistent storage
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', state.isDarkMode);
    await prefs.setInt('response_length', state.responseLength.index);
    await prefs.setBool('auto_close', state.isAutoCloseEnabled);
  }

  /// Toggles dark mode setting
  Future<void> toggleDarkMode() async {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
    await _saveSettings();
  }

  /// Updates response length preference
  Future<void> updateResponseLength(ResponseLength length) async {
    state = state.copyWith(responseLength: length);
    await _saveSettings();
  }

  /// Toggles auto-close after getting response
  Future<void> toggleAutoClose() async {
    state = state.copyWith(isAutoCloseEnabled: !state.isAutoCloseEnabled);
    await _saveSettings();
  }
}

/// Settings state class - immutable data holder
class AppSettingsState {
  final bool isDarkMode;
  final ResponseLength responseLength;
  final bool isAutoCloseEnabled;

  const AppSettingsState({
    required this.isDarkMode,
    required this.responseLength,
    required this.isAutoCloseEnabled,
  });

  AppSettingsState copyWith({
    bool? isDarkMode,
    ResponseLength? responseLength,
    bool? isAutoCloseEnabled,
  }) {
    return AppSettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      responseLength: responseLength ?? this.responseLength,
      isAutoCloseEnabled: isAutoCloseEnabled ?? this.isAutoCloseEnabled,
    );
  }
}

/// Enum for response length preferences
enum ResponseLength {
  concise('Concise'),
  detailed('Detailed'),
  comprehensive('Comprehensive');

  const ResponseLength(this.displayName);
  final String displayName;
} 
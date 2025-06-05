// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// Provider that manages the current answer from ChatGPT
/// This stores the answer both in memory and persistently
@ProviderFor(Answer)
const answerProvider = AnswerProvider._();

/// Provider that manages the current answer from ChatGPT
/// This stores the answer both in memory and persistently
final class AnswerProvider extends $NotifierProvider<Answer, String> {
  /// Provider that manages the current answer from ChatGPT
  /// This stores the answer both in memory and persistently
  const AnswerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'answerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$answerHash();

  @$internal
  @override
  Answer create() => Answer();

  @$internal
  @override
  $NotifierProviderElement<Answer, String> $createElement(
          $ProviderPointer pointer) =>
      $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<String>(value),
    );
  }
}

String _$answerHash() => r'1eff99fee9dd09a8466d85ee5e2950f7a7cd08d0';

abstract class _$Answer extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String>;
    final element = ref.element
        as $ClassProviderElement<AnyNotifier<String>, String, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

/// Placeholder for ChatGPT service - you'll implement this when you get API key
/// This demonstrates how Riverpod can manage async operations
@ProviderFor(chatGptResponse)
const chatGptResponseProvider = ChatGptResponseFamily._();

/// Placeholder for ChatGPT service - you'll implement this when you get API key
/// This demonstrates how Riverpod can manage async operations
final class ChatGptResponseProvider
    extends $FunctionalProvider<AsyncValue<String>, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  /// Placeholder for ChatGPT service - you'll implement this when you get API key
  /// This demonstrates how Riverpod can manage async operations
  const ChatGptResponseProvider._(
      {required ChatGptResponseFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'chatGptResponseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$chatGptResponseHash();

  @override
  String toString() {
    return r'chatGptResponseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as String;
    return chatGptResponse(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ChatGptResponseProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatGptResponseHash() => r'86bbbce032708ad95b3447314e973d7ba44c6489';

/// Placeholder for ChatGPT service - you'll implement this when you get API key
/// This demonstrates how Riverpod can manage async operations
final class ChatGptResponseFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, String> {
  const ChatGptResponseFamily._()
      : super(
          retry: null,
          name: r'chatGptResponseProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Placeholder for ChatGPT service - you'll implement this when you get API key
  /// This demonstrates how Riverpod can manage async operations
  ChatGptResponseProvider call(
    String prompt,
  ) =>
      ChatGptResponseProvider._(argument: prompt, from: this);

  @override
  String toString() => r'chatGptResponseProvider';
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

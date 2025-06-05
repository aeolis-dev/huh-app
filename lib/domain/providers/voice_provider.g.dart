// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// Provider that manages voice recording state
/// This is a Notifier provider - it holds mutable state and provides methods to modify it
@ProviderFor(VoiceRecording)
const voiceRecordingProvider = VoiceRecordingProvider._();

/// Provider that manages voice recording state
/// This is a Notifier provider - it holds mutable state and provides methods to modify it
final class VoiceRecordingProvider
    extends $NotifierProvider<VoiceRecording, VoiceRecordingState> {
  /// Provider that manages voice recording state
  /// This is a Notifier provider - it holds mutable state and provides methods to modify it
  const VoiceRecordingProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'voiceRecordingProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$voiceRecordingHash();

  @$internal
  @override
  VoiceRecording create() => VoiceRecording();

  @$internal
  @override
  $NotifierProviderElement<VoiceRecording, VoiceRecordingState> $createElement(
          $ProviderPointer pointer) =>
      $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VoiceRecordingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<VoiceRecordingState>(value),
    );
  }
}

String _$voiceRecordingHash() => r'a49c0a7c8f680e1f1104383d50cf94efc1bff7cb';

abstract class _$VoiceRecording extends $Notifier<VoiceRecordingState> {
  VoiceRecordingState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<VoiceRecordingState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<VoiceRecordingState>,
        VoiceRecordingState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

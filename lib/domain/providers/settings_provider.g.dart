// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// Provider that manages app settings
/// This demonstrates how to persist settings across app launches
@ProviderFor(AppSettings)
const appSettingsProvider = AppSettingsProvider._();

/// Provider that manages app settings
/// This demonstrates how to persist settings across app launches
final class AppSettingsProvider
    extends $NotifierProvider<AppSettings, AppSettingsState> {
  /// Provider that manages app settings
  /// This demonstrates how to persist settings across app launches
  const AppSettingsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'appSettingsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appSettingsHash();

  @$internal
  @override
  AppSettings create() => AppSettings();

  @$internal
  @override
  $NotifierProviderElement<AppSettings, AppSettingsState> $createElement(
          $ProviderPointer pointer) =>
      $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppSettingsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<AppSettingsState>(value),
    );
  }
}

String _$appSettingsHash() => r'fb84e9aba5ffb9c367be5473ffbde885ddfcf689';

abstract class _$AppSettings extends $Notifier<AppSettingsState> {
  AppSettingsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AppSettingsState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AppSettingsState>, AppSettingsState, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

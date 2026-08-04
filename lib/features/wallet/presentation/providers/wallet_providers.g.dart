// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$walletRepositoryHash() => r'5089cd62ba42170a6a91e9b4991ac3f8004859bd';

/// See also [walletRepository].
@ProviderFor(walletRepository)
final walletRepositoryProvider = AutoDisposeProvider<WalletRepository>.internal(
  walletRepository,
  name: r'walletRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$walletRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WalletRepositoryRef = AutoDisposeProviderRef<WalletRepository>;
String _$walletHash() => r'bc9eaea44d1449936ec6e686be888ce5df83af0b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [wallet].
@ProviderFor(wallet)
const walletProvider = WalletFamily();

/// See also [wallet].
class WalletFamily extends Family<AsyncValue<Wallet?>> {
  /// See also [wallet].
  const WalletFamily();

  /// See also [wallet].
  WalletProvider call(
    String userId,
  ) {
    return WalletProvider(
      userId,
    );
  }

  @override
  WalletProvider getProviderOverride(
    covariant WalletProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'walletProvider';
}

/// See also [wallet].
class WalletProvider extends AutoDisposeFutureProvider<Wallet?> {
  /// See also [wallet].
  WalletProvider(
    String userId,
  ) : this._internal(
          (ref) => wallet(
            ref as WalletRef,
            userId,
          ),
          from: walletProvider,
          name: r'walletProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$walletHash,
          dependencies: WalletFamily._dependencies,
          allTransitiveDependencies: WalletFamily._allTransitiveDependencies,
          userId: userId,
        );

  WalletProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<Wallet?> Function(WalletRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WalletProvider._internal(
        (ref) => create(ref as WalletRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Wallet?> createElement() {
    return _WalletProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WalletProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WalletRef on AutoDisposeFutureProviderRef<Wallet?> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _WalletProviderElement extends AutoDisposeFutureProviderElement<Wallet?>
    with WalletRef {
  _WalletProviderElement(super.provider);

  @override
  String get userId => (origin as WalletProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

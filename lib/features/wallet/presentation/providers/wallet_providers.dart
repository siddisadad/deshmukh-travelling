import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:deshmukh_travelling/core/providers/firebase_providers.dart';
import '../../data/repositories/firebase_wallet_repository.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repositories/wallet_repository.dart';

part 'wallet_providers.g.dart';

@riverpod
WalletRepository walletRepository(WalletRepositoryRef ref) {
  final firestore = ref.watch(firestoreProvider);
  return FirebaseWalletRepository(firestore);
}

@riverpod
Future<Wallet?> wallet(WalletRef ref, String userId) {
  return ref.watch(walletRepositoryProvider).getWallet(userId);
}

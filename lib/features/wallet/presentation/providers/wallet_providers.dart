import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/data/datasources/wallet_datasource.dart';
import '../../data/repositories/firebase_wallet_repository.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repositories/wallet_repository.dart';

final walletDataSourceProvider = Provider<WalletDataSource>((ref) {
  return FirestoreWalletDataSource();
});

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  final dataSource = ref.watch(walletDataSourceProvider);
  return FirebaseWalletRepository(dataSource);
});

final walletProvider = FutureProvider.family<Wallet?, String>((ref, userId) {
  return ref.watch(walletRepositoryProvider).getWallet(userId);
});

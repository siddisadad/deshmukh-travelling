import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/auth_repository.dart';
import '../data/auth_repository_impl.dart';
import '/auth/base_auth_user_provider.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl();
}

@riverpod
Stream<BaseAuthUser?> authStateChanges(AuthStateChangesRef ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
}

@riverpod
class AuthController extends _$AuthController {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<bool> signInWithEmail(BuildContext context, String email, String password) async {
    state = const AsyncValue.loading();
    final result = await ref.read(authRepositoryProvider).signInWithEmail(context, email, password);
    state = result.fold(
      (data) => const AsyncValue.data(null),
      (error) => AsyncValue.error(error, StackTrace.current),
    );
    return result.isSuccess;
  }

  Future<bool> createAccountWithEmail(BuildContext context, String email, String password) async {
    state = const AsyncValue.loading();
    final result = await ref.read(authRepositoryProvider).createAccountWithEmail(context, email, password);
    state = result.fold(
      (data) => const AsyncValue.data(null),
      (error) => AsyncValue.error(error, StackTrace.current),
    );
    return result.isSuccess;
  }

  Future<void> beginPhoneAuth({
    required BuildContext context,
    required String phoneNumber,
    required void Function(BuildContext) onCodeSent,
  }) async {
    state = const AsyncValue.loading();
    final result = await ref.read(authRepositoryProvider).beginPhoneAuth(
      context: context,
      phoneNumber: phoneNumber,
      onCodeSent: onCodeSent,
    );
    state = result.fold(
      (data) => const AsyncValue.data(null),
      (error) => AsyncValue.error(error, StackTrace.current),
    );
  }

  Future<bool> verifySmsCode({
    required BuildContext context,
    required String smsCode,
  }) async {
    state = const AsyncValue.loading();
    final result = await ref.read(authRepositoryProvider).verifySmsCode(
      context: context,
      smsCode: smsCode,
    );
    state = result.fold(
      (data) => const AsyncValue.data(null),
      (error) => AsyncValue.error(error, StackTrace.current),
    );
    return result.isSuccess;
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    final result = await ref.read(authRepositoryProvider).signOut();
    state = result.fold(
      (data) => const AsyncValue.data(null),
      (error) => AsyncValue.error(error, StackTrace.current),
    );
  }
}

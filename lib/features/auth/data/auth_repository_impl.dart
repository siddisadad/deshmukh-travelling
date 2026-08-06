import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/auth/firebase_auth/firebase_user_provider.dart';
import '/features/auth/domain/auth_repository.dart';
import '/core/data/result.dart';
import '/core/logging/app_logger.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Result<BaseAuthUser?>> signInWithEmail(BuildContext context, String email, String password) async {
    try {
      final user = await authManager.signInWithEmail(context, email, password);
      if (user != null) {
        return Result.success(user);
      } else {
        return Result.failure(AuthException('Sign in failed'));
      }
    } catch (e, stack) {
      AppLogger.e('Failed to sign in with email', e, stack);
      return Result.failure(AuthException(e.toString()));
    }
  }

  @override
  Future<Result<BaseAuthUser?>> createAccountWithEmail(BuildContext context, String email, String password) async {
    try {
      final user = await authManager.createAccountWithEmail(context, email, password);
      if (user != null) {
        return Result.success(user);
      } else {
        return Result.failure(AuthException('Account creation failed'));
      }
    } catch (e, stack) {
      AppLogger.e('Failed to create account with email', e, stack);
      return Result.failure(AuthException(e.toString()));
    }
  }

  @override
  Future<Result<void>> beginPhoneAuth({
    required BuildContext context,
    required String phoneNumber,
    required void Function(BuildContext) onCodeSent,
  }) async {
    try {
      await authManager.beginPhoneAuth(
        context: context,
        phoneNumber: phoneNumber,
        onCodeSent: onCodeSent,
      );
      return Result.success(null);
    } catch (e, stack) {
      AppLogger.e('Failed to begin phone auth', e, stack);
      return Result.failure(AuthException(e.toString()));
    }
  }

  @override
  Future<Result<BaseAuthUser?>> verifySmsCode({
    required BuildContext context,
    required String smsCode,
  }) async {
    try {
      final user = await authManager.verifySmsCode(context: context, smsCode: smsCode);
      if (user != null) {
        return Result.success(user);
      } else {
        return Result.failure(AuthException('SMS verification failed'));
      }
    } catch (e, stack) {
      AppLogger.e('Failed to verify SMS code', e, stack);
      return Result.failure(AuthException(e.toString()));
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await authManager.signOut();
      return Result.success(null);
    } catch (e, stack) {
      AppLogger.e('Failed to sign out', e, stack);
      return Result.failure(AuthException(e.toString()));
    }
  }

  @override
  Stream<BaseAuthUser?> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges().map((user) {
      if (user == null) return null;
      return DeshmukhTravellingFirebaseUser(user);
    });
  }
}

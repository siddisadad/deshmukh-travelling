import 'package:flutter/material.dart';
import '/core/data/result.dart';
import '/auth/base_auth_user_provider.dart';

abstract class AuthRepository {
  Future<Result<BaseAuthUser?>> signInWithEmail(BuildContext context, String email, String password);
  Future<Result<BaseAuthUser?>> createAccountWithEmail(BuildContext context, String email, String password);
  Future<Result<void>> beginPhoneAuth({
    required BuildContext context,
    required String phoneNumber,
    required void Function(BuildContext) onCodeSent,
  });
  Future<Result<BaseAuthUser?>> verifySmsCode({
    required BuildContext context,
    required String smsCode,
  });
  Future<Result<void>> signOut();
  Stream<BaseAuthUser?> authStateChanges();
}

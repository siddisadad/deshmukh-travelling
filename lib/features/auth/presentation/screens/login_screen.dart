import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '/core/design_system/tokens.dart';
import '/core/design_system/components/app_button.dart';
import '/core/design_system/components/app_text_field.dart';
import '../auth_providers.dart';
import '/l10n/app_localizations.dart';

class LoginOTPWidget extends ConsumerStatefulWidget {
  const LoginOTPWidget({super.key});

  static String routeName = 'LoginOTP';
  static String routePath = '/loginOTP';

  @override
  ConsumerState<LoginOTPWidget> createState() => _LoginOTPWidgetState();
}

class _LoginOTPWidgetState extends ConsumerState<LoginOTPWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  bool _isOtpSent = false;
  bool _isEmailLogin = false;
  String _phoneNumber = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildWelcomeText(l10n),
                  const SizedBox(height: AppSpacing.lg),
                  if (!_isOtpSent) _buildLoginTypeToggle(),
                  const SizedBox(height: AppSpacing.lg),
                  if (_isEmailLogin) _buildEmailForm(l10n) else _buildPhoneForm(l10n),
                  const SizedBox(height: AppSpacing.xl),
                  AppButton(
                    text: _isOtpSent ? l10n.verifyOtp : (_isEmailLogin ? l10n.login : l10n.sendOtp),
                    isLoading: authState.isLoading,
                    isFullWidth: true,
                    onPressed: _handleLogin,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _buildFooter(l10n),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 280,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(AppRadius.xxl),
              bottomRight: Radius.circular(AppRadius.xxl),
            ),
            child: CachedNetworkImage(
              imageUrl: 'https://dimg.dreamflow.cloud/v1/image/modern%20luxury%20travel%20bus%20on%20highway%20mountain%20background',
              height: 280,
              width: double.infinity,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(color: AppColors.primary),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary.withValues(alpha: 0.8), AppColors.primary.withValues(alpha: 0.9)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(AppRadius.xxl),
                bottomRight: Radius.circular(AppRadius.xxl),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: const Icon(Icons.directions_bus_rounded, color: AppColors.primary, size: 42),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  AppLocalizations.of(context)!.appTitle,
                  style: AppTypography.headlineMedium.copyWith(color: Colors.white, fontWeight: FontWeight.w900),
                ),
                Text(
                  'By Deshmukh Technologies LLP',
                  style: AppTypography.labelMedium.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeText(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _isOtpSent ? l10n.verifyOtp : l10n.welcomeBack,
          style: AppTypography.headlineMedium.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          _isOtpSent
              ? 'Enter the 6-digit code sent to +91 $_phoneNumber'
              : (_isEmailLogin ? 'Login with your email and password' : l10n.enterPhone),
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildLoginTypeToggle() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isEmailLogin = false),
              child: Container(
                decoration: BoxDecoration(
                  color: !_isEmailLogin ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Phone',
                  style: AppTypography.labelMedium.copyWith(
                    color: !_isEmailLogin ? Colors.white : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isEmailLogin = true),
              child: Container(
                decoration: BoxDecoration(
                  color: _isEmailLogin ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Email',
                  style: AppTypography.labelMedium.copyWith(
                    color: _isEmailLogin ? Colors.white : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailForm(AppLocalizations l10n) {
    return Column(
      children: [
        AppTextField(
          controller: _emailController,
          label: l10n.emailAddress,
          hintText: 'Enter your email',
          prefixIcon: const Icon(Icons.email_outlined, color: AppColors.primary),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          controller: _passwordController,
          label: l10n.password,
          hintText: 'Enter your password',
          prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primary),
          obscureText: true,
        ),
      ],
    );
  }

  Widget _buildPhoneForm(AppLocalizations l10n) {
    if (_isOtpSent) {
      return AppTextField(
        controller: _otpController,
        label: l10n.verifyOtp,
        hintText: 'Enter 6-digit OTP',
        prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.primary),
        keyboardType: TextInputType.number,
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 80,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.alternate),
          ),
          alignment: Alignment.center,
          child: Text('+91', style: AppTypography.titleMedium),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: AppTextField(
            controller: _phoneController,
            label: l10n.phoneNumber,
            hintText: '98765 43210',
            keyboardType: TextInputType.phone,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(AppLocalizations l10n) {
    return Column(
      children: [
        if (!_isOtpSent)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(l10n.dontHaveAccount),
              TextButton(
                onPressed: () => context.pushNamed('Signup'),
                child: Text(l10n.signUp, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          )
        else
          TextButton(
            onPressed: () => setState(() => _isOtpSent = false),
            child: Text(l10n.changePhone, style: const TextStyle(decoration: TextDecoration.underline)),
          ),
        const SizedBox(height: AppSpacing.xl),
        Text(l10n.agreeTerms, style: AppTypography.labelSmall),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(l10n.termsOfService, style: AppTypography.labelSmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
            const SizedBox(width: 4),
            Text('&', style: AppTypography.labelSmall),
            const SizedBox(width: 4),
            Text(l10n.privacyPolicy, style: AppTypography.labelSmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  Future<void> _handleLogin() async {
    if (_isEmailLogin) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      if (email.isEmpty || password.isEmpty) {
        _showSnackBar('Please enter email and password');
        return;
      }
      final success = await ref.read(authControllerProvider.notifier).signInWithEmail(context, email, password);
      if (success) {
        context.goNamed('HomeDashboard');
      }
    } else {
      if (!_isOtpSent) {
        final phone = _phoneController.text.trim();
        if (phone.isEmpty) {
          _showSnackBar('Please enter phone number');
          return;
        }
        _phoneNumber = phone;
        await ref.read(authControllerProvider.notifier).beginPhoneAuth(
          context: context,
          phoneNumber: '+91$phone',
          onCodeSent: (context) => setState(() => _isOtpSent = true),
        );
      } else {
        final otp = _otpController.text.trim();
        if (otp.isEmpty) {
          _showSnackBar('Please enter OTP');
          return;
        }
        final success = await ref.read(authControllerProvider.notifier).verifySmsCode(context: context, smsCode: otp);
        if (success) {
          context.goNamed('HomeDashboard');
        }
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

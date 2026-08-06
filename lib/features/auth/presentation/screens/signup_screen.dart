import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '/core/design_system/tokens.dart';
import '/core/design_system/components/app_button.dart';
import '/core/design_system/components/app_text_field.dart';
import '../auth_providers.dart';
import '/l10n/app_localizations.dart';
import '/backend/schema/users_record.dart';
import '/backend/firebase/firestore_service.dart';
import '/auth/firebase_auth/auth_util.dart';

class SignupWidget extends ConsumerStatefulWidget {
  const SignupWidget({super.key});

  static String routeName = 'Signup';
  static String routePath = '/signup';

  @override
  ConsumerState<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends ConsumerState<SignupWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  DateTime? _dateOfBirth;
  final _firestoreService = FirestoreService();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
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
            _buildHeader(l10n),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTextField(
                      controller: _nameController,
                      label: l10n.fullName,
                      hintText: l10n.enterName,
                      prefixIcon: const Icon(Icons.person_outline),
                      validator: (value) => value?.isEmpty ?? true ? 'Please enter your name' : null,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      controller: _emailController,
                      label: l10n.emailAddress,
                      hintText: 'example@mail.com',
                      prefixIcon: const Icon(Icons.email_outlined),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value?.isEmpty ?? true ? 'Please enter your email' : null,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      controller: _passwordController,
                      label: l10n.password,
                      hintText: 'Create a password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      obscureText: true,
                      validator: (value) => (value?.length ?? 0) < 6 ? 'Password must be at least 6 characters' : null,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      controller: _phoneController,
                      label: l10n.phoneNumber,
                      hintText: '98765 43210',
                      prefixIcon: const Icon(Icons.phone_outlined),
                      keyboardType: TextInputType.phone,
                      validator: (value) => value?.isEmpty ?? true ? 'Please enter your phone number' : null,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildDobPicker(l10n),
                    const SizedBox(height: AppSpacing.xl),
                    AppButton(
                      text: l10n.createAccount,
                      isLoading: authState.isLoading,
                      isFullWidth: true,
                      onPressed: _handleSignup,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(l10n.alreadyHaveAccount),
                        TextButton(
                          onPressed: () => context.pushNamed('LoginOTP'),
                          child: Text(l10n.login, style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Container(
      height: 200,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(AppRadius.xxl),
              bottomRight: Radius.circular(AppRadius.xxl),
            ),
            child: CachedNetworkImage(
              imageUrl: 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=500&q=80',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(color: AppColors.primary),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary.withValues(alpha: 0.8), AppColors.primary],
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
                Text(
                  l10n.createAccount,
                  style: AppTypography.headlineMedium.copyWith(color: Colors.white, fontWeight: FontWeight.w900),
                ),
                Text(
                  l10n.joinDeshmukh,
                  style: AppTypography.labelMedium.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDobPicker(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.dateOfBirth, style: AppTypography.labelMedium.copyWith(color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        InkWell(
          onTap: _selectDate,
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.alternate),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today_outlined, color: AppColors.textSecondary, size: 20),
                const SizedBox(width: 12),
                Text(
                  _dateOfBirth == null ? l10n.selectDate : DateFormat('dd MMM yyyy').format(_dateOfBirth!),
                  style: AppTypography.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() => _dateOfBirth = selectedDate);
    }
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;
    if (_dateOfBirth == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select your date of birth')));
      return;
    }

    final success = await ref.read(authControllerProvider.notifier).createAccountWithEmail(
      context,
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (success) {
      final user = currentUser;
      if (user != null) {
        await _firestoreService.createUser(
          UsersRecord(
            uid: user.uid,
            email: _emailController.text.trim(),
            displayName: _nameController.text.trim(),
            phoneNumber: _phoneController.text.trim(),
            dob: _dateOfBirth,
            createdTime: DateTime.now(),
          ),
        );
      }
      context.goNamed('HomeDashboard');
    }
  }
}

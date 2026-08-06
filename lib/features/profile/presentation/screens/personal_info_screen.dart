import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/components/button/button_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/components/app_header.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/l10n/app_localizations.dart';
import '../providers/profile_providers.dart';

class PersonalInfoScreen extends ConsumerStatefulWidget {
  const PersonalInfoScreen({super.key});

  static String routeName = 'PersonalInfo';
  static String routePath = '/personalInfo';

  @override
  ConsumerState<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends ConsumerState<PersonalInfoScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  DateTime? _dob;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(userProfileProvider).value;
      if (user != null) {
        _nameController.text = user.displayName ?? '';
        _emailController.text = user.email ?? '';
        _phoneController.text = user.phoneNumber ?? '';
        setState(() {
          _dob = user.dob;
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProfileProvider);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        children: [
          const AppHeader(title: 'Personal Information'),
          Expanded(
            child: userAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (user) => Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                  child: Column(
                    children: [
                      TextFieldWidget(
                        label: AppLocalizations.of(context)!.fullName,
                        labelPresent: true,
                        hint: AppLocalizations.of(context)!.enterName,
                        leadingIconPresent: true,
                        leadingIcon: const Icon(Icons.person_outline),
                        controller: _nameController,
                        validator: (val) {
                          if (val == null || val.isEmpty) return 'Please enter your name';
                          return null;
                        },
                      ),
                      SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.md),
                      TextFieldWidget(
                        label: AppLocalizations.of(context)!.emailAddress,
                        labelPresent: true,
                        hint: 'Your email',
                        leadingIconPresent: true,
                        leadingIcon: const Icon(Icons.email_outlined),
                        controller: _emailController,
                      ),
                      SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.md),
                      TextFieldWidget(
                        label: AppLocalizations.of(context)!.phoneNumber,
                        labelPresent: true,
                        hint: 'Your phone number',
                        leadingIconPresent: true,
                        leadingIcon: const Icon(Icons.phone_outlined),
                        controller: _phoneController,
                        validator: (val) {
                          if (val == null || val.isEmpty) return 'Please enter phone number';
                          if (val.length != 10) return 'Invalid number';
                          return null;
                        },
                      ),
                      SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.md),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.dateOfBirth,
                            style: FlutterFlowTheme.of(context).labelLarge,
                          ),
                          const SizedBox(height: 8.0),
                          InkWell(
                            onTap: () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: _dob ?? DateTime.now().subtract(const Duration(days: 365 * 18)),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (selectedDate != null) {
                                setState(() {
                                  _dob = selectedDate;
                                });
                              }
                            },
                            child: Container(
                              height: 56.0,
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.md),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today_outlined, size: 20),
                                  const SizedBox(width: 12),
                                  Text(
                                    _dob == null ? AppLocalizations.of(context)!.selectDate : DateFormat('dd MMM yyyy').format(_dob!),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.xl),
                      ButtonWidget(
                        content: 'Save Changes',
                        variant: 'primary',
                        size: 'large',
                        fullWidth: true,
                        onTap: () async {
                          if (!_formKey.currentState!.validate()) return;

                          if (user != null) {
                            final updatedUser = user.copyWith(
                              displayName: _nameController.text,
                              email: _emailController.text,
                              phoneNumber: _phoneController.text,
                              dob: _dob,
                            );

                            final result = await ref.read(userProfileProvider.notifier).updateProfile(updatedUser);

                            result.fold(
                              (data) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Profile updated successfully')),
                                );
                                context.safePop();
                              },
                              (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Failed to update profile: ${error.message}')),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

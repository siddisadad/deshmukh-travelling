import '/auth/firebase_auth/auth_util.dart';
import '/components/button/button_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../../l10n/app_localizations.dart';
import '/backend/schema/users_record.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'signup_model.dart';
export 'signup_model.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key});

  static String routeName = 'Signup';
  static String routePath = '/signup';

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  late SignupModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignupModel());

    _model.nameModel.inputTextController ??= TextEditingController();
    _model.emailModel.inputTextController ??= TextEditingController();
    _model.passwordModel.inputTextController ??= TextEditingController();
    _model.phoneModel.inputTextController ??= TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isProfileCompletion = false; // Simplified for fix

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 200.0,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(FlutterFlowTheme.of(context).designToken.radius.xxl),
                        bottomRight: Radius.circular(FlutterFlowTheme.of(context).designToken.radius.xxl),
                      ),
                      child: Container(
                        height: 200.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0),
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 200.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            FlutterFlowTheme.of(context).primary.withValues(alpha: 0.8),
                            FlutterFlowTheme.of(context).primary
                          ],
                          begin: AlignmentDirectional(0.0, -1.0),
                          end: AlignmentDirectional(0, 1.0),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(FlutterFlowTheme.of(context).designToken.radius.xxl),
                          bottomRight: Radius.circular(FlutterFlowTheme.of(context).designToken.radius.xxl),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.createAccount,
                            style: FlutterFlowTheme.of(context).headlineMedium.override(
                              font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w900),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.joinDeshmukh,
                            style: FlutterFlowTheme.of(context).labelMedium.override(
                              font: GoogleFonts.inter(),
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      wrapWithModel(
                        model: _model.nameModel,
                        updateCallback: () => safeSetState(() {}),
                        child: TextFieldWidget(
                          label: AppLocalizations.of(context)!.fullName,
                          hint: AppLocalizations.of(context)!.enterName,
                          leadingIconPresent: true,
                          leadingIcon: const Icon(Icons.person_outline),
                          controller: _model.nameModel.inputTextController,
                          focusNode: _model.nameModel.inputFocusNode,
                        ),
                      ),
                      SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.md),
                      wrapWithModel(
                        model: _model.emailModel,
                        updateCallback: () => safeSetState(() {}),
                        child: TextFieldWidget(
                          label: AppLocalizations.of(context)!.emailAddress,
                          hint: 'example@mail.com',
                          leadingIconPresent: true,
                          leadingIcon: const Icon(Icons.email_outlined),
                          keyboardType: TextInputType.emailAddress,
                          controller: _model.emailModel.inputTextController,
                          focusNode: _model.emailModel.inputFocusNode,
                        ),
                      ),
                      SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.md),
                      if (!isProfileCompletion)
                        wrapWithModel(
                          model: _model.passwordModel,
                          updateCallback: () => safeSetState(() {}),
                          child: TextFieldWidget(
                            label: AppLocalizations.of(context)!.password,
                            hint: 'Create a password',
                            leadingIconPresent: true,
                            leadingIcon: const Icon(Icons.lock_outline),
                            obscureText: true,
                            controller: _model.passwordModel.inputTextController,
                            focusNode: _model.passwordModel.inputFocusNode,
                          ),
                        ),
                      SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.md),
                      wrapWithModel(
                        model: _model.phoneModel,
                        updateCallback: () => safeSetState(() {}),
                        child: TextFieldWidget(
                          label: AppLocalizations.of(context)!.phoneNumber,
                          hint: '98765 43210',
                          leadingIconPresent: true,
                          leadingIcon: const Icon(Icons.phone_outlined),
                          keyboardType: TextInputType.phone,
                          controller: _model.phoneModel.inputTextController,
                          focusNode: _model.phoneModel.inputFocusNode,
                        ),
                      ),
                      SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.md),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.dateOfBirth,
                            style: FlutterFlowTheme.of(context).labelLarge.override(
                                  font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                  color: FlutterFlowTheme.of(context).primaryText,
                                ),
                          ),
                          SizedBox(height: 8.0),
                          InkWell(
                            onTap: () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (selectedDate != null) {
                                safeSetState(() {
                                  _model.dateOfBirth = selectedDate;
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
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today_outlined,
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    size: 20.0,
                                  ),
                                  const SizedBox(width: 12.0),
                                  Text(
                                    _model.dateOfBirth == null
                                        ? AppLocalizations.of(context)!.selectDate
                                        : DateFormat('dd MMM yyyy').format(_model.dateOfBirth!),
                                    style: FlutterFlowTheme.of(context).bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.xl),
                      wrapWithModel(
                        model: _model.signupButtonModel,
                        updateCallback: () => safeSetState(() {}),
                        child: ButtonWidget(
                          content: AppLocalizations.of(context)!.createAccount,
                          variant: 'primary',
                          size: 'large',
                          fullWidth: true,
                          onTap: () async {
                            if (!_formKey.currentState!.validate()) return;

                            final name = _model.nameModel.inputTextController.text;
                            final email = _model.emailModel.inputTextController.text;
                            final password = _model.passwordModel.inputTextController.text;
                            final phone = _model.phoneModel.inputTextController.text;
                            final dob = _model.dateOfBirth;

                            if (name.isEmpty || email.isEmpty || (password.isEmpty && !isProfileCompletion) || phone.isEmpty || dob == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please fill all fields')),
                              );
                              return;
                            }

                            final user = await authManager.createAccountWithEmail(
                              context,
                              email,
                              password,
                            );

                            if (user != null) {
                              await _model.firestoreService.createUser(
                                UsersRecord(
                                  uid: user.uid,
                                  email: email,
                                  displayName: name,
                                  phoneNumber: phone,
                                  dob: dob,
                                  createdTime: DateTime.now(),
                                ),
                              );
                              context.goNamed('HomeDashboard');
                            }
                          },
                        ),
                      ),
                      SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context)!.alreadyHaveAccount),
                          InkWell(
                            onTap: () => context.pushNamed('LoginOTP'),
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primary,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
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
      ),
    );
  }
}

import '/auth/firebase_auth/auth_util.dart';
import '/components/button/button_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../../l10n/app_localizations.dart';
import '/backend/schema/users_record.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'personal_info_model.dart';
export 'personal_info_model.dart';

class PersonalInfoWidget extends StatefulWidget {
  const PersonalInfoWidget({super.key});

  static String routeName = 'PersonalInfo';
  static String routePath = '/personalInfo';

  @override
  State<PersonalInfoWidget> createState() => _PersonalInfoWidgetState();
}

class _PersonalInfoWidgetState extends State<PersonalInfoWidget> {
  late PersonalInfoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PersonalInfoModel());

    _loadUserData();

    _model.nameModel.inputTextControllerValidator = (context, val) {
      if (val == null || val.isEmpty) return 'Please enter your name';
      return null;
    };
    _model.phoneModel.inputTextControllerValidator = (context, val) {
      if (val == null || val.isEmpty) return 'Please enter phone number';
      if (val.length != 10) return 'Invalid number';
      return null;
    };

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  Future<void> _loadUserData() async {
    final user = await _model.firestoreService.getUser(currentUserUid);
    if (user != null) {
      safeSetState(() {
        _model.userRecord = user;
        _model.nameModel.inputTextController?.text = user.displayName ?? '';
        _model.emailModel.inputTextController?.text = user.email ?? '';
        _model.phoneModel.inputTextController?.text = user.phoneNumber ?? '';
        _model.dob = user.dob;
      });
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: true,
        title: Text(
          'Personal Information',
          style: FlutterFlowTheme.of(context).headlineSmall.override(
            font: GoogleFonts.plusJakartaSans(),
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
          child: Column(
            children: [
              wrapWithModel(
                model: _model.nameModel,
                updateCallback: () => safeSetState(() {}),
                child: TextFieldWidget(
                  label: AppLocalizations.of(context)!.fullName,
                  labelPresent: true,
                  hint: AppLocalizations.of(context)!.enterName,
                  leadingIconPresent: true,
                  leadingIcon: Icon(Icons.person_outline),
                ),
              ),
              SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.md),
              wrapWithModel(
                model: _model.emailModel,
                updateCallback: () => safeSetState(() {}),
                child: TextFieldWidget(
                  label: AppLocalizations.of(context)!.emailAddress,
                  labelPresent: true,
                  hint: 'Your email',
                  leadingIconPresent: true,
                  leadingIcon: Icon(Icons.email_outlined),
                ),
              ),
              SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.md),
              wrapWithModel(
                model: _model.phoneModel,
                updateCallback: () => safeSetState(() {}),
                child: TextFieldWidget(
                  label: AppLocalizations.of(context)!.phoneNumber,
                  labelPresent: true,
                  hint: 'Your phone number',
                  leadingIconPresent: true,
                  leadingIcon: Icon(Icons.phone_outlined),
                ),
              ),
              SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.dateOfBirth,
                    style: FlutterFlowTheme.of(context).labelLarge,
                  ),
                  SizedBox(height: 8.0),
                  InkWell(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: _model.dob ?? DateTime.now().subtract(Duration(days: 365 * 18)),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null) {
                        safeSetState(() {
                          _model.dob = selectedDate;
                        });
                      }
                    },
                    child: Container(
                      height: 56.0,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.md),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today_outlined, size: 20),
                          SizedBox(width: 12),
                          Text(
                            _model.dob == null ? AppLocalizations.of(context)!.selectDate : DateFormat('dd MMM yyyy').format(_model.dob!),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.xl),
              wrapWithModel(
                model: _model.saveButtonModel,
                updateCallback: () => safeSetState(() {}),
                child: ButtonWidget(
                  content: 'Save Changes',
                  variant: 'primary',
                  size: 'large',
                  fullWidth: true,
                  onTap: () async {
                    if (!_formKey.currentState!.validate()) return;

                    final name = _model.nameModel.inputTextController?.text;
                    final phone = _model.phoneModel.inputTextController?.text;

                    if (name != null && phone != null) {
                      await _model.firestoreService.createUser(
                        UsersRecord(
                          uid: currentUserUid,
                          email: _model.emailModel.inputTextController?.text,
                          displayName: name,
                          phoneNumber: phone,
                          dob: _model.dob,
                          createdTime: _model.userRecord?.createdTime,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Profile updated successfully')),
                      );
                      context.safePop();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

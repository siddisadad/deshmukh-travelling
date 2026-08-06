import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/components/button/button_widget.dart';
import '/components/passenger_card/passenger_card_widget.dart';
import '/components/profile_menu_item/profile_menu_item_widget.dart';
import '/components/support_card/support_card_widget.dart';
import '/components/switch_component/switch_component_widget.dart';
import '/components/app_nav_bar.dart';
import '/components/app_header.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/l10n/app_localizations.dart';
import '/index.dart';
import '/main.dart';

import '../providers/profile_providers.dart';
import '../../domain/entities/passenger.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  static const String routeName = 'ProfileSettings';
  static const String routePath = '/profileSettings';

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _addNewPassengerDialog() async {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    String relation = 'Other';

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add New Passenger'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(hintText: 'Full Name')),
              TextField(controller: ageController, decoration: const InputDecoration(hintText: 'Age'), keyboardType: TextInputType.number),
              DropdownButton<String>(
                value: relation,
                items: ['Self', 'Spouse', 'Father', 'Mother', 'Son', 'Daughter', 'Other']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => relation = val!),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            TextButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty) {
                  final p = Passenger(
                    userId: currentUserUid,
                    name: nameController.text,
                    age: int.tryParse(ageController.text) ?? 0,
                    gender: 'Male', // Default for now
                    relation: relation,
                  );
                  await ref.read(savedPassengersProvider.notifier).addPassenger(p);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(BuildContext context, IconData icon, String label, Color bgColor, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(9999.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: textColor, size: 14.0),
            const SizedBox(width: 4.0),
            Text(
              label,
              style: FlutterFlowTheme.of(context).labelSmall.override(
                    font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    color: textColor,
                    lineHeight: 1.4,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProfileProvider);
    final passengersAsync = ref.watch(savedPassengersProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        bottomNavigationBar: AppNavBar(currentRoute: ProfileScreen.routeName),
        body: Column(
          children: [
            AppHeader(
              title: AppLocalizations.of(context)!.profile,
              actionWidget: FlutterFlowIconButton(
                borderRadius: 8.0,
                buttonSize: 40.0,
                fillColor: Colors.transparent,
                icon: Icon(
                  Icons.edit_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 20.0,
                ),
                onPressed: () async {
                  await context.pushNamed(PersonalInfoScreen.routeName);
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.lg),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 12.0,
                              color: Color(0x0D000000),
                              offset: Offset(0.0, 4.0),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                          child: userAsync.when(
                            loading: () => const Center(child: CircularProgressIndicator()),
                            error: (err, stack) => Text('Error loading profile: $err'),
                            data: (user) => Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(9999.0),
                                  child: Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9999.0),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                        width: 3.0,
                                      ),
                                    ),
                                    child: CachedNetworkImage(
                                      fadeInDuration: Duration.zero,
                                      fadeOutDuration: Duration.zero,
                                      imageUrl: user?.photoUrl ?? 'https://dimg.dreamflow.cloud/v1/image/professional%20portrait%20of%20an%20Indian%20man',
                                      fit: BoxFit.cover,
                                      alignment: const Alignment(0.0, 0.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 24.0),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user?.displayName ?? valueOrDefault<String>(
                                          currentUserDisplayName,
                                          'Aditya Deshmukh',
                                        ),
                                        style: FlutterFlowTheme.of(context).headlineSmall.override(
                                              font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                                              color: FlutterFlowTheme.of(context).primaryText,
                                              lineHeight: 1.35,
                                            ),
                                      ),
                                      Text(
                                        user?.phoneNumber ?? valueOrDefault<String>(
                                          currentPhoneNumber,
                                          '+91 98765 43210',
                                        ),
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              font: GoogleFonts.inter(),
                                              color: FlutterFlowTheme.of(context).secondaryText,
                                              lineHeight: 1.5,
                                            ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            _buildBadge(context, Icons.verified_rounded, 'Verified', const Color(0xFFE3F2FD), Colors.blue),
                                            const SizedBox(width: 8.0),
                                            _buildBadge(context, Icons.stars_rounded, 'Gold', const Color(0xFFFFF9C4), const Color(0xFFFBC02D)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Saved Travelers',
                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                      font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      lineHeight: 1.45,
                                    ),
                              ),
                              ButtonWidget(
                                icon: Icon(
                                  Icons.add_rounded,
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                iconPresent: true,
                                iconEndPresent: false,
                                content: 'Add New',
                                variant: 'ghost',
                                size: 'small',
                                fullWidth: false,
                                loading: false,
                                disabled: false,
                                onTap: _addNewPassengerDialog,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          passengersAsync.when(
                            loading: () => const Center(child: CircularProgressIndicator()),
                            error: (err, stack) => Text('Error: $err'),
                            data: (passengers) => SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  for (var p in passengers)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 12.0),
                                      child: PassengerCardWidget(
                                        initials: p.name.substring(0, min(2, p.name.length)).toUpperCase(),
                                        name: p.name,
                                        relation: p.relation,
                                      ),
                                    ),
                                  if (passengers.isEmpty)
                                    Text('No saved travelers', style: FlutterFlowTheme.of(context).bodySmall),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Travel Hub',
                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  lineHeight: 1.45,
                                ),
                          ),
                          const SizedBox(height: 16),
                          ProfileMenuItemWidget(
                            icon: Icon(
                              Icons.history_rounded,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 22.0,
                            ),
                            subtitle: 'View all your past and upcoming trips',
                            title: 'Travel History',
                            onTap: () => context.pushNamed(MyTripsScreen.routeName),
                          ),
                          ProfileMenuItemWidget(
                            icon: Icon(
                              Icons.hotel_outlined,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 22.0,
                            ),
                            subtitle: 'Your favorite stays',
                            title: 'Saved Hotels',
                            onTap: () {},
                          ),
                          ProfileMenuItemWidget(
                            icon: Icon(
                              Icons.route_outlined,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 22.0,
                            ),
                            subtitle: 'Frequently traveled paths',
                            title: 'Saved Routes',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Wallet & Payments',
                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  lineHeight: 1.45,
                                ),
                          ),
                          const SizedBox(height: 16),
                          ProfileMenuItemWidget(
                            icon: Icon(
                              Icons.account_balance_wallet_outlined,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 22.0,
                            ),
                            subtitle: 'Manage balance and transactions',
                            title: 'Wallet',
                            onTap: () => context.pushNamed(WalletScreen.routeName),
                          ),
                          ProfileMenuItemWidget(
                            icon: Icon(
                              Icons.credit_card_outlined,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 22.0,
                            ),
                            subtitle: 'Securely stored payment methods',
                            title: 'Saved Cards',
                            onTap: () {},
                          ),
                          ProfileMenuItemWidget(
                            icon: Icon(
                              Icons.stars_rounded,
                              color: FlutterFlowTheme.of(context).secondary,
                              size: 22.0,
                            ),
                            subtitle: 'Earn and redeem points',
                            title: 'Rewards',
                            onTap: () => context.pushNamed(WalletScreen.routeName),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Account & Identity',
                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  lineHeight: 1.45,
                                ),
                          ),
                          const SizedBox(height: 16),
                          ProfileMenuItemWidget(
                            icon: Icon(
                              Icons.person_outline_rounded,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 22.0,
                            ),
                            subtitle: 'Manage your personal details',
                            title: 'Personal Information',
                            onTap: () => context.pushNamed(PersonalInfoScreen.routeName),
                          ),
                          ProfileMenuItemWidget(
                            icon: Icon(
                              Icons.notifications_none_rounded,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 22.0,
                            ),
                            subtitle: 'Manage alerts and messages',
                            title: 'Notifications',
                            onTap: () => context.pushNamed(NotificationsScreen.routeName),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Achievements',
                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  lineHeight: 1.45,
                                ),
                          ),
                          const SizedBox(height: 16),
                          ProfileMenuItemWidget(
                            icon: Icon(
                              Icons.emoji_events_outlined,
                              color: FlutterFlowTheme.of(context).secondary,
                              size: 22.0,
                            ),
                            subtitle: 'View your milestones and badges',
                            title: 'Badges',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Preferences',
                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  lineHeight: 1.45,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                              borderRadius: BorderRadius.circular(16.0),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 40.0,
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                          borderRadius: BorderRadius.circular(12.0),
                                          shape: BoxShape.rectangle,
                                        ),
                                        alignment: const AlignmentDirectional(0.0, 0.0),
                                        child: Icon(
                                          Icons.dark_mode_rounded,
                                          color: FlutterFlowTheme.of(context).onSurface,
                                          size: 22.0,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Dark Mode',
                                            style: FlutterFlowTheme.of(context).titleSmall.override(
                                                  font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                  lineHeight: 1.5,
                                                ),
                                          ),
                                          Text(
                                            'Switch to night theme',
                                            style: FlutterFlowTheme.of(context).labelSmall.override(
                                                  font: GoogleFonts.inter(),
                                                  color: FlutterFlowTheme.of(context).onSurface,
                                                  lineHeight: 1.4,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SwitchComponentWidget(
                                    label: '',
                                    labelPresent: false,
                                    variant: 'iOS',
                                    active: Theme.of(context).brightness == Brightness.dark,
                                    onChanged: (newValue) async {
                                      MyApp.of(context).setThemeMode(newValue ? ThemeMode.dark : ThemeMode.light);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ProfileMenuItemWidget(
                            icon: Icon(
                              Icons.language_rounded,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 22.0,
                            ),
                            subtitle: 'English (US)',
                            title: 'Language',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Support & Legal',
                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  lineHeight: 1.45,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: SupportCardWidget(
                                  bgLight: const Color(0xFFE8F5E9),
                                  color: const Color(0xFF25D366),
                                  icon: const Icon(
                                    Icons.chat_bubble_outline_rounded,
                                    color: Color(0xFF25D366),
                                    size: 24.0,
                                  ),
                                  label: 'WhatsApp',
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 1,
                                child: SupportCardWidget(
                                  bgLight: const Color(0xFFE3F2FD),
                                  color: FlutterFlowTheme.of(context).primary,
                                  icon: const Icon(
                                    Icons.help_outline_rounded,
                                    color: Color(0xFF25D366),
                                    size: 24.0,
                                  ),
                                  label: 'FAQ',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ProfileMenuItemWidget(
                            icon: Icon(
                              Icons.description_outlined,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 22.0,
                            ),
                            subtitle: 'How we handle your data',
                            title: 'Privacy Policy',
                            onTap: () {},
                          ),
                          ProfileMenuItemWidget(
                            icon: Icon(
                              Icons.info_outline_rounded,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 22.0,
                            ),
                            subtitle: 'Version 1.0.0',
                            title: 'About Deshmukh Travelling',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 32.0),
                      child: ButtonWidget(
                        icon: Icon(
                          Icons.logout_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        iconPresent: true,
                        iconEndPresent: false,
                        content: AppLocalizations.of(context)!.logout,
                        variant: 'destructive',
                        size: 'large',
                        fullWidth: true,
                        loading: false,
                        disabled: false,
                        onTap: () async {
                          await authManager.signOut();
                          context.goNamed(SplashOnboardingWidget.routeName);
                        },
                      ),
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

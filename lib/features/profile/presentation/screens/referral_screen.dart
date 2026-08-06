import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '/components/app_header.dart';
import '/components/button/button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../providers/profile_providers.dart';

class ReferralScreen extends ConsumerWidget {
  const ReferralScreen({super.key});

  static String routeName = 'Referral';
  static String routePath = '/referral';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProfileProvider);

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        children: [
          const AppHeader(title: 'Refer & Earn'),
          Expanded(
            child: userAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (user) => SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Image.network('https://images.unsplash.com/photo-1556742502-ec7c0e9f34b1?w=400&q=80', height: 200),
                    const SizedBox(height: 32),
                    Text('Share the joy of travel!',
                        style: FlutterFlowTheme.of(context).headlineSmall.override(font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold))),
                    const SizedBox(height: 12),
                    Text('Invite your friends to Deshmukh Travelling and earn 100 reward points for each friend who completes their first trip.',
                        textAlign: TextAlign.center, style: FlutterFlowTheme.of(context).bodyMedium),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: FlutterFlowTheme.of(context).alternate, width: 2, style: BorderStyle.solid),
                      ),
                      child: Column(
                        children: [
                          Text('Your Referral Code', style: FlutterFlowTheme.of(context).labelSmall),
                          const SizedBox(height: 8),
                          Text(user?.referralCode ?? 'DESH100',
                              style: FlutterFlowTheme.of(context).displaySmall.override(font: GoogleFonts.inter(fontWeight: FontWeight.bold), color: FlutterFlowTheme.of(context).primary)),
                          const SizedBox(height: 16),
                          ButtonWidget(
                            content: 'Share Now',
                            variant: 'primary',
                            size: 'medium',
                            onTap: () {
                              Share.share('Use my referral code ${user?.referralCode ?? 'DESH100'} to join Deshmukh Travelling and get 50 bonus points! Download now.');
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _statBox(context, 'Total Referrals', '5'), // Mocked for now or added to UserProfile
                        _statBox(context, 'Points Earned', (user?.rewardPoints ?? 0).toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statBox(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(value, style: FlutterFlowTheme.of(context).titleLarge.override(font: GoogleFonts.inter(fontWeight: FontWeight.bold))),
        Text(label, style: FlutterFlowTheme.of(context).labelSmall),
      ],
    );
  }
}

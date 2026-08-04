import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/components/button/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'referral_model.dart';

class ReferralWidget extends StatefulWidget {
  const ReferralWidget({super.key});

  static String routeName = 'Referral';
  static String routePath = '/referral';

  @override
  State<ReferralWidget> createState() => _ReferralWidgetState();
}

class _ReferralWidgetState extends State<ReferralWidget> {
  late ReferralModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReferralModel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        title: Text('Refer & Earn', style: TextStyle(color: Colors.white)),
        leading: FlutterFlowIconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
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
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: FlutterFlowTheme.of(context).alternate, width: 2, style: BorderStyle.solid),
              ),
              child: Column(
                children: [
                  Text('Your Referral Code', style: FlutterFlowTheme.of(context).labelSmall),
                  const SizedBox(height: 8),
                  Text(_model.referralCode,
                      style: FlutterFlowTheme.of(context).displaySmall.override(font: GoogleFonts.inter(fontWeight: FontWeight.bold), color: FlutterFlowTheme.of(context).primary)),
                  const SizedBox(height: 16),
                  ButtonWidget(
                    content: 'Share Now',
                    variant: 'primary',
                    size: 'medium',
                    onTap: () {
                      Share.share('Use my referral code ${_model.referralCode} to join Deshmukh Travelling and get 50 bonus points! Download now.');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _statBox('Total Referrals', _model.totalReferrals.toString()),
                _statBox('Points Earned', _model.pointsEarned.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statBox(String label, String value) {
    return Column(
      children: [
        Text(value, style: FlutterFlowTheme.of(context).titleLarge.override(font: GoogleFonts.inter(fontWeight: FontWeight.bold))),
        Text(label, style: FlutterFlowTheme.of(context).labelSmall),
      ],
    );
  }
}

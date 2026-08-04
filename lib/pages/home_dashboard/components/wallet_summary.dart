import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletSummary extends StatelessWidget {
  final double balance;
  final int rewardPoints;
  final VoidCallback onTap;

  const WalletSummary({
    super.key,
    required this.balance,
    required this.rewardPoints,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.lg),
          boxShadow: [FlutterFlowTheme.of(context).designToken.shadow.sm],
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.account_balance_wallet_rounded,
                      color: FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wallet Balance',
                        style: FlutterFlowTheme.of(context).labelSmall,
                      ),
                      Text(
                        '₹${formatNumber(balance, formatType: FormatType.decimal, decimalType: DecimalType.automatic)}',
                        style: FlutterFlowTheme.of(context).titleMedium.override(
                          font: GoogleFonts.plusJakartaSans(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Rewards',
                    style: FlutterFlowTheme.of(context).labelSmall,
                  ),
                  Row(
                    children: [
                      Icon(Icons.stars_rounded, color: FlutterFlowTheme.of(context).secondary, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '$rewardPoints pts',
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.plusJakartaSans(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

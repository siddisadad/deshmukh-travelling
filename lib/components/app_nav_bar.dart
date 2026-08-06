import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../index.dart';

class AppNavBar extends StatelessWidget {
  final String currentRoute;

  const AppNavBar({
    super.key,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 10.0,
            color: Color(0x1A000000),
            offset: Offset(0.0, -2.0),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(
                context,
                Icons.home_rounded,
                'Home',
                HomeDashboardScreen.routeName,
              ),
              _navItem(
                context,
                Icons.confirmation_number_rounded,
                'My Trips',
                MyTripsScreen.routeName,
              ),
              _navItem(
                context,
                Icons.mosque_rounded,
                'Hajj',
                HajjDashboardScreen.routeName,
              ),
              _navItem(
                context,
                Icons.account_balance_wallet_rounded,
                'Wallet',
                WalletScreen.routeName,
              ),
              _navItem(
                context,
                Icons.person_rounded,
                'Profile',
                ProfileScreen.routeName,
              ),
            ],
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),
        ),
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    IconData icon,
    String label,
    String routeName,
  ) {
    bool isSelected = currentRoute == routeName;
    return InkWell(
      onTap: () {
        if (!isSelected) {
          context.goNamed(routeName);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected
                ? FlutterFlowTheme.of(context).primary
                : FlutterFlowTheme.of(context).secondaryText,
            size: 24.0,
          ),
          const SizedBox(height: 4.0),
          Text(
            label,
            style: FlutterFlowTheme.of(context).labelSmall.override(
                  fontFamily: 'Inter',
                  color: isSelected
                      ? FlutterFlowTheme.of(context).primary
                      : FlutterFlowTheme.of(context).secondaryText,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ],
      ),
    );
  }
}

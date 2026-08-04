import '/auth/firebase_auth/auth_util.dart';
import '/backend/schema/wallet_record.dart';
import '/components/button/button_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'wallet_model.dart';
export 'wallet_model.dart';

class WalletWidget extends StatefulWidget {
  const WalletWidget({super.key});

  static String routeName = 'Wallet';
  static String routePath = '/wallet';

  @override
  State<WalletWidget> createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  late WalletModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WalletModel());
    _model.walletFuture = _model.firestoreService.getWallet(currentUserUid);

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  Future<void> _addMoneyDialog() async {
    final amountController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Money to Wallet'),
        content: TextField(
          controller: amountController,
          decoration: const InputDecoration(
              hintText: 'Enter amount (₹)', prefixText: '₹'),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              final amount = double.tryParse(amountController.text);
              if (amount != null && amount > 0) {
                await _model.firestoreService.updateWalletBalance(
                  currentUserUid,
                  amount,
                  'credit',
                  'Added to wallet',
                );
                Navigator.pop(context);
                setState(() {
                  _model.walletFuture =
                      _model.firestoreService.getWallet(currentUserUid);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('₹${amount.toInt()} added to wallet')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _redeemPointsDialog() async {
    final rewards = await _model.firestoreService.getRewards(currentUserUid);
    final points = rewards?.points ?? 0;
    final cashValue = points * 0.1;

    if (points == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No points available to redeem')),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Redeem Points'),
        content: Text(
            'You have $points points. Redeeming them will add ₹${cashValue.toInt()} to your wallet. Proceed?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              await _model.firestoreService.redeemPoints(currentUserUid, points);
              Navigator.pop(context);
              setState(() {
                _model.walletFuture =
                    _model.firestoreService.getWallet(currentUserUid);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('₹${cashValue.toInt()} added to wallet')),
              );
            },
            child: const Text('Redeem All'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            buttonSize: 60.0,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 24.0,
            ),
            onPressed: () => context.safePop(),
          ),
          title: Text(
            'Wallet & Rewards',
            style: FlutterFlowTheme.of(context).headlineSmall.override(
                  font: GoogleFonts.plusJakartaSans(),
                  color: Colors.white,
                ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Wallet'),
              Tab(text: 'Rewards'),
            ],
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
          ),
          elevation: 0,
        ),
        body: TabBarView(
          children: [
            _buildWalletTab(),
            _buildRewardsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletTab() {
    return FutureBuilder<WalletRecord?>(
      future: _model.walletFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final wallet = snapshot.data;

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32.0),
                    bottomRight: Radius.circular(32.0),
                  ),
                ),
                padding: const EdgeInsets.fromSTEB(24.0, 0.0, 24.0, 40.0),
                child: Column(
                  children: [
                    Text(
                      'Available Balance',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(),
                            color: Colors.white.withOpacity(0.8),
                          ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '₹${wallet?.balance.toInt() ?? 0}',
                      style: FlutterFlowTheme.of(context).displayMedium.override(
                            font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(height: 32.0),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonWidget(
                            content: 'Add Money',
                            variant: 'secondary',
                            size: 'medium',
                            onTap: _addMoneyDialog,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: ButtonWidget(
                            content: 'Withdraw',
                            variant: 'ghost',
                            size: 'medium',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transaction History',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                          ),
                    ),
                    const SizedBox(height: 16.0),
                    if (wallet == null || wallet.transactions.isEmpty)
                      const Center(child: Text('No transactions yet'))
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: wallet.transactions.length,
                        separatorBuilder: (_, __) => const Divider(height: 32.0),
                        itemBuilder: (context, index) {
                          final tx = wallet.transactions[index];
                          final isCredit = tx.type == 'credit';
                          return Row(
                            children: [
                              Container(
                                width: 44.0,
                                height: 44.0,
                                decoration: BoxDecoration(
                                  color: (isCredit ? Colors.green : Colors.red).withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isCredit ? Icons.add_rounded : Icons.remove_rounded,
                                  color: isCredit ? Colors.green : Colors.red,
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tx.description,
                                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                                            font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                          ),
                                    ),
                                    Text(
                                      DateFormat('dd MMM yyyy, hh:mm a').format(tx.timestamp),
                                      style: FlutterFlowTheme.of(context).labelSmall,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${isCredit ? "+" : "-"} ₹${tx.amount.toInt()}',
                                style: FlutterFlowTheme.of(context).bodyLarge.override(
                                      font: GoogleFonts.inter(fontWeight: FontWeight.bold),
                                      color: isCredit ? Colors.green : Colors.red,
                                    ),
                              ),
                            ],
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRewardsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [FlutterFlowTheme.of(context).secondary, FlutterFlowTheme.of(context).tertiary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Icon(Icons.stars_rounded, color: Colors.white, size: 48),
                const SizedBox(height: 8),
                Text(
                  '450 Points',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                        color: Colors.white,
                      ),
                ),
                Text(
                  '≈ ₹45 in Wallet',
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        font: GoogleFonts.inter(),
                        color: Colors.white70,
                      ),
                ),
                const SizedBox(height: 16),
                ButtonWidget(
                  content: 'Redeem Now',
                  variant: 'secondary',
                  size: 'small',
                  onTap: _redeemPointsDialog,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Refer & Earn',
            style: FlutterFlowTheme.of(context).titleMedium.override(
                  font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryContainer,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: FlutterFlowTheme.of(context).primary.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.people_rounded, color: Colors.blue, size: 40),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Invite Friends', style: FlutterFlowTheme.of(context).titleSmall.override(font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold))),
                          Text('Earn 100 points for every friend who joins!', style: FlutterFlowTheme.of(context).bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('DESHMUKH2026', style: GoogleFonts.inter(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                      InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Referral code copied!')));
                        },
                        child: Text('COPY', style: TextStyle(color: FlutterFlowTheme.of(context).primary, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Exclusive Offers',
            style: FlutterFlowTheme.of(context).titleMedium.override(
                  font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                ),
          ),
          const SizedBox(height: 16),
          _rewardItem(
            'Hotel Discount',
            'Flat 15% off on your next hotel booking',
            '100 pts',
            Icons.hotel_rounded,
            Colors.blue,
          ),
          const SizedBox(height: 12),
          _rewardItem(
            'Bus Voucher',
            '₹100 off on bus tickets above ₹500',
            '150 pts',
            Icons.directions_bus_rounded,
            Colors.green,
          ),
          const SizedBox(height: 12),
          _rewardItem(
            'Taxi Credit',
            'Get ₹50 cashback on your next cab ride',
            '50 pts',
            Icons.local_taxi_rounded,
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _rewardItem(String title, String desc, String pts, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: FlutterFlowTheme.of(context).alternate),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
                      ),
                ),
                Text(desc, style: FlutterFlowTheme.of(context).bodySmall),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              pts,
              style: FlutterFlowTheme.of(context).labelSmall.override(
                    font: GoogleFonts.inter(),
                    color: FlutterFlowTheme.of(context).primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

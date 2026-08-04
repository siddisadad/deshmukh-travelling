import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../auth/firebase_auth/auth_util.dart';
import '../../../../components/button/button_widget.dart';
import '../../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../flutter_flow/flutter_flow_util.dart';
import '../../domain/entities/wallet.dart';
import '../providers/wallet_providers.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  static String routeName = 'WalletV2';
  static String routePath = '/walletV2';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletAsync = ref.watch(walletProvider(currentUserUid));

    return Scaffold(
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
          'Deshmukh Wallet (Clean)',
          style: FlutterFlowTheme.of(context).headlineSmall.override(
                fontFamily: 'Outfit',
                color: Colors.white,
              ),
        ),
        elevation: 0,
      ),
      body: walletAsync.when(
        data: (wallet) => _WalletContent(wallet: wallet),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _WalletContent extends ConsumerWidget {
  final Wallet? wallet;
  const _WalletContent({this.wallet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 40.0),
            child: Column(
              children: [
                Text(
                  'Available Balance',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '₹${wallet?.balance.toInt() ?? 0}',
                  style: FlutterFlowTheme.of(context).displayMedium.override(
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.bold,
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
                        onTap: () => _addMoney(context, ref),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: ButtonWidget(
                        content: 'Redeem Points',
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
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16.0),
                if (wallet == null || wallet!.transactions.isEmpty)
                  const Center(child: Text('No transactions yet'))
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: wallet!.transactions.length,
                    separatorBuilder: (_, __) => const Divider(height: 32.0),
                    itemBuilder: (context, index) {
                      final tx = wallet!.transactions[index];
                      final isCredit = tx.type == WalletTransactionType.credit;
                      return Row(
                        children: [
                          Container(
                            width: 44.0,
                            height: 44.0,
                            decoration: BoxDecoration(
                              color: (isCredit ? Colors.green : Colors.red).withValues(alpha: 0.1),
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
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
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
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
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
  }

  Future<void> _addMoney(BuildContext context, WidgetRef ref) async {
    final amountController = TextEditingController();
    final amount = await showDialog<double>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Money'),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Amount', prefixText: '₹'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, double.tryParse(amountController.text)),
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (amount != null && amount > 0) {
      await ref.read(walletRepositoryProvider).addMoney(currentUserUid, amount);
      await ref.read(walletRepositoryProvider).recordTransaction(
        currentUserUid,
        WalletTransaction(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          amount: amount,
          type: WalletTransactionType.credit,
          description: 'Added via Riverpod Refactor',
          timestamp: DateTime.now(),
        ),
      );
      // Invalidate the provider to refresh
      ref.invalidate(walletProvider(currentUserUid));
    }
  }
}

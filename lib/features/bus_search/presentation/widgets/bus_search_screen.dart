import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/tokens.dart';
import '../providers/bus_search_providers.dart';
import 'bus_list_item.dart';

class BusSearchScreen extends ConsumerWidget {
  final String from;
  final String to;
  final DateTime? date;

  const BusSearchScreen({
    super.key,
    required this.from,
    required this.to,
    this.date,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = BusSearchParams(from: from, to: to, date: date);
    final busesAsync = ref.watch(busSearchResultsProvider(params));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$from to $to', style: AppTypography.titleMedium),
            if (date != null) Text(date!.toString().split(' ')[0], style: AppTypography.labelMedium),
          ],
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.background,
      body: busesAsync.when(
        data: (buses) => ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.md),
          itemCount: buses.length,
          itemBuilder: (context, index) => BusListItem(bus: buses[index]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

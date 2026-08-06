import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../../core/design_system/components/app_card.dart';
import '../../../../components/bus_card/bus_card_widget.dart';
import '../../../../components/app_header.dart';
import '../../../../flutter_flow/flutter_flow_util.dart';
import '../providers/booking_providers.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';
import 'seat_selection_screen.dart';

class BusSearchResultsScreen extends ConsumerStatefulWidget {
  final String fromLocation;
  final String toLocation;
  final DateTime date;

  const BusSearchResultsScreen({
    super.key,
    required this.fromLocation,
    required this.toLocation,
    required this.date,
  });

  static String routeName = 'BusSearchResults';
  static String routePath = '/busSearchResults';

  @override
  ConsumerState<BusSearchResultsScreen> createState() => _BusSearchResultsScreenState();
}

class _BusSearchResultsScreenState extends ConsumerState<BusSearchResultsScreen> {
  String selectedFilter = 'All';
  String sortBy = 'Price';
  String? timeFilter;

  @override
  Widget build(BuildContext context) {
    final busesAsync = ref.watch(busSearchProvider((from: widget.fromLocation, to: widget.toLocation)));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          AppHeader(
            title: AppLocalizations.of(context)!.availableBuses,
            onBackPress: () => context.pop(),
            bottom: _buildSearchInfo(),
          ),
          _buildFilters(),
          Expanded(
            child: busesAsync.when(
              data: (buses) {
                final filteredBuses = _applyFilters(buses);
                if (filteredBuses.isEmpty) {
                  return const Center(child: Text('No buses found for selected filters'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: filteredBuses.length,
                  separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final bus = filteredBuses[index];
                    return BusCardWidget(
                      bus: bus,
                      arrTime: bus.arrTime,
                      depTime: bus.depTime,
                      duration: '4h 15m',
                      operator: bus.name,
                      price: bus.price.toInt().toString(),
                      rating: bus.rating,
                      seats: bus.seatsAvailable,
                      type: bus.type,
                      onTap: () {
                        ref.read(bookingFlowProvider.notifier).selectBus(bus);
                        context.pushNamed(SeatSelectionScreen.routeName);
                      },
                    );
                  },
                );
              },
              loading: () => _buildShimmerLoading(),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchInfo() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: AppCard(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.fromLocation.split(',').first} → ${widget.toLocation.split(',').first}',
                    style: AppTypography.titleMedium,
                  ),
                  Text(
                    '${dateTimeFormat('MMM d, y', widget.date)} • 1 Traveler',
                    style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const Icon(Icons.tune_rounded, color: AppColors.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      child: Row(
        children: [
          _filterChip('All', Icons.bus_alert_rounded),
          const SizedBox(width: AppSpacing.sm),
          _filterChip('AC', Icons.ac_unit_rounded),
          const SizedBox(width: AppSpacing.sm),
          _filterChip('Non-AC', Icons.air_rounded),
          const SizedBox(width: AppSpacing.sm),
          _filterChip('Sleeper', Icons.bed_rounded),
        ],
      ),
    );
  }

  Widget _filterChip(String label, IconData icon) {
    final isSelected = selectedFilter == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) => setState(() => selectedFilter = val ? label : 'All'),
      avatar: Icon(icon, size: 16, color: isSelected ? AppColors.onPrimary : AppColors.primary),
      selectedColor: AppColors.primary,
      labelStyle: TextStyle(color: isSelected ? AppColors.onPrimary : AppColors.textPrimary),
    );
  }

  List _applyFilters(List buses) {
    var result = buses.where((bus) {
      bool typeMatch = selectedFilter == 'All' || bus.type.contains(selectedFilter);
      return typeMatch;
    }).toList();

    if (sortBy == 'Price') {
      result.sort((a, b) => a.price.compareTo(b.price));
    }
    return result;
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: 3,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: Container(height: 150, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(AppRadius.lg))),
        ),
      ),
    );
  }
}

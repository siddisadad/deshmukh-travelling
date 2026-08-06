import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/components/app_card.dart';
import '../../../../core/design_system/components/app_button.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../../flutter_flow/flutter_flow_util.dart';
import '../../../../components/app_header.dart';
import '../providers/hotel_providers.dart';
import 'hotel_details_screen.dart';

class HotelSearchResultsScreen extends ConsumerStatefulWidget {
  final String destination;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final int guests;

  const HotelSearchResultsScreen({
    super.key,
    required this.destination,
    this.checkIn,
    this.checkOut,
    this.guests = 2,
  });

  static String routeName = 'HotelSearchResults';
  static String routePath = '/hotelSearchResults';

  @override
  ConsumerState<HotelSearchResultsScreen> createState() => _HotelSearchResultsScreenState();
}

class _HotelSearchResultsScreenState extends ConsumerState<HotelSearchResultsScreen> {
  bool rating4Plus = false;
  String? priceSort; // 'asc', 'desc'
  bool freeWifi = false;
  bool pool = false;

  @override
  Widget build(BuildContext context) {
    final searchResult = ref.watch(hotelSearchProvider(widget.destination));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          AppHeader(
            title: widget.destination,
            bottom: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 12.0),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_rounded, size: 14, color: AppColors.textSecondary),
                      const SizedBox(width: 6),
                      Text(
                        '${dateTimeFormat('d MMM', widget.checkIn)} - ${dateTimeFormat('d MMM', widget.checkOut)} • ${widget.guests} Guests',
                        style: AppTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
                _buildFilters(),
              ],
            ),
          ),
          Expanded(
            child: searchResult.when(
              data: (result) => result.fold(
                (hotels) {
                  var filteredHotels = hotels;
                  if (rating4Plus) filteredHotels = filteredHotels.where((h) => h.rating >= 4.0).toList();
                  if (freeWifi) filteredHotels = filteredHotels.where((h) => h.amenities.contains('Free WiFi')).toList();
                  if (pool) filteredHotels = filteredHotels.where((h) => h.amenities.contains('Pool')).toList();

                  if (priceSort == 'asc') {
                    filteredHotels.sort((a, b) => a.startingPrice.compareTo(b.startingPrice));
                  } else if (priceSort == 'desc') {
                    filteredHotels.sort((a, b) => b.startingPrice.compareTo(a.startingPrice));
                  }

                  if (filteredHotels.isEmpty) {
                    return const Center(child: Text('No hotels found matching your filters.'));
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: filteredHotels.length,
                    separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final hotel = filteredHotels[index];
                      return AppCard(
                        onTap: () => context.pushNamed(
                          HotelDetailsScreen.routeName,
                          extra: {'hotel': hotel},
                        ),
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
                              child: Image.network(
                                hotel.images.first,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(AppSpacing.md),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(hotel.name, style: AppTypography.titleMedium),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.star_rounded, color: AppColors.success, size: 18),
                                          Text(hotel.rating.toString(), style: AppTypography.bodyMedium.copyWith(color: AppColors.success, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(hotel.location, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Starts from ₹${hotel.startingPrice.toStringAsFixed(0)}',
                                        style: AppTypography.titleSmall.copyWith(color: AppColors.primary),
                                      ),
                                      AppButton(
                                        onPressed: () => context.pushNamed(
                                          HotelDetailsScreen.routeName,
                                          extra: {'hotel': hotel},
                                        ),
                                        text: 'View Details',
                                        size: AppButtonSize.small,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                (exception) => Center(child: Text(exception.message)),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _filterChip(
            'Rating 4+',
            Icons.star_rounded,
            rating4Plus,
            () => setState(() => rating4Plus = !rating4Plus),
          ),
          const SizedBox(width: 8),
          _filterChip(
            'Price',
            Icons.currency_rupee_rounded,
            priceSort != null,
            () async {
              final res = await showModalBottomSheet<String>(
                context: context,
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(title: const Text('Price: Low to High'), onTap: () => Navigator.pop(context, 'asc')),
                    ListTile(title: const Text('Price: High to Low'), onTap: () => Navigator.pop(context, 'desc')),
                    ListTile(title: const Text('Clear Sort'), onTap: () => Navigator.pop(context, 'clear')),
                  ],
                ),
              );
              if (res != null) {
                setState(() => priceSort = res == 'clear' ? null : res);
              }
            },
          ),
          const SizedBox(width: 8),
          _filterChip(
            'Free WiFi',
            Icons.wifi_rounded,
            freeWifi,
            () => setState(() => freeWifi = !freeWifi),
          ),
          const SizedBox(width: 8),
          _filterChip(
            'Pool',
            Icons.pool_rounded,
            pool,
            () => setState(() => pool = !pool),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, IconData icon, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.alternate,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: isSelected ? Colors.white : AppColors.textSecondary),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

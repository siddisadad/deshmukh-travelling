import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/tokens.dart';
import '../../domain/entities/hotel_entity.dart';
import '../providers/hotel_search_providers.dart';

class HotelSearchScreen extends ConsumerWidget {
  final String city;

  const HotelSearchScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hotelsAsync = ref.watch(hotelSearchResultsProvider(city));

    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels in $city', style: AppTypography.titleMedium),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.background,
      body: hotelsAsync.when(
        data: (hotels) => ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.md),
          itemCount: hotels.length,
          itemBuilder: (context, index) => _hotelListItem(hotels[index]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _hotelListItem(HotelEntity hotel) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.md)),
            child: Image.network(hotel.images.first, height: 180, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(hotel.name, style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(hotel.rating.toString(), style: AppTypography.labelMedium),
                      ],
                    ),
                  ],
                ),
                Text(hotel.location, style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Starts from', style: AppTypography.labelMedium),
                    Text('₹${hotel.startingPrice.toStringAsFixed(0)}', style: AppTypography.titleMedium.copyWith(color: AppColors.secondary)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

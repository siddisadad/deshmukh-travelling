import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../backend/schema/hotel_record.dart';
import '../../../../backend/schema/room_record.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../../core/design_system/components/app_button.dart';
import '../../../../core/design_system/components/app_card.dart';
import '../providers/hotel_providers.dart';
import 'hotel_booking_confirmation_screen.dart';

class HotelDetailsScreen extends ConsumerWidget {
  final HotelRecord hotel;

  const HotelDetailsScreen({
    super.key,
    required this.hotel,
  });

  static String routeName = 'HotelDetails';
  static String routePath = '/hotelDetails';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomsResult = ref.watch(hotelRoomsProvider(hotel.id));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: IconButton(
              icon: CircleAvatar(
                backgroundColor: Colors.black26,
                child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 24.0),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: hotel.images.first,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(hotel.name, style: AppTypography.headlineMedium),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: AppColors.success, size: 20),
                            Text(
                              hotel.rating.toString(),
                              style: AppTypography.titleSmall.copyWith(
                                color: AppColors.success,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, color: AppColors.textSecondary, size: 16),
                        const SizedBox(width: 4),
                        Text(hotel.location, style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text('About', style: AppTypography.titleMedium),
                    const SizedBox(height: AppSpacing.xs),
                    Text(hotel.description, style: AppTypography.bodyMedium.copyWith(height: 1.5)),
                    const SizedBox(height: AppSpacing.lg),
                    Text('Amenities', style: AppTypography.titleMedium),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: hotel.amenities
                          .map((amenity) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                                ),
                                child: Text(amenity, style: AppTypography.labelSmall),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text('Available Rooms', style: AppTypography.titleMedium),
                    const SizedBox(height: AppSpacing.md),
                    roomsResult.when(
                      data: (result) => result.fold(
                        (rooms) => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: rooms.length,
                          separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
                          itemBuilder: (context, index) {
                            final room = rooms[index];
                            return _RoomCard(hotel: hotel, room: room);
                          },
                        ),
                        (exception) => Center(child: Text(exception.message)),
                      ),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, st) => Center(child: Text('Error: $e')),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _RoomCard extends StatelessWidget {
  final HotelRecord hotel;
  final RoomRecord room;

  const _RoomCard({required this.hotel, required this.room});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
            child: CachedNetworkImage(
              imageUrl: room.image,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(room.type, style: AppTypography.titleSmall),
                const SizedBox(height: 4),
                Text(room.amenities.join(' • '), style: AppTypography.labelSmall),
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${room.price.toStringAsFixed(0)} / night',
                      style: AppTypography.titleMedium.copyWith(color: AppColors.primary),
                    ),
                    AppButton(
                      text: 'Select',
                      size: AppButtonSize.small,
                      onPressed: () => context.pushNamed(
                        HotelBookingConfirmationScreen.routeName,
                        extra: {'hotel': hotel, 'room': room},
                      ),
                    ),
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

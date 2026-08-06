import 'package:flutter/material.dart';
import '../../../../core/design_system/tokens.dart';
import '../../domain/entities/bus_search_entity.dart';

class BusListItem extends StatelessWidget {
  final BusSearchEntity bus;

  const BusListItem({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(bus.name, style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold)),
              Text('₹${bus.price.toStringAsFixed(0)}', style: AppTypography.titleMedium.copyWith(color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(bus.type, style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(bus.departureTime, style: AppTypography.titleMedium),
                  Text(bus.departureCity, style: AppTypography.labelMedium),
                ],
              ),
              const Icon(Icons.arrow_forward, size: 20, color: AppColors.alternate),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(bus.arrivalTime, style: AppTypography.titleMedium),
                  Text(bus.arrivalCity, style: AppTypography.labelMedium),
                ],
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(bus.rating, style: AppTypography.labelMedium),
                ],
              ),
              Text('${bus.seatsAvailable} seats left',
                style: AppTypography.labelMedium.copyWith(
                  color: bus.seatsAvailable < 5 ? AppColors.error : AppColors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

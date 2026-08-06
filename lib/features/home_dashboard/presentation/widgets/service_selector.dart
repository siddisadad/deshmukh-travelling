import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/tokens.dart';
import '../providers/home_dashboard_providers.dart';

class ServiceSelector extends ConsumerWidget {
  const ServiceSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedService = ref.watch(selectedServiceProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _serviceItem(ref, 'Bus', Icons.directions_bus_rounded, selectedService),
          _serviceItem(ref, 'Hotel', Icons.hotel_rounded, selectedService),
          _serviceItem(ref, 'Taxi', Icons.local_taxi_rounded, selectedService),
          _serviceItem(ref, 'Hajj', Icons.mosque_rounded, selectedService),
          _serviceItem(ref, 'Holiday', Icons.beach_access_rounded, selectedService),
          _serviceItem(ref, 'Rentals', Icons.car_rental_rounded, selectedService),
        ].expand((widget) => [widget, const SizedBox(width: AppSpacing.md)]).toList()
          ..removeLast(),
      ),
    );
  }

  Widget _serviceItem(WidgetRef ref, String label, IconData icon, String selected) {
    final isSelected = selected == label;
    return InkWell(
      onTap: () => ref.read(selectedServiceProvider.notifier).state = label,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.secondary : Colors.white12,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white70,
              size: 28,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              color: isSelected ? Colors.white : Colors.white70,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../domain/entities/hajj_package.dart';

class TimelineItinerary extends StatelessWidget {
  final List<ItineraryDay> itinerary;

  const TimelineItinerary({
    super.key,
    required this.itinerary,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itinerary.length,
      itemBuilder: (context, index) {
        final day = itinerary[index];
        final isLast = index == itinerary.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Timeline vertical line and dot
              SizedBox(
                width: 40,
                child: Column(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFF06402B),
                        shape: BoxShape.circle,
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: const Color(0xFF06402B).withValues(alpha: 0.3),
                        ),
                      ),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Day ${day.day}: ${day.title}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF06402B),
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        day.location,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: const Color(0xFFD4AF37),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        day.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:deshmukh_travelling/features/packages/domain/entities/package_record.dart';

void main() {
  group('PackageRecord Tests', () {
    test('fromMap should parse nested itinerary correctly', () {
      final map = {
        'title': 'Test Package',
        'price': 50000.0,
        'itinerary': [
          {
            'day': 1,
            'title': 'Arrival',
            'description': 'Welcome to the city',
            'activities': ['Meet & Greet', 'Check-in'],
          }
        ],
      };

      final record = PackageRecord.fromMap(map, 'pkg123');

      expect(record.title, 'Test Package');
      expect(record.itinerary.length, 1);
      expect(record.itinerary[0].day, 1);
      expect(record.itinerary[0].activities.length, 2);
    });

    test('toMap should serialize correctly', () {
      final record = PackageRecord(
        id: 'pkg123',
        title: 'Test Package',
        description: 'Desc',
        destinations: ['City A'],
        durationDays: 3,
        durationNights: 2,
        price: 50000.0,
        images: [],
        inclusions: [],
        exclusions: [],
        itinerary: [
          ItineraryDay(day: 1, title: 'Day 1', description: 'Desc 1', activities: ['Act 1'])
        ],
        rating: 4.8,
        reviewsCount: 10,
      );

      final map = record.toMap();

      expect(map['title'], 'Test Package');
      expect(map['itinerary'][0]['day'], 1);
    });
  });
}

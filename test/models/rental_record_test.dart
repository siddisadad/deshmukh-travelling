import 'package:flutter_test/flutter_test.dart';
import 'package:deshmukh_travelling/backend/schema/rental_record.dart';

void main() {
  group('RentalRecord Tests', () {
    test('fromMap should parse correctly', () {
      final map = {
        'vehicleName': 'Test Car',
        'type': 'SUV',
        'pricePerDay': 2000.0,
        'transmission': 'Manual',
        'fuelType': 'Petrol',
        'capacity': 5,
        'image': 'test_url',
        'rating': 4.5,
      };

      final record = RentalRecord.fromMap(map, 'id123');

      expect(record.id, 'id123');
      expect(record.vehicleName, 'Test Car');
      expect(record.pricePerDay, 2000.0);
      expect(record.capacity, 5);
    });

    test('toMap should output correctly', () {
      final record = RentalRecord(
        id: 'id123',
        vehicleName: 'Test Car',
        type: 'SUV',
        pricePerDay: 2000.0,
        transmission: 'Manual',
        fuelType: 'Petrol',
        capacity: 5,
        image: 'test_url',
        rating: 4.5,
      );

      final map = record.toMap();

      expect(map['vehicleName'], 'Test Car');
      expect(map['pricePerDay'], 2000.0);
      expect(map['capacity'], 5);
    });
  });
}

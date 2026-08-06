import 'package:flutter_test/flutter_test.dart';
import 'package:deshmukh_travelling/backend/repositories/bus_repository.dart';
import 'package:deshmukh_travelling/backend/schema/bus_record.dart';
import 'package:deshmukh_travelling/core/data/datasources/bus_datasource.dart';

class MockBusDataSource implements BusDataSource {
  @override
  Future<List<BusRecord>> getBuses(String from, String to) async {
    return [
      BusRecord(
        id: '1',
        name: 'Mock Bus',
        type: 'AC',
        price: 1000,
        departureCity: from,
        arrivalCity: to,
        depTime: '10:00 AM',
        arrTime: '2:00 PM',
        rating: '4.5',
        seatsAvailable: '20',
      )
    ];
  }

  @override
  Stream<Map<String, double>> getBusLocationStream(String busId) {
    return Stream.value({'lat': 0.0, 'lng': 0.0});
  }
}

void main() {
  group('FirestoreBusRepository Tests', () {
    test('searchBuses returns a list of BusRecord', () async {
      final repository = FirestoreBusRepository(dataSource: MockBusDataSource());
      final buses = await repository.searchBuses(from: 'Mumbai', to: 'Pune');

      expect(buses, isA<List<BusRecord>>());
      expect(buses.length, 1);
      expect(buses.first.departureCity, 'Mumbai');
      expect(buses.first.arrivalCity, 'Pune');
    });
  });
}

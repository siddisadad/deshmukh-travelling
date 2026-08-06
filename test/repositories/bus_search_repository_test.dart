import 'package:flutter_test/flutter_test.dart';
import 'package:deshmukh_travelling/features/bus_search/data/repositories/bus_search_repository_impl.dart';
import 'package:deshmukh_travelling/core/data/datasources/bus_datasource.dart';
import 'package:deshmukh_travelling/backend/schema/bus_record.dart';

class MockBusDataSource implements BusDataSource {
  @override
  Future<List<BusRecord>> getBuses(String from, String to) async {
    return [
      BusRecord(
        id: 'bus1',
        name: 'Mock Bus',
        type: 'AC',
        price: 500.0,
        departureCity: from,
        arrivalCity: to,
        depTime: '08:00 AM',
        arrTime: '12:00 PM',
        rating: '4.5',
        seatsAvailable: '10',
      ),
    ];
  }

  @override
  Stream<Map<String, double>> getBusLocationStream(String busId) {
    return Stream.value({'lat': 1.0, 'lng': 2.0});
  }
}

void main() {
  group('BusSearchRepositoryImpl Tests', () {
    test('searchBuses returns list of BusSearchEntity', () async {
      final repository = BusSearchRepositoryImpl(MockBusDataSource());
      final result = await repository.searchBuses(from: 'Mumbai', to: 'Pune');

      expect(result, isNotEmpty);
      expect(result.first.name, 'Mock Bus');
      expect(result.first.departureCity, 'Mumbai');
    });
  });
}

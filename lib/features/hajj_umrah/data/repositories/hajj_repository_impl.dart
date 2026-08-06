import '../../domain/entities/hajj_package.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/itinerary.dart';
import '../../domain/entities/document.dart';
import '../../domain/repositories/hajj_repository.dart';

class HajjRepositoryImpl implements HajjRepository {
  @override
  Future<List<HajjPackage>> getPackages({PackageType? type}) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final packages = _mockPackages;
    if (type != null) {
      return packages.where((p) => p.type == type).toList();
    }
    return packages;
  }

  @override
  Future<HajjPackage?> getPackageDetails(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _mockPackages.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Itinerary>> getItinerary(String packageId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Itinerary(day: 1, title: 'Arrival', description: 'Arrive at Jeddah Airport and transfer to Makkah.', icon: 'flight_land'),
    ];
  }

  @override
  Future<String> createBooking(Booking booking) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'BK-${DateTime.now().millisecondsSinceEpoch}';
  }

  @override
  Future<List<Booking>> getUserBookings(String userId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [];
  }

  @override
  Future<List<HajjDocument>> getDocuments(String bookingId) async {
    return [];
  }

  @override
  Future<void> uploadDocument(String bookingId, HajjDocument document) async {}

  final List<HajjPackage> _mockPackages = [
    HajjPackage(
      id: 'h1',
      title: 'Economy Hajj Package 2026',
      description: 'Affordable Hajj journey with standard accommodation and services.',
      type: PackageType.hajj,
      price: 450000.0,
      startDate: DateTime(2026, 5, 15),
      endDate: DateTime(2026, 6, 15),
      duration: '32 Days',
      images: ['https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?w=800&q=80'],
      amenities: ['Visa Processing', 'Economy Flights', 'Standard Hotel', 'Buffet Meals'],
      makkahHotel: 'Rawdat Al Bait',
      madinahHotel: 'Saja Al Madinah',
      itinerary: [], // We can use the getItinerary method
    ),
  ];
}

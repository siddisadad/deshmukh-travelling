import '../entities/hajj_package.dart';
import '../entities/booking.dart';
import '../entities/itinerary.dart';
import '../entities/document.dart';

abstract class HajjRepository {
  Future<List<HajjPackage>> getPackages({PackageType? type});
  Future<HajjPackage?> getPackageDetails(String id);
  Future<List<Itinerary>> getItinerary(String packageId);
  Future<String> createBooking(Booking booking);
  Future<List<Booking>> getUserBookings(String userId);
  Future<List<HajjDocument>> getDocuments(String bookingId);
  Future<void> uploadDocument(String bookingId, HajjDocument document);
}

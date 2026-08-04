import 'package:share_plus/share_plus.dart';
import '../../backend/schema/booking_record.dart';

class ShareService {
  static Future<void> shareBookingDetails(BookingRecord booking) async {
    final text = 'My Bus Ticket with Deshmukh Travelling!\n\n'
        'Route: \${booking.departureCity} to \${booking.arrivalCity}\n'
        'Bus: \${booking.busName}\n'
        'Seats: \${booking.seatNumbers.join(", ")}\n'
        'Status: Confirmed\n\n'
        'Book your journey with comfort!';

    await Share.share(text, subject: 'Bus Ticket Confirmation');
  }
}

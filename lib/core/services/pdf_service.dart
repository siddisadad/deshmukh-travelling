import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../backend/schema/booking_record.dart';

class PdfService {
  static Future<Uint8List> generateTicket(BookingRecord booking) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Deshmukh Travelling - E-Ticket', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text('Booking ID: \${booking.id ?? "N/A"}'),
              pw.Text('Bus: \${booking.busName}'),
              pw.Text('Route: \${booking.departureCity} to \${booking.arrivalCity}'),
              pw.Text('Date: \${booking.timestamp.toString()}'),
              pw.Text('Seats: \${booking.seatNumbers.join(", ")}'),
              pw.SizedBox(height: 20),
              pw.Text('Passengers:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              for (var p in booking.passengers)
                pw.Text('- \${p.name} (\${p.age}, \${p.gender})'),
              pw.SizedBox(height: 40),
              pw.Text('Total Amount Paid: ₹\${booking.totalAmount.toInt()}'),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static Future<void> printTicket(BookingRecord booking) async {
    final bytes = await generateTicket(booking);
    await Printing.layoutPdf(onLayout: (format) async => bytes);
  }
}

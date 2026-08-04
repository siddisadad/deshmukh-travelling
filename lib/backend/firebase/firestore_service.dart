import 'package:cloud_firestore/cloud_firestore.dart';
import '../schema/bus_record.dart';
import '../schema/booking_record.dart';
import '../schema/passenger_record.dart';
import '../schema/users_record.dart';
import '../schema/wallet_record.dart';

class FirestoreService {
  FirebaseFirestore get _db => FirebaseFirestore.instance;

  // Set this to true to use real Firestore, false for mock data
  static bool useRealFirestore = true;

  Future<WalletRecord?> getWallet(String userId) async {
    if (!useRealFirestore) {
      return WalletRecord(
        userId: userId,
        balance: 1250.0,
        transactions: [
          WalletTransaction(
            id: 't1',
            amount: 500.0,
            type: 'credit',
            description: 'Added to wallet',
            timestamp: DateTime.now().subtract(Duration(days: 2)),
          ),
          WalletTransaction(
            id: 't2',
            amount: 250.0,
            type: 'debit',
            description: 'Bus booking payment',
            timestamp: DateTime.now().subtract(Duration(days: 5)),
          ),
        ],
      );
    }

    try {
      final doc = await _db.collection('wallets').doc(userId).get();
      if (doc.exists) {
        final data = doc.data()!;
        return WalletRecord(
          userId: userId,
          balance: (data['balance'] ?? 0.0).toDouble(),
          transactions: (data['transactions'] as List? ?? []).map((t) {
            return WalletTransaction(
              id: t['id'] ?? '',
              amount: (t['amount'] ?? 0.0).toDouble(),
              type: t['type'] ?? 'credit',
              description: t['description'] ?? '',
              timestamp: (t['timestamp'] as Timestamp).toDate(),
            );
          }).toList(),
        );
      }
    } catch (e) {
      print('Error getting wallet: $e');
    }
    return null;
  }

  Future<void> createUser(UsersRecord user) async {
    if (!useRealFirestore) {
      print('MOCK: Creating user: ${user.toMap()}');
      return;
    }

    try {
      await _db.collection('users').doc(user.uid).set(user.toMap());
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  Future<UsersRecord?> getUser(String uid) async {
    if (!useRealFirestore) {
      return UsersRecord(
        uid: uid,
        email: 'test@example.com',
        displayName: 'Test User',
        phoneNumber: '+919876543210',
        dob: DateTime(1995, 1, 1),
      );
    }

    try {
      final doc = await _db.collection('users').doc(uid).get();
      if (doc.exists) {
        return UsersRecord.fromFirestore(doc);
      }
    } catch (e) {
      print('Error getting user: $e');
    }
    return null;
  }

  Future<List<PassengerRecord>> fetchSavedPassengers(String userId) async {
    if (!useRealFirestore) {
      await Future.delayed(const Duration(seconds: 1));
      return [
        PassengerRecord.fromMap({
          'userId': userId,
          'name': 'Aditya Deshmukh',
          'age': 28,
          'gender': 'Male',
          'relation': 'Self'
        }, 'p1'),
        PassengerRecord.fromMap({
          'userId': userId,
          'name': 'Sunita Deshmukh',
          'age': 26,
          'gender': 'Female',
          'relation': 'Spouse'
        }, 'p2'),
      ];
    }

    try {
      final snapshot = await _db.collection('saved_passengers')
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs.map((doc) => PassengerRecord.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching saved passengers: $e');
      return [];
    }
  }

  Future<void> savePassenger(PassengerRecord passenger) async {
    if (!useRealFirestore) {
      print('MOCK: Saving passenger: \${passenger.toMap()}');
      return;
    }

    try {
      await _db.collection('saved_passengers').add(passenger.toMap());
    } catch (e) {
      print('Error saving passenger: $e');
    }
  }

  Future<List<BusRecord>> fetchBuses(String from, String to) async {
    if (!useRealFirestore) {
      // Return Mock Data
      await Future.delayed(Duration(seconds: 1)); // Simulate network lag
      return [
        BusRecord.fromMap({
          'name': 'Deshmukh Premium AC',
          'type': 'Volvo Multi-Axle AC',
          'price': 850.0,
          'departureCity': from,
          'arrivalCity': to,
          'depTime': '08:30 AM',
          'arrTime': '12:45 PM',
          'rating': '4.8',
          'seatsAvailable': '12'
        }, 'bus1'),
        BusRecord.fromMap({
          'name': 'Shivneri Express',
          'type': 'Scania Luxury AC',
          'price': 720.0,
          'departureCity': from,
          'arrivalCity': to,
          'depTime': '10:15 AM',
          'arrTime': '02:00 PM',
          'rating': '4.5',
          'seatsAvailable': '4'
        }, 'bus2'),
        BusRecord.fromMap({
          'name': 'Nightlink Sleeper',
          'type': 'Electric Sleeper AC',
          'price': 1200.0,
          'departureCity': from,
          'arrivalCity': to,
          'depTime': '10:00 PM',
          'arrTime': '06:30 AM',
          'rating': '4.9',
          'seatsAvailable': '8'
        }, 'bus3'),
      ];
    }

    try {
      final snapshot = await _db.collection('buses')
          .where('departureCity', isEqualTo: from)
          .where('arrivalCity', isEqualTo: to)
          .get();

      return snapshot.docs.map((doc) => BusRecord.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching buses: $e');
      return [];
    }
  }

  Future<List<HotelRecord>> fetchHotels(String city) async {
    if (!useRealFirestore) {
      await Future.delayed(const Duration(seconds: 1));
      return [
        HotelRecord.fromMap({
          'name': 'Grand Hyatt Mumbai',
          'location': 'Santacruz East, Mumbai',
          'description': 'Luxury hotel with world-class amenities.',
          'rating': 4.8,
          'reviewsCount': 1240,
          'images': ['https://images.unsplash.com/photo-1566073771259-6a8506099945'],
          'amenities': ['WiFi', 'Pool', 'Gym', 'Spa'],
          'startingPrice': 8500.0,
          'city': 'Mumbai',
        }, 'h1'),
        HotelRecord.fromMap({
          'name': 'Taj Mahal Palace',
          'location': 'Colaba, Mumbai',
          'description': 'Iconic luxury hotel overlooking the Gateway of India.',
          'rating': 4.9,
          'reviewsCount': 2150,
          'images': ['https://images.unsplash.com/photo-1542314831-068cd1dbfeeb'],
          'amenities': ['WiFi', 'Pool', 'Fine Dining', 'Sea View'],
          'startingPrice': 15000.0,
          'city': 'Mumbai',
        }, 'h2'),
      ];
    }

    try {
      final snapshot = await _db.collection('hotels')
          .where('city', isEqualTo: city)
          .get();

      return snapshot.docs.map((doc) => HotelRecord.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching hotels: $e');
      return [];
    }
  }

  Future<List<RoomRecord>> fetchRooms(String hotelId) async {
    if (!useRealFirestore) {
      await Future.delayed(const Duration(milliseconds: 500));
      return [
        RoomRecord.fromMap({
          'hotelId': hotelId,
          'type': 'Deluxe Room',
          'price': 8500.0,
          'capacity': 2,
          'amenities': ['King Bed', 'City View', 'WiFi'],
          'isAvailable': true,
          'image': 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304',
        }, 'r1'),
        RoomRecord.fromMap({
          'hotelId': hotelId,
          'type': 'Executive Suite',
          'price': 12000.0,
          'capacity': 2,
          'amenities': ['King Bed', 'Living Area', 'WiFi', 'Breakfast'],
          'isAvailable': true,
          'image': 'https://images.unsplash.com/photo-1590490360182-c33d57733427',
        }, 'r2'),
      ];
    }

    try {
      final snapshot = await _db.collection('rooms')
          .where('hotelId', isEqualTo: hotelId)
          .where('isAvailable', isEqualTo: true)
          .get();

      return snapshot.docs.map((doc) => RoomRecord.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching rooms: $e');
      return [];
    }
  }

  Future<List<TaxiRecord>> fetchTaxis() async {
    if (!useRealFirestore) {
      await Future.delayed(const Duration(milliseconds: 400));
      return [
        TaxiRecord.fromMap({
          'vehicleName': 'Toyota Etios',
          'type': 'Sedan',
          'capacity': 4,
          'baseFare': 500.0,
          'pricePerKm': 12.0,
          'image': 'https://dimg.dreamflow.cloud/v1/image/white%20toyota%20etios%20taxi',
          'isAvailable': true,
        }, 't1'),
        TaxiRecord.fromMap({
          'vehicleName': 'Maruti Ertiga',
          'type': 'SUV',
          'capacity': 6,
          'baseFare': 800.0,
          'pricePerKm': 15.0,
          'image': 'https://dimg.dreamflow.cloud/v1/image/silver%20maruti%20ertiga%20taxi',
          'isAvailable': true,
        }, 't2'),
      ];
    }

    try {
      final snapshot = await _db.collection('taxis').get();
      return snapshot.docs.map((doc) => TaxiRecord.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching taxis: $e');
      return [];
    }
  }

  Future<List<PackageRecord>> fetchPackages() async {
    if (!useRealFirestore) {
      await Future.delayed(const Duration(milliseconds: 600));
      return [
        PackageRecord.fromMap({
          'title': 'Golden Triangle Tour',
          'destinations': ['Delhi', 'Agra', 'Jaipur'],
          'durationDays': 6,
          'durationNights': 5,
          'price': 25000.0,
          'rating': 4.7,
          'images': ['https://images.unsplash.com/photo-1548013146-72479768bbfd'],
          'inclusions': ['Hotels', 'Sightseeing', 'Breakfast'],
          'description': 'A comprehensive tour of India\'s history and culture.',
        }, 'p1'),
        PackageRecord.fromMap({
          'title': 'Kerala Backwaters Special',
          'destinations': ['Kochi', 'Munnar', 'Alleppey'],
          'durationDays': 5,
          'durationNights': 4,
          'price': 18500.0,
          'rating': 4.9,
          'images': ['https://images.unsplash.com/photo-1602216056096-3b40cc0c9944'],
          'inclusions': ['Houseboat stay', 'Private Cab', 'All Meals'],
          'description': 'Experience the serene beauty of God\'s own country.',
        }, 'p2'),
      ];
    }

    try {
      final snapshot = await _db.collection('packages').get();
      return snapshot.docs.map((doc) => PackageRecord.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching packages: $e');
      return [];
    }
  }

  Future<List<BookingRecord>> fetchUserBookings(String userId) async {
    if (!useRealFirestore) {
      await Future.delayed(Duration(seconds: 1));
      return [
        BookingRecord(
          id: 'b1',
          userId: userId,
          busId: 'bus1',
          busName: 'Deshmukh Premium AC',
          busType: 'AC • Sleeper',
          departureCity: 'Mumbai',
          arrivalCity: 'Pune',
          depTime: '08:30 PM',
          arrTime: '06:00 AM',
          seatNumbers: ['S-12', 'S-13'],
          passengers: [],
          totalAmount: 1250.0,
          status: 'upcoming',
          timestamp: DateTime.now().add(Duration(days: 2)),
        ),
      ];
    }

    try {
      final snapshot = await _db.collection('bookings')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) => BookingRecord.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching bookings: $e');
      return [];
    }
  }

  Future<String?> createBooking(BookingRecord booking) async {
    if (!useRealFirestore) {
      print('MOCK: Saving booking to Firestore: ${booking.toMap()}');
      return 'mock_booking_id';
    }

    try {
      final docRef = await _db.collection('bookings').add(booking.toMap());
      return docRef.id;
    } catch (e) {
      print('Error creating booking: $e');
      return null;
    }
  }

  Future<String?> createHotelBooking(HotelBookingRecord booking) async {
    if (!useRealFirestore) {
      print('MOCK: Saving hotel booking to Firestore: ${booking.toMap()}');
      return 'mock_hotel_booking_id';
    }

    try {
      final docRef = await _db.collection('hotel_bookings').add(booking.toMap());
      return docRef.id;
    } catch (e) {
      print('Error creating hotel booking: $e');
      return null;
    }
  }

  Future<void> cancelBooking(String bookingId) async {
    if (!useRealFirestore) {
      print('MOCK: Cancelling booking: $bookingId');
      return;
    }

    try {
      await _db.collection('bookings').doc(bookingId).update({'status': 'cancelled'});
    } catch (e) {
      print('Error cancelling booking: $e');
    }
  }

  Future<void> cancelBookingWithRefund(BookingRecord booking) async {
    await cancelBooking(booking.id ?? '');
    await updateWalletBalance(
      booking.userId,
      booking.totalAmount,
      'credit',
      'Refund for cancelled trip ${booking.busName}',
    );
  }

  Future<void> updateWalletBalance(String userId, double amount, String type, String description) async {
    if (!useRealFirestore) {
      print('MOCK: Updating wallet for user $userId: $type ₹$amount ($description)');
      return;
    }

    try {
      final docRef = _db.collection('wallets').doc(userId);
      await _db.runTransaction((transaction) async {
        final doc = await transaction.get(docRef);
        double currentBalance = 0.0;
        List transactions = [];

        if (doc.exists) {
          currentBalance = (doc.data()?['balance'] ?? 0.0).toDouble();
          transactions = doc.data()?['transactions'] ?? [];
        }

        final newBalance = type == 'credit' ? currentBalance + amount : currentBalance - amount;

        final newTransaction = {
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'amount': amount,
          'type': type,
          'description': description,
          'timestamp': Timestamp.now(),
        };

        transaction.set(docRef, {
          'userId': userId,
          'balance': newBalance,
          'transactions': [newTransaction, ...transactions],
        });
      });
    } catch (e) {
      print('Error updating wallet: $e');
    }
  }

  Future<void> addLoyaltyPoints(String userId, int points) async {
    if (!useRealFirestore) {
      print('MOCK: Adding $points loyalty points to user $userId');
      return;
    }

    try {
      await _db.collection('users').doc(userId).update({
        'loyaltyPoints': FieldValue.increment(points),
      });
    } catch (e) {
      print('Error adding loyalty points: $e');
    }
  }

  Future<RewardRecord?> getRewards(String userId) async {
    if (!useRealFirestore) {
      return RewardRecord(userId: userId, points: 250);
    }
    try {
      final doc = await _db.collection('users').doc(userId).get();
      if (doc.exists) {
        return RewardRecord(
            userId: userId, points: doc.data()?['loyaltyPoints'] ?? 0);
      }
    } catch (e) {
      print('Error getting rewards: $e');
    }
    return RewardRecord(userId: userId, points: 0);
  }

  Future<void> redeemPoints(String userId, int pointsToRedeem) async {
    final cashValue = pointsToRedeem * 0.1; // 10 points = ₹1
    if (!useRealFirestore) {
      print('MOCK: Redeeming $pointsToRedeem points for ₹$cashValue');
      return;
    }

    try {
      // 1. Deduct points
      await _db.collection('users').doc(userId).update({
        'loyaltyPoints': FieldValue.increment(-pointsToRedeem),
      });

      // 2. Add to wallet
      await updateWalletBalance(
          userId, cashValue, 'credit', 'Redeemed travel points');
    } catch (e) {
      print('Error redeeming points: $e');
    }
  }

  Stream<Map<String, double>> getBusLocationStream(String busId) {
    if (!useRealFirestore) {
      return Stream.periodic(const Duration(seconds: 3), (i) {
        return {
          'lat': 19.1000 + (i * 0.001),
          'lng': 72.8800 + (i * 0.001),
        };
      });
    }

    return _db.collection('bus_locations').doc(busId).snapshots().map((doc) {
      if (doc.exists) {
        final data = doc.data()!;
        return {
          'lat': (data['lat'] ?? 0.0).toDouble(),
          'lng': (data['lng'] ?? 0.0).toDouble(),
        };
      }
      return {'lat': 0.0, 'lng': 0.0};
    });
  }
}

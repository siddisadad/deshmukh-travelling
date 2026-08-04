import '/flutter_flow/flutter_flow_util.dart';
import '../../backend/schema/rental_record.dart';
import 'package:flutter/material.dart';

class CarRentalModel extends FlutterFlowModel {
  List<RentalRecord> rentals = [];
  bool isLoading = true;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  Future<void> fetchRentals() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 1));
    rentals = [
      RentalRecord(id: 'r1', vehicleName: 'Mahindra Thar', type: 'SUV', pricePerDay: 3500, transmission: 'Manual', fuelType: 'Diesel', capacity: 4, image: 'https://images.unsplash.com/photo-1620984857410-b9866898d97e', rating: 4.7),
      RentalRecord(id: 'r2', vehicleName: 'Honda City', type: 'Sedan', pricePerDay: 2500, transmission: 'Automatic', fuelType: 'Petrol', capacity: 5, image: 'https://images.unsplash.com/photo-1590362891991-f776e747a588', rating: 4.5),
      RentalRecord(id: 'r3', vehicleName: 'Hyundai i20', type: 'Hatchback', pricePerDay: 1800, transmission: 'Manual', fuelType: 'Petrol', capacity: 5, image: 'https://images.unsplash.com/photo-1541899481282-d53bffe3c35d', rating: 4.3),
    ];
    isLoading = false;
  }
}

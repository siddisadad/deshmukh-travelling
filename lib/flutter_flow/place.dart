import 'dart:convert';
import 'lat_lng.dart';

class FFPlace {
  const FFPlace({
    this.latLng = const LatLng(0.0, 0.0),
    this.name = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.country = '',
    this.zipCode = '',
  });

  final LatLng latLng;
  final String name;
  final String address;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  String serialize() => jsonEncode({
        'latLng': latLng.serialize(),
        'name': name,
        'address': address,
        'city': city,
        'state': state,
        'country': country,
        'zipCode': zipCode,
      });

  static FFPlace deserialize(String val) {
    final map = jsonDecode(val);
    return FFPlace(
      latLng: latLngFromString(map['latLng'] as String),
      name: map['name'] as String,
      address: map['address'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      country: map['country'] as String,
      zipCode: map['zipCode'] as String,
    );
  }

  static LatLng latLngFromString(String val) {
    final parts = val.split(',');
    return LatLng(double.parse(parts[0]), double.parse(parts[1]));
  }

  @override
  String toString() => '''FFPlace(
        latLng: $latLng,
        name: $name,
        address: $address,
        city: $city,
        state: $state,
        country: $country,
        zipCode: $zipCode,
      )''';

  @override
  int get hashCode => latLng.hashCode;

  @override
  bool operator ==(other) =>
      other is FFPlace &&
      latLng == other.latLng &&
      name == other.name &&
      address == other.address &&
      city == other.city &&
      state == other.state &&
      country == other.country &&
      zipCode == other.zipCode;
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DonationEvent {
  String id;
  String? name;
  String? description;
  String? host;
  String? locationName;
  String? city;
  LatLng? latlng;
  DateTime? startDateTime;
  DateTime? endDateTime;

  DonationEvent(
      {required this.id,
      this.name,
      this.description,
      this.host,
      this.locationName,
      this.latlng,
      this.startDateTime,
      this.endDateTime,
      this.city});

  DonationEvent.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        description = map["description"],
        host = map["host"],
        locationName = map["locationName"],
        city = map["city"],
        latlng = LatLng(map["latlng"].latitude, map["latlng"].longitude),
        startDateTime = map["startDateTime"].toDate(),
        endDateTime = map["endDateTime"].toDate();
}

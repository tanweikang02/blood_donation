// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DonationEvent {
  String? name;
  String? description;
  String? host;
  String? locationName;
  LatLng? latlng;
  DateTime? startDateTime;
  DateTime? endDateTime;

  DonationEvent({
    this.name,
    this.description,
    this.host,
    this.locationName,
    this.latlng,
    this.startDateTime,
    this.endDateTime,
  });

  
}

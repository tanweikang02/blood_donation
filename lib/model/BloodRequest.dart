class BloodRequest {
  String? text;
  String? location;
  DateTime? date;
  List<dynamic>? bloodTypeNeeded;
  String? recipientName;

  BloodRequest({this.text, this.location, this.date, this.bloodTypeNeeded, this.recipientName});

  BloodRequest.fromMap(Map<String, dynamic> map)
      : text = map["text"],
        location = map["location"],
        date = map["date"].toDate(),
        bloodTypeNeeded = map["bloodTypeNeeded"],
        recipientName = map["recipientName"];
}

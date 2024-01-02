class DonationRecord {
  String id;
  String? donorName;
  String? location;
  int? bloodVolume_Milliliter;
  String? note;
  bool? isVoluntary;
  double? paymentAmount;
  DateTime? donationDateTime;
  DateTime? entryDateTime;
  
  DonationRecord({
    required this.id,
    this.donorName,
    this.location,
    this.bloodVolume_Milliliter,
    this.note = "",
    this.isVoluntary = true,
    this.paymentAmount = 0,
    this.donationDateTime,
    this.entryDateTime,
  });

  DonationRecord.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        donorName = map["donorName"],
        location = map["location"],
        bloodVolume_Milliliter = map["bloodVolume_Milliliter"],
        note = map["note"],
        isVoluntary = map["isVoluntary"],
        paymentAmount = double.parse(map["paymentAmount"]),
        donationDateTime = map["donationDateTime"].toDate(),
        entryDateTime = map["entryDateTime"].toDate();
}

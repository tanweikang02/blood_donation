class DonationRecord {
  String? donorName;
  String? location;
  int? bloodVolume_Milliliter;
  String? note;
  bool? isVoluntary;
  double? paymentAmount;
  DateTime? donationDateTime;
  DateTime? entryDateTime;
  
  DonationRecord({
    this.donorName,
    this.location,
    this.bloodVolume_Milliliter,
    this.note = "",
    this.isVoluntary = true,
    this.paymentAmount = 0,
    this.donationDateTime,
    this.entryDateTime,
  });
}

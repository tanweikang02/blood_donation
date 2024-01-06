class Address {
  String? address1;
  String? address2;
  String? postcode;
  String? city;
  String? state;

  Address({this.address1, this.address2, this.postcode, this.city, this.state});

  String getFullAddress() {
    String fullAddress = "";
    if (address1 != null) {
      fullAddress += address1!;
    }
    if (address2 != null) {
      fullAddress += ", " + address2!;
    }
    if (postcode != null) {
      fullAddress += ", " + postcode!;
    }
    if (city != null) {
      fullAddress += ", " + city!;
    }
    if (state != null) {
      fullAddress += ", " + state!;
    }
    return fullAddress;
  }
}

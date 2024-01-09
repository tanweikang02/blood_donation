class User {
  String? name;
  String? email;
  int? age;
  String? contactNumber;
  String? profileImageUrl;
  int? points;

  User({this.name, this.email, this.age, this.contactNumber, this.profileImageUrl, this.points});

  User.fromMap(Map<String, dynamic> map)
      : name = map["name"],
        email = map["email"],
        age = map["age"],
        contactNumber = map["contactNumber"],
        profileImageUrl = map["profileImageUrl"],
        points = map["points"];
}

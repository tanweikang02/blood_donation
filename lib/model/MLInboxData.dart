class MLInboxData {
  int? id;
  String? role;
  String? parts;

  MLInboxData({this.id, this.parts, this.role});

  MLInboxData.fromJson(Map json)
      : id = json['id'] as int?,
        role = json['role'] as String?,
        parts = json['parts'] as String?;

  Map toJson() {
    return {
      'id': id,
      'role': role,
      'parts': parts,
    };
  }
}

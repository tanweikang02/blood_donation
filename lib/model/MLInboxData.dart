class MLInboxData {
  int? id;
  String? role;
  String? parts;
  int? type;

  MLInboxData({this.id, this.parts, this.role, this.type});

  MLInboxData.fromJson(Map json)
      : id = json['id'] as int?,
        role = json['role'] as String?,
        parts = json['parts'] as String?,
        type = json['type'] as int?;

  Map toJson() {
    return {'id': id, 'role': role, 'parts': parts, 'type': type};
  }
}

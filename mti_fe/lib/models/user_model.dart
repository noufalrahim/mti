import 'dart:convert';

class UserModel {
  final int id;
  final String phone;
  UserModel({required this.id, required this.phone});

  UserModel copyWith({int? id, String? phone}) {
    return UserModel(id: id ?? this.id, phone: phone ?? this.phone);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'phone': phone};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(id: map['id'] as int, phone: map['phone'] as String);
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(id: $id, phone: $phone)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.phone == phone;
  }

  @override
  int get hashCode => id.hashCode ^ phone.hashCode;
}

import 'dart:convert';

class ChildModel {

  final int id;
  final String name;
  final DateTime dateOfBirth;
  final int weekOfPrematurity;
  final bool premature;
  ChildModel({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.weekOfPrematurity,
    required this.premature,
  });



  ChildModel copyWith({
    int? id,
    String? name,
    DateTime? dateOfBirth,
    int? weekOfPrematurity,
    bool? premature,
  }) {
    return ChildModel(
      id: id ?? this.id,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      weekOfPrematurity: weekOfPrematurity ?? this.weekOfPrematurity,
      premature: premature ?? this.premature,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'dateOfBirth': dateOfBirth.millisecondsSinceEpoch,
      'weekOfPrematurity': weekOfPrematurity,
      'premature': premature,
    };
  }

factory ChildModel.fromMap(Map<String, dynamic> map) {
  return ChildModel(
    id: int.tryParse(map['id'].toString()) ?? 0, 
    name: map['name'] as String,
    dateOfBirth: map['dateOfBirth'] is int 
        ? DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth'] as int)
        : DateTime.parse(map['dateOfBirth'].toString()), // Handle string date
    weekOfPrematurity: int.tryParse(map['weekOfPrematurity'].toString()) ?? 0,
    premature: map['premature'] as bool? ?? false, // Ensure it's a bool
  );
}

  String toJson() => json.encode(toMap());

factory ChildModel.fromJson(Map<String, dynamic> json) => ChildModel.fromMap(json);

  @override
  String toString() {
    return 'ChildModel(id: $id, name: $name, dateOfBirth: $dateOfBirth, weekOfPrematurity: $weekOfPrematurity, premature: $premature)';
  }

  @override
  bool operator ==(covariant ChildModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.dateOfBirth == dateOfBirth &&
      other.weekOfPrematurity == weekOfPrematurity &&
      other.premature == premature;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      dateOfBirth.hashCode ^
      weekOfPrematurity.hashCode ^
      premature.hashCode;
  }
}

import 'dart:convert';

import 'package:milestone_tracker_of_infants/models/category_model.dart';

class QuestionModel {
  final int id;
  final String questionEnglish;
  final String questionMalayalam;
  final CategoryModel category;
  final int severity;
  QuestionModel({
    required this.id,
    required this.questionEnglish,
    required this.questionMalayalam,
    required this.category,
    required this.severity,
  });

  QuestionModel copyWith({
    int? id,
    String? questionEnglish,
    String? questionMalayalam,
    CategoryModel? category,
    int? severity,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      questionEnglish: questionEnglish ?? this.questionEnglish,
      questionMalayalam: questionMalayalam ?? this.questionMalayalam,
      category: category ?? this.category,
      severity: severity ?? this.severity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'questionEnglish': questionEnglish,
      'questionMalayalam': questionMalayalam,
      'category': category.toMap(),
      'severity': severity,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'] as int,
      questionEnglish: map['questionEnglish'] as String,
      questionMalayalam: map['questionMalayalam'] as String,
      category: CategoryModel.fromMap(map['category'] as Map<String,dynamic>),
      severity: map['severity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) => QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuestionModel(id: $id, questionEnglish: $questionEnglish, questionMalayalam: $questionMalayalam, category: $category, severity: $severity)';
  }

  @override
  bool operator ==(covariant QuestionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.questionEnglish == questionEnglish &&
      other.questionMalayalam == questionMalayalam &&
      other.category == category &&
      other.severity == severity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      questionEnglish.hashCode ^
      questionMalayalam.hashCode ^
      category.hashCode ^
      severity.hashCode;
  }
}

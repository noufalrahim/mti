// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:milestone_tracker_of_infants/models/child_model.dart';
import 'package:milestone_tracker_of_infants/models/question_model.dart';

class ChildResponseModel {
  final int id;
  final QuestionModel question;
  final bool isQuestionAnswered;
  final bool isAnsweredYes;
  final ChildModel child;
  ChildResponseModel({
    required this.id,
    required this.question,
    required this.isQuestionAnswered,
    required this.isAnsweredYes,
    required this.child,
  });

  ChildResponseModel copyWith({
    int? id,
    QuestionModel? question,
    bool? isQuestionAnswered,
    bool? isAnsweredYes,
    ChildModel? child,
  }) {
    return ChildResponseModel(
      id: id ?? this.id,
      question: question ?? this.question,
      isQuestionAnswered: isQuestionAnswered ?? this.isQuestionAnswered,
      isAnsweredYes: isAnsweredYes ?? this.isAnsweredYes,
      child: child ?? this.child,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question.toMap(),
      'isQuestionAnswered': isQuestionAnswered,
      'isAnsweredYes': isAnsweredYes,
      'child': child.toMap(),
    };
  }

  factory ChildResponseModel.fromMap(Map<String, dynamic> map) {
    return ChildResponseModel(
      id: map['id'] as int,
      question: QuestionModel.fromMap(map['question'] as Map<String,dynamic>),
      isQuestionAnswered: map['isQuestionAnswered'] as bool,
      isAnsweredYes: map['isAnsweredYes'] as bool,
      child: ChildModel.fromMap(map['child'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChildResponseModel.fromJson(String source) => ChildResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChildResponseModel(id: $id, question: $question, isQuestionAnswered: $isQuestionAnswered, isAnsweredYes: $isAnsweredYes, child: $child)';
  }

  @override
  bool operator ==(covariant ChildResponseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.question == question &&
      other.isQuestionAnswered == isQuestionAnswered &&
      other.isAnsweredYes == isAnsweredYes &&
      other.child == child;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      question.hashCode ^
      isQuestionAnswered.hashCode ^
      isAnsweredYes.hashCode ^
      child.hashCode;
  }
}

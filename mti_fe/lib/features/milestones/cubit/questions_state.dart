part of 'questions_cubit.dart';

sealed class QuestionsState {}

final class QuestionsInitital extends QuestionsState {}

final class QuestionsLoading extends QuestionsState {}

final class QuestionError extends QuestionsState {
  final String error;
  QuestionError(this.error);
}

// final class GetQuestionsSuccess extends QuestionsState {
//   final List<QuestionModel> questions;
//   GetQuestionsSuccess(this.questions);
// }

final class GetQuestionByCategorySuccess extends QuestionsState {
  final List<QuestionModel> questions;
  GetQuestionByCategorySuccess(this.questions);
}
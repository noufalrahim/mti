import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milestone_tracker_of_infants/features/milestones/repository/question_repository.dart';
import 'package:milestone_tracker_of_infants/models/question_model.dart';

part 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  QuestionsCubit() : super(QuestionsInitital());

  final questionsRepository = QuestionRepository();

  // Future<void> getAllQuestions() async {
  //   try {
  //     emit(QuestionsLoading());
  //     final questionsList = await questionsRepository.getQuestions();
  //     emit(GetQuestionsSuccess(questionsList));
  //   } catch (e) {
  //     emit(QuestionError(e.toString()));
  //   }
  // }


  Future<void> getQuestionsByCategory(int categoryId) async {
    try {
      emit(QuestionsLoading());
      final questionsList = await questionsRepository.getQuestionsByCategory(categoryId);
      emit(GetQuestionByCategorySuccess(questionsList));
    }
    catch (e) {
      emit(QuestionError(e.toString()));
    }
  }
}

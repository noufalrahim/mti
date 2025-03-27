import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:milestone_tracker_of_infants/features/home/repository/child_response_repository.dart';
import 'package:milestone_tracker_of_infants/models/child_response_model.dart';

part 'child_response_state.dart';

class ChildResponseCubit extends Cubit<ChildResponseState> {
  ChildResponseCubit() : super(const ChildResponseInitial());

  final ChildResponseRepository childResponseRepository =
      ChildResponseRepository();

  void setChildId(int newChildId) {
    emit(
      GetChildProgress(childId: newChildId, childProgress: state.childProgress),
    );
    getChildProgress(newChildId);
  }

  Future<void> getChildProgress(int childId) async {
    try {
      emit(const ChildResponseLoading());
      final childProgress = await childResponseRepository.getProgressOfChild(
        childId,
      );
      emit(GetChildProgress(childId: childId, childProgress: childProgress));
    } catch (e) {
      emit(ChildResponseError(error: e.toString()));
    }
  }

  Future<void> addChildResponse(
    final int questionId,
    final bool answer,
    final int childId,
  ) async {
    try {
      emit(ChildResponseLoading());
      final childResponse = await childResponseRepository.addChildResponse(
        questionId,
        answer,
        childId,
      );
      print(childResponse);
      if (childResponse == null) {
        throw Exception("Child response is null");
      }
      // emit(AddChildResponseSuccess(childResponse));
    } catch (e) {
      emit(ChildResponseError(error: e.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:milestone_tracker_of_infants/features/home/repository/child_repository.dart';
import 'package:milestone_tracker_of_infants/models/child_model.dart';

part 'child_state.dart';

class ChildCubit extends Cubit<ChildState> {
  final ChildRepository _childRepository;

  ChildCubit(this._childRepository) : super(ChildInitial());

  Future<void> loadChildren(int userId) async {
    try {
      emit(ChildLoading());
      final childrenList = await _childRepository.getChildrenByUser(userId);
      final ChildModel defaultChild = await _childRepository.getDefaultChild(
        userId,
      );
      emit(GetChildrenSuccess(childrenList, defaultChild));
    } catch (e) {
      emit(ChildError("Failed to load children"));
    }
  }

  Future<void> getDefaultChild(int userId) async {
    try {
      emit(ChildLoading());
      final defaultChild = await _childRepository.getDefaultChild(userId);
      emit(GetDefaultChildSuccess(defaultChild));
    } catch (e) {
      emit(ChildError(e.toString()));
    }
  }

  Future<void> editDefaultChild(int userId, int childId) async {
    try {
      emit(ChildLoading());
      await _childRepository.editDefaultChild(userId, childId);
      final updatedChild = await _childRepository.getDefaultChild(userId);
      emit(GetDefaultChildSuccess(updatedChild));
    } catch (e) {
      emit(ChildError(e.toString()));
    }
  }

  Future<void> createNewChild({
    required name,
    required dob,
    required isPremature,
    required weeksOfPremature,
    required userId
  }) async {
    try {
      emit(ChildLoading());
      final addChild = await _childRepository.addChild(name: name, dob: dob, isPremature: isPremature, weeksOfPremature: weeksOfPremature, userId: userId);
      emit(AddNewChildSuccess(addChild));
    }
    catch (e){
      emit(ChildError(e.toString()));
    }
  }
}


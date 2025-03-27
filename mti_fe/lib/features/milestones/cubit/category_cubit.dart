import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milestone_tracker_of_infants/features/milestones/repository/category_repository.dart';
import 'package:milestone_tracker_of_infants/models/category_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  final categoryRepository = CategoryRepository();

  Future<void> getAllCategories() async {
    try {
      emit(CategoryLoading());
      final categoriesList = await categoryRepository.getCategories();
      emit(GetCategorySuccess(categoriesList));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}

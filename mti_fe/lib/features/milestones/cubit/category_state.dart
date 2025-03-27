part of 'category_cubit.dart';

sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryError extends CategoryState {
  final String error;
  CategoryError(this.error);
}

final class GetCategorySuccess extends CategoryState {
  final List<CategoryModel> categories;
  GetCategorySuccess(this.categories);
}

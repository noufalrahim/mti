part of 'child_response_cubit.dart';

sealed class ChildResponseState extends Equatable {
  final int? childId;
  final dynamic childProgress; // Replace with actual type if available

  const ChildResponseState({this.childId, this.childProgress});

  @override
  List<Object?> get props => [childId, childProgress];

  ChildResponseState copyWith({int? childId, dynamic childProgress});
}

final class ChildResponseInitial extends ChildResponseState {
  const ChildResponseInitial() : super();

  @override
  ChildResponseInitial copyWith({int? childId, dynamic childProgress}) {
    return const ChildResponseInitial();
  }
}

final class ChildResponseLoading extends ChildResponseState {
  const ChildResponseLoading();

  @override
  ChildResponseLoading copyWith({int? childId, dynamic childProgress}) {
    return const ChildResponseLoading();
  }
}

final class ChildResponseError extends ChildResponseState {
  final String error;

  const ChildResponseError({required this.error}) : super();

  @override
  List<Object?> get props => [error];

  @override
  ChildResponseError copyWith({
    int? childId,
    dynamic childProgress,
    String? error,
  }) {
    return ChildResponseError(error: error ?? this.error);
  }
}

final class GetChildProgress extends ChildResponseState {
  final int childId;
  final dynamic childProgress; // Replace with actual type if available

  const GetChildProgress({required this.childId, required this.childProgress})
    : super(childId: childId, childProgress: childProgress);

  @override
  GetChildProgress copyWith({int? childId, dynamic childProgress}) {
    return GetChildProgress(
      childId: childId ?? this.childId,
      childProgress: childProgress ?? this.childProgress,
    );
  }
}

// final class AddChildResponseSuccess extends ChildResponseState {
//   final ChildResponseModel childResponseModel;

//   const AddChildResponseSuccess(this.childResponseModel) : super();

//   @override
//   List<Object?> get props => [childResponseModel];

//   @override
//   AddChildResponseSuccess copyWith({
//     int? childId,
//     dynamic childProgress,
//     ChildResponseModel? childResponseModel,
//   }) {
//     return AddChildResponseSuccess(
//       childResponseModel ?? this.childResponseModel,
//     );
//   }
// }

final class AddChildResponseSuccess extends ChildResponseState {
  final ChildResponseModel taskModel;
  AddChildResponseSuccess(this.taskModel);
  
  @override
  ChildResponseState copyWith({int? childId, childProgress}) {
    throw UnimplementedError();
  }
}
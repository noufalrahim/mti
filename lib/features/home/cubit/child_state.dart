part of 'child_cubit.dart';

sealed class ChildState {}

final class ChildInitial extends ChildState{}

final class ChildLoading extends ChildState {}

final class ChildError extends ChildState {
  final String error;
  ChildError(this.error);
}

final class GetChildrenSuccess extends ChildState {
  final List<ChildModel> children;
  final ChildModel defaultChild;
  GetChildrenSuccess(this.children, this.defaultChild);
}

final class GetDefaultChildSuccess extends ChildState {
  final ChildModel defaultChild;
  GetDefaultChildSuccess(this.defaultChild);

}

final class AddNewChildSuccess extends ChildState {
  final ChildModel childModel;
  AddNewChildSuccess(this.childModel);
}


part of 'iscompupdate_bloc.dart';

abstract class IscompupdateState extends Equatable {
  const IscompupdateState();

  @override
  List<Object> get props => [];
}

class IscompupdateLoading extends IscompupdateState {}

class IscompupdateLoaded extends IscompupdateState {
  final List<TodoModel> todoModel;

  IscompupdateLoaded({
    required this.todoModel,
  });
  @override
  List<Object> get props => [todoModel];
}

class IscompupdateLoadError extends IscompupdateState {}

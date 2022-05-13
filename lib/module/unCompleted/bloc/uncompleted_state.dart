part of 'uncompleted_bloc.dart';

abstract class UncompletedState extends Equatable {
  @override
  List<Object> get props => [];
}

class UncompletedLoading extends UncompletedState {}

class UncompletedLoaded extends UncompletedState {
  final Future<List<TodoModel>> listTodo;
  UncompletedLoaded({
    required this.listTodo,
  });
}

class UncompletedError extends UncompletedState {}

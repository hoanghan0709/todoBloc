part of 'uncompleted_bloc.dart';

abstract class UncompletedEvent extends Equatable {
  const UncompletedEvent();

  @override
  List<Object> get props => [];
}

class unCompletedLoaded extends UncompletedEvent {
  final List<TodoModel> todos;
  unCompletedLoaded({
    required this.todos,
  });

  @override
  List<Object> get props => [todos];
}

class unCompletedLoading extends UncompletedEvent {}

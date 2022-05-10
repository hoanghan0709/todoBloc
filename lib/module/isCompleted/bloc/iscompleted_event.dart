part of 'iscompleted_bloc.dart';

abstract class IscompletedEvent extends Equatable {
  const IscompletedEvent();
  @override
  List<Object> get props => [];
}

class LoadedIsCompleted extends IscompletedEvent {
  final List<TodoModel> todos;
  LoadedIsCompleted({
    required this.todos,
  });
}

class LoadingCompleted extends IscompletedEvent {}

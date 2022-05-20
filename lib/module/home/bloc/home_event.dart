part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {}

class loadTodoEvents extends HomeEvent {
  // final Future<List<TodoModel>> todoModel;
  // loadTodoEvents({
  //   required this.todoModel,
  // });
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class addTodoEvents extends HomeEvent {
  final TodoModel todoModel;

  addTodoEvents(this.todoModel);
  @override
  List<Object> get props => [todoModel];
}

class ChangetodoEvents extends HomeEvent {
  final int index;

  ChangetodoEvents(this.index);
  @override
  List<Object> get props => [index];
}

class RemoveTodoEvents extends HomeEvent {
  final TodoModel Todo;
  RemoveTodoEvents({
    required this.Todo,
  });

  @override
  List<Object> get props => [Todo];
}

class PageChangeEvents extends HomeEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];

  final int index;
  PageChangeEvents({
    required this.index,
  });
}

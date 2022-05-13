part of 'iscompleted_bloc.dart';

abstract class IscompletedState extends Equatable {
  const IscompletedState();
  
  @override
  List<Object> get props => [];
}


class IscompletedLoading extends IscompletedState {

}
class IscompletedLoaded extends IscompletedState {
  final Future <List<TodoModel>> todos;
  IscompletedLoaded({
    required this.todos,
  });
  
  @override
  List<Object> get props => [todos];
}


class IscompletedError extends IscompletedState {}

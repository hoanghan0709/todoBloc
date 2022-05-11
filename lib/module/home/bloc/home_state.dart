part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<TodoModel> listTodo;
  
  HomeLoaded({required this.listTodo});
  @override
  List<Object> get props => [listTodo];
}
class HomeLoadError extends HomeState {}


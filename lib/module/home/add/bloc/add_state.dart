part of 'add_bloc.dart';

abstract class AddState extends Equatable {
  const AddState();

  @override
  List<Object> get props => [];
}

class AddInitial extends AddState {}

class AddLoading extends AddState {}

class AddLoaded extends AddState {
  final TodoModel todos;

  AddLoaded({required this.todos});
}
 

class AddError extends AddState {}

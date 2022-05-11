part of 'add_bloc.dart';

abstract class AddEvent extends Equatable {
  const AddEvent();

  @override
  List<Object> get props => [];
}

class addEvents extends AddEvent {
  final TodoModel todo;

  addEvents({required this.todo});

  @override
  // TODO: implement props
  List<Object> get props => [this.todo];
}

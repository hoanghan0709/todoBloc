part of 'iscompupdate_bloc.dart';

abstract class IscompupdateEvent extends Equatable {
  const IscompupdateEvent();

  @override
  List<Object> get props => [];
}

class loadUpdateEvents extends IscompupdateEvent {
  @override
  List<Object> get props => [];
}

class UpdateEvents extends IscompupdateEvent {
  final TodoModel todoModel;
  UpdateEvents({
    required this.todoModel,
  });
  @override
  List<Object> get props => [todoModel];
}

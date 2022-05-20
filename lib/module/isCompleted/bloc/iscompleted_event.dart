part of 'iscompleted_bloc.dart';

abstract class IscompletedEvent extends Equatable {
  const IscompletedEvent();
  @override
  List<Object> get props => [];
}

class LoadingIsCompleted extends IscompletedEvent { 
  @override
  List<Object> get props => [];
}

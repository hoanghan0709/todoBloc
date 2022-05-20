import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:todos_bloc/core/model/todos.dart';
import 'package:todos_bloc/core/repository/TodoRepository.dart';
//import 'package:todos_bloc/module/isCompleted/bloc/iscompleted_bloc.dart';

import '../../../service/service.dart';

part 'uncompleted_event.dart';
part 'uncompleted_state.dart';

class UncompletedBloc extends Bloc<UncompletedEvent, UncompletedState> {
  TodoRepository repository;

  UncompletedBloc(
    this.repository,
  ) : super(UncompletedLoading()) {
    on<unCompletedLoading>(_onUnCompletedLoading);
  }

  void _onUnCompletedLoading(
      unCompletedLoading events, Emitter<UncompletedState> emitter) {
    final client =
        ApiRequest(Dio(BaseOptions(contentType: "application/json")));
    emit(UncompletedLoaded(listTodo: client.getTodosUnComplete(false)));
  }
}

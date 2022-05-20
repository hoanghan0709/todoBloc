import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:todos_bloc/core/model/todos.dart';
import 'package:todos_bloc/core/repository/TodoRepository.dart';

import '../../../service/service.dart';

part 'iscompleted_event.dart';
part 'iscompleted_state.dart';

class IscompletedBloc extends Bloc<IscompletedEvent, IscompletedState> {
  final TodoRepository todoRepository;
  IscompletedBloc(
    this.todoRepository,
  ) : super(IscompletedLoading()) {
    on<LoadingIsCompleted>((event, emit) async {
      emit(IscompletedLoading());

      await Future.delayed(
        const Duration(seconds: 1),
        () {
          final client =
              ApiRequest(Dio(BaseOptions(contentType: "application/json")));
          emit(IscompletedLoaded(todos: client.getTodosCompleted(true)));
          // emit(IscompletedLoaded(todos: todoRepository.isCompleted));
        },
      );
    });
  }
}

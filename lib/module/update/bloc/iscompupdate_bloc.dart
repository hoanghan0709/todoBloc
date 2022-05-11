import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todos_bloc/core/model/todos.dart';
import 'package:todos_bloc/core/repository/TodoRepository.dart';

part 'iscompupdate_event.dart';
part 'iscompupdate_state.dart';

class IscompupdateBloc extends Bloc<IscompupdateEvent, IscompupdateState> {
  TodoRepository todoRepository;
  IscompupdateBloc(
    this.todoRepository,
  ) : super(IscompupdateLoading()) {
    on<UpdateEvents>(update);
    on<loadingUpdateEvents>(loadupdate);
  }

  void loadupdate(
      loadingUpdateEvents events, Emitter<IscompupdateState> emitter) {
    emitter(IscompupdateLoaded(todoModel: todoRepository.isCompleted));
  }

  void update(UpdateEvents events, Emitter<IscompupdateState> emitter) async {
    await Future.delayed(const Duration(seconds: 1), () {
      todoRepository.updateTodo(todoModel: events.todoModel);
      emitter(IscompupdateLoaded(todoModel: todoRepository.isCompleted));
    });
  }
}

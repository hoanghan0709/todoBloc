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
    on<loadUpdateEvents>(loadupdate);
  }

  void loadupdate(loadUpdateEvents events, Emitter<IscompupdateState> emitter) {
    emitter(IscompupdateLoaded(todoModel: todoRepository.isCompleted));
  }

  void update(UpdateEvents events, Emitter<IscompupdateState> emitter) {
    todoRepository.updateTodo(todoModel: events.todoModel);
    emitter(IscompupdateLoaded(todoModel: todoRepository.isCompleted));
  }
}

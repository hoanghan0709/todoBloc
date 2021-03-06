import 'package:todos_bloc/core/model/todos.dart';

class TodoRepository {
  List<TodoModel> listModel = [
    // TodoModel(id: 1, title: 'abcde1',   completed: true),
    // TodoModel(id: 2, title: 'abcde2',  ),
    // TodoModel(id: 3, title: 'abcde3', )
  ];
  List<TodoModel> get AllTodos {
    return listModel;
  }

  void addTodo({required TodoModel todoModel}) {
    listModel.add(todoModel);
  }

  void removeTodo({required int index}) {
    listModel.removeAt(index);
  }

  TodoModel updateTodo({required TodoModel todoModel}) {
    for (int i = 0; i < listModel.length; i++) {
      if (listModel[i] == todoModel) {
        print('found todo');
        listModel[i].title = todoModel.title;
        //  listModel[i].date = todoModel.date;

        print(listModel[i].toString());
      }
    }
    return todoModel;
  }

  List<TodoModel> get isCompleted {
    return AllTodos.where((element) => element.completed == true).toList();
  }

  List<TodoModel> get unCompleted {
    return AllTodos.where((element) => element.completed == false).toList();
  }

  void changeTodo({required int index}) {
    listModel[index].completed = !listModel[index].completed;
  }
}

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:todos_bloc/core/model/todos.dart';
import 'package:retrofit/retrofit.dart';

part 'service.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/")
abstract class ApiRequest {
  factory ApiRequest(Dio dio) = _ApiRequest;

//ok
  @GET("/todos")
  Stream<List<TodoModel>> getTodos();
//ok
  @GET("/todos?completed={result}")
  Future<List<TodoModel>> getTodosCompleted(@Path("result") bool result);
//ok
  @GET("/todos?completed={result}")
  Future<List<TodoModel>> getTodosUnComplete(@Path('result') bool result);

  @DELETE("/todos/{id}")
  Future<TodoModel> deleteTodo(@Path("id") int id);

  @POST("/todos")
  Future<TodoModel> addTodo(TodoModel todo);

  // @MultiPart()
  // @PUT("/todos/{}")
  // Future<TodoModel> updateTodo(TodoModel todo);
}

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:todos_bloc/core/model/todos.dart';
import 'package:retrofit/retrofit.dart';

part 'service.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/")
abstract class ApiRequest {
  factory ApiRequest(Dio dio) = _ApiRequest;
  @GET("/todos")
  Future<List<TodoModel>> getTodos();
  @GET("/todos?completed=true")
  Future<List<TodoModel>> getTodosCompleted();
  @GET("/todos?completed=false")
  Future<List<TodoModel>> getTodosComplete();
  @DELETE("/todos/{id?}")
  Future<List<TodoModel>> deleteTodo();
}

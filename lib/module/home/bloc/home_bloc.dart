import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
//import 'package:meta/meta.dart';
import 'package:todos_bloc/core/model/todos.dart';
import 'package:todos_bloc/service/service.dart';

import '../../../core/repository/TodoRepository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TodoRepository repository;
  final pageController = PageController();
  HomeBloc(this.repository) : super(HomeLoading()) {
    on<loadTodoEvents>(onLoading);
    on<addTodoEvents>(onAddTodo);
    on<RemoveTodoEvents>(onRemoveTodo);
    on<ChangetodoEvents>(onChangetodo);
    on<PageChangeEvents>(onPageChange);
  }

  void onLoading(loadTodoEvents event, Emitter<HomeState> emitter) async {
    final client =
        ApiRequest(Dio(BaseOptions(contentType: "application/json")));

    //emitter(HomeLoaded(listTodo: client.getTodos()));
    await Future.delayed(const Duration(seconds: 1), () {
      emitter(HomeLoaded(listTodo: client.getTodos()));
    });
  }

  void onChangetodo(ChangetodoEvents event, Emitter<HomeState> emitter) {
    repository.changeTodo(index: event.index);
    //emitter(HomeLoaded(listTodo: repository.AllTodos));
  }

  void onRemoveTodo(RemoveTodoEvents events, Emitter<HomeState> emit) {
    final client =
        ApiRequest(Dio(BaseOptions(contentType: "application/json")));
    client.deleteTodo(events.Todo.id);
    emit(HomeLoaded(listTodo: client.getTodos()));
    print('deleted!');
    //repository.removeTodo(index: events.index);
    // emit(HomeLoaded(listTodo: repository.AllTodos));
  }

  void onAddTodo(addTodoEvents events, Emitter<HomeState> emitter) {
    repository.addTodo(todoModel: events.todoModel);
    // emitter(HomeLoaded(listTodo: repository.AllTodos));
  }

  void onPageChange(PageChangeEvents events, Emitter<HomeState> emit) {
    if (events.index == 0) {
      // emit(HomeLoaded(listTodo: repository.AllTodos));
    }
    if (events.index == 1) {
      //  emit(HomeLoaded(listTodo: repository.isCompleted));
    }
    if (events.index == 2) {
      // emit(HomeLoaded(listTodo: repository.unCompleted));
    }
  }
}

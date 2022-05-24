import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todos_bloc/core/model/todos.dart';
import 'package:todos_bloc/module/db/preferences.dart';

import '../../../../core/repository/TodoRepository.dart';
import '../../../../service/service.dart';
import 'package:rxdart/rxdart.dart';
part 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  final TodoRepository repository;
  final pref = PreferencesService();
  late BehaviorSubject<List<TodoModel>> _fech;
  Stream<List<TodoModel>> get streamTodo => _fech.stream;

  init() {
    _fech = BehaviorSubject();
  }

  dispore() {
    _fech.close();
  }

  AddBloc(this.repository) : super(AddLoading()) {
    on<addEvents>((event, emit) {
      //  repository.addTodo(todoModel: event.todo);
      final client =
          ApiRequest(Dio(BaseOptions(contentType: "application/json")));
      emit(AddLoaded(todos: client.addTodo(event.todo)));
    });
  }
}

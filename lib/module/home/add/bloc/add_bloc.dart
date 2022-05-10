import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todos_bloc/core/model/todos.dart';

import '../../../../core/repository/TodoRepository.dart';

part 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  final TodoRepository repository;
  AddBloc(this.repository) : super(AddLoading()) {
    on<addEvents>((event, emit) {
      repository.addTodo(todoModel: event.todo);
     
    });
  }
}

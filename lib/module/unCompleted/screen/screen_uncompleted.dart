//import 'dart:js';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/core/model/todos.dart';
//import 'package:todos_bloc/core/repository/TodoRepository.dart';

import 'package:todos_bloc/module/unCompleted/bloc/uncompleted_bloc.dart';
import 'package:todos_bloc/service/service.dart';

class UnCompletedScreen extends StatelessWidget {
  UnCompletedScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UncompletedBloc>(context).add(unCompletedLoading());

    return Scaffold(body: BlocBuilder<UncompletedBloc, UncompletedState>(
      builder: (context, state) {
        if (state is UncompletedLoading) {
          return CircularProgressIndicator();
        }
        if (state is UncompletedLoaded) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Center(
                  child: Text(
                    'PENDING',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.black),
                  ),
                ),
              ),
              Expanded(child: buildBody(context))
            ],
          );
        } else {
          return Text('process data');
        }
      },
    ));
  }

  FutureBuilder<List<TodoModel>> buildBody(BuildContext context) {
    final client =
        ApiRequest(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder(
      future: client.getTodosComplete(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('error snapshot uncompleted');
        } else if (snapshot.hasData) {
          final List<TodoModel>? todos = snapshot.data;
          return buildItem(context, todos!);
        } else {
          return Text('loaded!');
        }
      },
    );
  }

  ListView buildItem(BuildContext context, List<TodoModel> todos) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
            child: ListTile(
                //     leading: Text(state.listTodo[index].id),
                trailing: todos[index].completed
                    ? Icon(Icons.check_box_outline_blank_sharp)
                    : Icon(Icons.check_box_outline_blank_sharp),
                subtitle: Text(todos[index].title,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.black)),
                title: Text(todos[index].id.toString(),
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Colors.black,
                        ))));
      },
      itemCount: todos.length,
    );
  }
}

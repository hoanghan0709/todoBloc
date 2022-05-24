import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:todos_bloc/core/model/todos.dart';
import 'package:todos_bloc/core/repository/TodoRepository.dart';
import 'package:todos_bloc/module/home/bloc/home_bloc.dart';
import 'package:todos_bloc/service/service.dart';

import '../../../core/model/todos.dart';
import '../../db/preferences.dart';

class AllTodoScreen extends StatefulWidget {
  const AllTodoScreen({Key? key}) : super(key: key);

  @override
  State<AllTodoScreen> createState() => _AllTodoScreenState();
}

class _AllTodoScreenState extends State<AllTodoScreen> {
  final client = ApiRequest(Dio(BaseOptions(contentType: "application/json")));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<HomeBloc>(context).add(loadTodoEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLoaded) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('loaded home')));
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.pink));
            }
            if (state is HomeLoaded) {
              return Column(
                children: [
                  const SizedBox(
                    height: 40.0,
                  ),
                  Center(
                    child: Text(
                      'LIST TASK  ',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  Expanded(child: Container(child: _buildBody(context)))
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   itemBuilder: (ctxx, index) {
                  //     return Card(
                  //         color: Colors.grey,
                  //         shadowColor: Colors.green,
                  //         child: ListTile(
                  //             onLongPress: () {
                  //               ctxx.read<HomeBloc>().add(RemoveTodoEvents(
                  //                   index:
                  //                       index)); //tại homebloc.nhận vào even remove ->return state Homeloaded
                  //             },
                  //             onTap: () {
                  //               // ctxx
                  //               //     .read<HomeBloc>()
                  //               //     .add(ChangetodoEvents(index));
                  //               BlocProvider.of<HomeBloc>(this.context)
                  //                   .add(ChangetodoEvents(index));
                  //             },
                  //             title: txt(state.listTodo[index].title),
                  //             leading: txt(state.listTodo[index].id),
                  //             subtitle: txt(state.listTodo[index].date),
                  //             trailing: (state.listTodo[index].isCompleted
                  //                 ? Icon(Icons.check_box)
                  //                 : Icon(Icons.check_box_outline_blank))));
                  //   },
                  //   itemCount: state.listTodo.length,
                  // ),
                ],
              );
            } else {
              return Container(
                child: const Text("error"),
              );
            }
          },
        ),
      ),
    );
  }

  ListView _buildTodo(BuildContext context, List<TodoModel> todos) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: todos.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: ListTile(
            leading: Text('${todos.length}'),
            onLongPress: () {
              BlocProvider.of<HomeBloc>(context)
                  .add(RemoveTodoEvents(Todo: todos[index]));
            },
            trailing: (todos[index].completed
                ? const Icon(Icons.check_box)
                : const Icon(Icons.check_box_outline_blank)),
            subtitle: Text(
              todos[index].title,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.black),
            ),
            title: Text(todos[index].id.toString()),
          ),
        );
      },
    );
  }

  StreamBuilder<List<TodoModel>> _buildBody(BuildContext context) {
    return StreamBuilder<List<TodoModel>>(
      stream: client.getTodos(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }
        if (snapshot.hasData) {
          final List<TodoModel>? todos = snapshot.data;
          return _buildTodo(context, todos!);
        }
        return Container(
          child: const Text('Loadinggg'),
        );
      },
    );
  }

  Text txt(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
    );
  }
}

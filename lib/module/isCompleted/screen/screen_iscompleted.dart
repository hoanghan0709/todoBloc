import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/core/model/todos.dart';
import 'package:todos_bloc/core/repository/TodoRepository.dart';
import 'package:todos_bloc/module/isCompleted/bloc/iscompleted_bloc.dart';

import '../../../service/service.dart';
import '../../update/bloc/iscompupdate_bloc.dart';
import '../../update/screen/updateIscom_screen.dart';

class isCompletedScreen extends StatelessWidget {
  isCompletedScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    BlocProvider.of<IscompletedBloc>(ctx).add(LoadingIsCompleted());
    return Scaffold(
      body: BlocListener<IscompletedBloc, IscompletedState>(
        listener: (context, state) {
          // TODO: implement listenerr
          if (state is IscompletedLoaded) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('loaded!')));
          }
        },
        child: BlocBuilder<IscompletedBloc, IscompletedState>(
          builder: (context, state) {
            if (state is IscompletedLoading) {
              //return const CircularProgressIndicator.;
              return Center(child: CircularProgressIndicator());
            }
            if (state is IscompletedLoaded) {
              return Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Text(
                        'IS COMPLETED',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  _buildBody2(ctx)
                ],
              );
            } else {
              return const Text('error iscompleted');
            }
          },
        ),
      ),
    );
  }

  FutureBuilder<List<TodoModel>> _buildBody2(BuildContext ctx) {
    final client =
        ApiRequest(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder(
        future: client.getTodosCompleted(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error screen iscompleted');
          } else if (snapshot.hasData) {
            final List<TodoModel>? todos = snapshot.data;
            return Expanded(child: _builTodo(context, todos!));
          } else {
            return Text('Loading');
            // return const Center(
            //     child: CircularProgressIndicator(
            //   color: Colors.red,
            // ));
          }
        });
  }

  ListView _builTodo(BuildContext ctx, List<TodoModel> todos) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) =>
                          IscompupdateBloc(ctx.read<TodoRepository>()),
                      child: isCompleUpdateScreen(todoModel: todos[index]),
                    ),
                  )).whenComplete(() {
                ctx.read<IscompletedBloc>().add(LoadingIsCompleted());
              });
            },
            // leading: Text(state.todos[index].id),
            subtitle: Text(
              todos[index].title,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.black),
            ),
            trailing: (todos[index].completed
                ? const Icon(Icons.check_box)
                : const Icon(Icons.check_box_outline_blank)),
            title: Text(todos[index].id.toString()),
          ),
        );
      },
    );
  }
}

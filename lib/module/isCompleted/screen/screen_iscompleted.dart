import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/core/repository/TodoRepository.dart';

import 'package:todos_bloc/module/isCompleted/bloc/iscompleted_bloc.dart';

import '../../home/update/bloc/iscompupdate_bloc.dart';
import '../../home/update/screen/updateIscom_screen.dart';

class isCompletedScreen extends StatelessWidget {
  isCompletedScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    BlocProvider.of<IscompletedBloc>(ctx)
        .add(LoadedIsCompleted(todos: ctx.read<TodoRepository>().isCompleted));
    return Scaffold(
      body: BlocListener<IscompletedBloc, IscompletedState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is IscompletedLoaded) {
            //const Center(child: CircularProgressIndicator());
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Addedsdsdsd!')));
          }
        },
        child: BlocBuilder<IscompletedBloc, IscompletedState>(
          builder: (context, state) {
            if (state is IscompletedLoading) {
              return CircularProgressIndicator.adaptive();
            }
            if (state is IscompletedLoaded) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text('abc'),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => IscompupdateBloc(
                                        ctx.read<TodoRepository>()),
                                    child: isCompleUpdateScreen(
                                        todoModel: state.todos[index]),
                                  ),
                                )).whenComplete(() {
                              ctx
                                  .read<IscompletedBloc>()
                                  .add(LoadedIsCompleted(todos: state.todos));
                            });
                          },
                          leading: Text(state.todos[index].id),
                          title: Text(state.todos[index].date),
                          trailing: Text(
                              state.todos[index].isCompleted ? "ok" : "not ok"),
                          subtitle: Text(state.todos[index].title),
                        ),
                      );
                    },
                  ),
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
}

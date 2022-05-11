import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/core/repository/TodoRepository.dart';
import 'package:todos_bloc/module/home/update/screen/updateIscom_screen.dart';

import 'package:todos_bloc/module/isCompleted/bloc/iscompleted_bloc.dart';

import '../../home/update/bloc/iscompupdate_bloc.dart';

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
              return const CircularProgressIndicator.adaptive();
              //return Text('---abc---');
            }
            if (state is IscompletedLoaded) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'IS COMPLETED',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.black),
                  ),
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
                                  .add(LoadingIsCompleted());
                            });
                          },
                          leading: Text(state.todos[index].id),
                          title: Text(state.todos[index].title),
                          trailing: Text(
                              state.todos[index].isCompleted ? "ok" : "not ok"),
                          subtitle: Text(state.todos[index].date),
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

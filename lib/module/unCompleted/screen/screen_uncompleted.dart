import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todos_bloc/module/unCompleted/bloc/uncompleted_bloc.dart';

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
              const SizedBox(
                height: 20.0,
              ),
              Text('asdsd'),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Text(state.listTodo[index].id),
                      trailing: Text(
                          state.listTodo[index].isCompleted ? "ok" : "pending"),
                      title: Text(state.listTodo[index].date),
                      subtitle: Text(state.listTodo[index].title),
                    ),
                  );
                },
                itemCount: state.listTodo.length,
              ),
            ],
          );
        } else {
          return Text('data');
        }
      },
    ));
  }
}

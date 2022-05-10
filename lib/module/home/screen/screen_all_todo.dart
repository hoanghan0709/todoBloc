import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/module/home/bloc/home_bloc.dart';

class AllTodoScreen extends StatefulWidget {
  const AllTodoScreen({Key? key}) : super(key: key);

  @override
  State<AllTodoScreen> createState() => _AllTodoScreenState();
}

class _AllTodoScreenState extends State<AllTodoScreen> {
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
          // TODO: implement listener
          if (state is HomeLoading) { 
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return CircularProgressIndicator();
            }
            if (state is HomeLoaded) {
              return Column(
                children: [
                  const SizedBox(
                    height: 40.0,
                  ),
                  const Text(
                    'List Task',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (ctxx, index) {
                      return Card(
                          color: Colors.grey,
                          shadowColor: Colors.green,
                          child: ListTile(
                              onLongPress: () {
                                ctxx.read<HomeBloc>().add(RemoveTodoEvents(
                                    index:
                                        index)); //tại homebloc.nhận vào even remove ->return state Homeloaded
                              },
                              onTap: () {
                                // ctxx
                                //     .read<HomeBloc>()
                                //     .add(ChangetodoEvents(index));
                                BlocProvider.of<HomeBloc>(this.context)
                                    .add(ChangetodoEvents(index));
                              },
                              title: txt(state.listTodo[index].title),
                              leading: txt(state.listTodo[index].id),
                              subtitle: txt(state.listTodo[index].date),
                              trailing: (state.listTodo[index].isCompleted
                                  ? Icon(Icons.check_box)
                                  : Icon(Icons.check_box_outline_blank))));
                    },
                    itemCount: state.listTodo.length,
                  ),
                ],
              );
            } else {
              return Container(
                child: Text("error"),
              );
            }
          },
        ),
      ),
    );
  }

  Text txt(String title) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
    );
  }
}

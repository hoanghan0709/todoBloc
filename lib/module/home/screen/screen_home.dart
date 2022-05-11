import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/core/repository/TodoRepository.dart';
import 'package:todos_bloc/module/db/preferences.dart';
import 'package:todos_bloc/module/home/add/bloc/add_bloc.dart';
import 'package:todos_bloc/module/home/bloc/home_bloc.dart';
import 'package:todos_bloc/module/home/add/screen/screen_add.dart';
import 'package:todos_bloc/module/home/screen/screen_all_todo.dart';
import 'package:todos_bloc/module/isCompleted/screen/screen_iscompleted.dart';
import 'package:todos_bloc/module/unCompleted/bloc/uncompleted_bloc.dart';
import 'package:todos_bloc/module/unCompleted/screen/screen_uncompleted.dart';

import '../../isCompleted/bloc/iscompleted_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final _pref = PreferencesService();
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(
        loadTodoEvents(todoModel: context.read<TodoRepository>().AllTodos));

    context.read<HomeBloc>().add(PageChangeEvents(index: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext ctx) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is HomeLoading) {}
        },
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    ctx,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) =>
                            AddBloc(ctx.read<TodoRepository>()),
                        child: HomeAdd(),
                      ),
                    )).whenComplete(() {
                  ctx.read<HomeBloc>().add(loadTodoEvents(
                      todoModel: context.read<TodoRepository>().AllTodos));
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: Text('warning'),
                            content: Text('thêm thành công'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('ok'),
                              ),
                              TextButton(
                                onPressed: () => {},
                                child: const Text(
                                  'canel',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                            ]);
                      });
                });
              },
              child: Icon(Icons.add),
            ),
            body: PageView(
              controller: BlocProvider.of<HomeBloc>(context).pageController,
              onPageChanged: (page) {
                context.read<HomeBloc>().add(PageChangeEvents(index: page));
              },
              children: [
                BlocProvider(
                  create: (context) =>
                      HomeBloc(RepositoryProvider.of<TodoRepository>(context)),
                  child: AllTodoScreen(),
                ),
                BlocProvider(
                  // tu man hinh kia chuyen sang
                  create: (context) => IscompletedBloc(
                      RepositoryProvider.of<TodoRepository>(context)),
                  child: isCompletedScreen(),
                ),
                BlocProvider(
                  create: (context) => UncompletedBloc(
                      RepositoryProvider.of<TodoRepository>(context)),
                  child: UnCompletedScreen(),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

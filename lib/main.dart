import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/core/base/observer.dart';
import 'package:todos_bloc/core/repository/TodoRepository.dart';
import 'package:todos_bloc/module/home/add/screen/screen_add.dart';
import 'package:todos_bloc/module/home/bloc/home_bloc.dart';

import 'module/home/screen/screen_home.dart';
import 'package:flutter/rendering.dart';

import 'module/update/screen/updateIscom_screen.dart';

void main() {
  BlocOverrides.runZoned(() => runApp(const MyApp()), blocObserver: Observer());
  debugPaintSizeEnabled = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Color(0xAFABD7E8)),
        debugShowCheckedModeBanner: false,
        home: RepositoryProvider(
          create: (context) => TodoRepository(),
          lazy: false,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => HomeBloc(context.read<TodoRepository>()),
              ),
              // BlocProvider(
              //   create: (context) =>
              //       IscompupdateBloc(context.read<TodoRepository>()),
              // )
            ],
            child: HomeScreen(),
          ),
        )
        // ,routes: <String,WidgetBuilder>{
        //   '/add' :(context) => HomeAdd(),
        //   '/update' :(context) => isCompleUpdateScreen(todoModel: null,),
        // },
        );
  }
}

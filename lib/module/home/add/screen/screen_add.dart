import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/core/repository/TodoRepository.dart';
import 'package:todos_bloc/module/home/add/bloc/add_bloc.dart';
import 'package:todos_bloc/module/home/bloc/home_bloc.dart';

import '../../../../core/model/todos.dart';

class HomeAdd extends StatelessWidget {
  final form = GlobalKey<FormState>();

  HomeAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// không đc để trong build
    TextEditingController textid = TextEditingController();
    TextEditingController texttitle = TextEditingController();
    TextEditingController textdate = TextEditingController();

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Card(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Add Todo',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.black),
                  ),
                ),
                textfield('id', textid),
                textfield('title', texttitle),
                textfield('date', textdate),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        var todo = TodoModel(2,
                            id: 222, title: texttitle.text, completed: true);

                        context.read<AddBloc>().add(addEvents(todo: todo));
                        Navigator.pop(context);
                      },
                      child: Text('add todo')),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ),
      ),
    );
  }

  Widget textfield(
    String title,
    TextEditingController controller,
  ) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '$title',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Enter values',
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              ))),
                      controller: controller,
                    ),
                  ),
                  margin: EdgeInsets.all(10.0),
                ),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}

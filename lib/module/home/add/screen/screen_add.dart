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

    return BlocListener<AddBloc, AddState>(
      listener: (context, state) {
        // ben day no moi nhan
        if (state is AddLoaded) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Added!')));
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Card(
            child: Column(
              children: [
                textfield('id', textid),
                textfield('title', texttitle),
                textfield('date', textdate),
                ElevatedButton(
                    onPressed: () {
                      var todo = TodoModel(
                          id: textid.text,
                          title: texttitle.text,
                          date: textdate.text);
                      Navigator.pop(context);

                      context.read<AddBloc>().add(addEvents(todo: todo));
                    },
                    child: Center(
                        child: Container(
                            height: 30.0, width: 30.0, child: Text('add'))))
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
          SizedBox(
            height: 20.0,
          ),
          Text(
            '$title',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            child: Form(
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Hint text',
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
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}

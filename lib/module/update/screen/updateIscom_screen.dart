import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/todos.dart';
import '../bloc/iscompupdate_bloc.dart';

class isCompleUpdateScreen extends StatefulWidget {
  TodoModel todoModel;
  isCompleUpdateScreen({
    Key? key,
    required this.todoModel,
  }) : super(key: key);

  @override
  State<isCompleUpdateScreen> createState() => _isCompleUpdateScreenState();
}

class _isCompleUpdateScreenState extends State<isCompleUpdateScreen> {
  TextEditingController txtid = TextEditingController();
  TextEditingController txttitle = TextEditingController();
  TextEditingController txtdate = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    txtid = TextEditingController(text: widget.todoModel.id);
    txttitle = TextEditingController(text: widget.todoModel.title);
    txtdate = TextEditingController(text: widget.todoModel.date);
    super.initState();
    BlocProvider.of<IscompupdateBloc>(context).add(loadingUpdateEvents());

    // BlocProvider.of<IscompupdateBloc>(context)
    //     .add(UpdateEvents(todoModel: widget.todoModel));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IscompupdateBloc, IscompupdateState>(
      builder: (context, state) {
        if (state is IscompupdateLoading) {
          return Column(
            children: [CircularProgressIndicator.adaptive(), Text('data')],
          );
        }
        if (state is IscompupdateLoaded) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Update Task',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.black),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: TextFormField(
                      //     style: TextStyle(fontWeight: FontWeight.bold),
                      //     controller: txtid,
                      //     decoration: InputDecoration(
                      //         labelText: 'Id',
                      //         labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      //         border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(20))),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: TextFormField(
                      //     controller: txttitle,
                      //     decoration: const InputDecoration(
                      //         labelText: 'title',
                      //         hintText: 'title',
                      //         border: OutlineInputBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(20)))),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: TextFormField(
                      //     decoration: const InputDecoration(
                      //         labelText: 'date',
                      //         hintText: 'date',
                      //         border: OutlineInputBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(20)))),
                      //     controller: txtdate,
                      //   ),
                      // ),
                    ),
                    _builText('id', txtid),
                    _builText('tile', txttitle),
                    _builText('date', txtdate),
                    ElevatedButton(
                        onPressed: () {
                          var todo = TodoModel(
                              id: txtid.text,
                              title: txttitle.text,
                              date: txtdate.text);

                          BlocProvider.of<IscompupdateBloc>(context)
                              .add(UpdateEvents(todoModel: todo));
                          Navigator.pop(context);
                          print('--------todo---------');
                          print('$todo');
                        },
                        child: const Text('update'))
                  ],
                ),
              ),
            ),
          );
        } else {
          return Text('data');
        }
      },
    );
  }

  Widget _builText(String name, TextEditingController txt) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: TextStyle(fontWeight: FontWeight.bold),
        controller: txt,
        decoration: InputDecoration(
            labelText: name,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}

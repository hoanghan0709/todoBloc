import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_bloc/core/model/todos.dart';

class PreferencesService {
  Future saveTodo(TodoModel todoModel) async {
    final pref = await SharedPreferences.getInstance();
    //await pref.setInt('id', todoModel.id);
    await pref.setString('title', todoModel.title);
    //await pref.setString('date', todoModel.date);
    await pref.setBool('isCompleted', todoModel.completed);
    print('----save Todo----');
    print('$pref');
  }

  //Future<TodoModel> getTodo() async {
    // final prefs = await SharedPreferences.getInstance();
    // final id = prefs.getInt('id');
    // final title = prefs.getString('title');
    // final date = prefs.getString('date');
    // final isCompleted = prefs.getBool('isCompleted');
   // return TodoModel(id: id!, title: title!);
  //}
}

import 'dart:convert';

import 'dart:io';

import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  String id;
  String title;
  String date;
  bool isCompleted;
  TodoModel({
    required this.id,
    required this.title,
    required this.date,
    this.isCompleted = false,
  });

  @override
  List<Object> get props => [this.id];
  TodoModel copyWith({
    String? id,
    String? title,
    String? date,
    bool? isCompleted,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  @override
  String toString() {
    return 'TodoModel(id: $id, title: $title, date:$date,  isCompleted: $isCompleted)';
  }
}

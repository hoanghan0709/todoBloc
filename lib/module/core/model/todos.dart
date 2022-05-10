// TODO Implement this library.
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

  TodoModel copyWith(
      {String? id, String? title, String? date, required bool isCompleted}) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      isCompleted: isCompleted,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [this.id, this.date, this.title, this.isCompleted];
}

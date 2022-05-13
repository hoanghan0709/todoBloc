import 'package:json_annotation/json_annotation.dart';

import 'package:equatable/equatable.dart';
part 'todos.g.dart';

@JsonSerializable()
class TodoModel extends Equatable {
  int id;
  String title;
  //late String date;
  bool completed;
  TodoModel({
    required this.id,
    required this.title,
   // required this.date,
    this.completed = false,
  });

  @override
  List<Object> get props => [id];
  TodoModel copyWith({
    int? id,
    String? title,
    String? date,
    bool? Completed,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
    ///  date: date ?? this.date,
      completed: Completed ?? this.completed,
    );
  }

  

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
  @override
  String toString() {
    return 'TodoModel(id: $id, title: $title, completed: $completed)';
  }
}

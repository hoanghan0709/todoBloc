import 'package:json_annotation/json_annotation.dart';

import 'package:equatable/equatable.dart';
part 'todos.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class TodoModel extends Equatable {
  int userId;
  int id;
  String title;
  //late String date;
  bool completed;
  TodoModel(
    this.userId, {
    required this.id,
    required this.title,
    // required this.date,
    this.completed = false,
  });

  @override
  List<Object> get props => [];
  TodoModel copyWith({
    required int id,
    required String title,
    required String date,
    required bool completed,
  }) {
    return TodoModel(
      userId,
      id: id,
      title: title,

      ///  date: date ?? this.date,
      completed: completed,
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
  @override
  String toString() {
    return 'TodoModel(userid : $userId, $id, title: $title, completed: $completed)';
  }
}

import 'package:common_ui/common/db/collection/todo_db_model.dart';
import 'package:common_ui/common/db/todo_status.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vo_todo.freezed.dart';
part 'vo_todo.g.dart';

// dart run build_runner watch -d 명령어 사용
@unfreezed
class Todo with _$Todo {
  Todo._();

  factory Todo({
    required final int id,
    required final DateTime createdTime,
    DateTime? modifyTime,
    required String title,
    required DateTime dueDate,
    @Default(TodoStatus.unknown) TodoStatus status,
  }) = _Todo;

  factory Todo.fromJson(Map<String, Object?> json) => _$TodoFromJson(json);

  TodoDbModel get dbModel =>
      TodoDbModel(id, createdTime, modifyTime, title, dueDate, status);
}

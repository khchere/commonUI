import 'package:common_ui/common/db/todo_status.dart';
import 'package:common_ui/common/db/vo_todo.dart';
import 'package:isar/isar.dart';

part 'todo_db_model.g.dart';

@collection
class TodoDbModel {
  Id id;

  @Index(type: IndexType.value)
  final DateTime createdTime;

  @Index(type: IndexType.value)
  DateTime? modifyTime;

  @Index(type: IndexType.value)
  String title;

  DateTime dueDate;

  @enumerated
  TodoStatus status;

  TodoDbModel(
    this.id,
    this.createdTime,
    this.modifyTime,
    this.title,
    this.dueDate,
    this.status,
  );

  Todo createTodo() {
    return Todo(
        id: id,
        title: title,
        dueDate: dueDate,
        createdTime: createdTime,
        status: status,
        modifyTime: modifyTime);
  }
}

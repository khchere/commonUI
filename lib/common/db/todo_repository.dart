import 'package:common_ui/common/db/vo_todo.dart';
import 'package:common_ui/common/network/simple_result.dart';

abstract interface class TodoRepository<Error> {
  Future<SimpleResult<List<Todo>, Error>> getTodoList();
  Future<SimpleResult<void, Error>> addTodo(Todo todo);
  Future<SimpleResult<void, Error>> updateTodo(Todo todo);
  Future<SimpleResult<void, Error>> removeTodo(int id);
}

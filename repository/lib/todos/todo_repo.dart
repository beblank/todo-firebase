

import 'package:repository/todos/models/models.dart';

abstract class TodoRepo{
  Future<void> addNewToDo(Todo todo);

  Future<void> deleteToDo(Todo todo);

  Stream<List<Todo>> todos();

  Future<void> updateTodo(Todo todo);
}
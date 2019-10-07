

import 'package:repository/todos/models/models.dart';

abstract class TodoRepo{
  
  Future<void> addNewToDo(Todo todo, String uid);

  Future<void> deleteToDo(Todo todo, String uid);

  Stream<List<Todo>> todos(String uid);

  Future<void> updateTodo(Todo todo, String uid);
}
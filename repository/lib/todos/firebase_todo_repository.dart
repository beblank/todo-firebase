
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repository/todos/models/models.dart';
import 'package:repository/todos/todo_repo.dart';

import 'entities/entities.dart';

class FirebaseTodoRepository implements TodoRepo{
  final todoCollection = Firestore.instance.collection('todos');

  @override
  Future<void> addNewToDo(Todo todo) => todoCollection.add(todo.toEntity().toDocument());

  @override
  Future<void> deleteToDo(Todo todo) => todoCollection.document(todo.id).delete();

  @override
  Stream<List<Todo>> todos() {
    return todoCollection.snapshots().map((snapshot){
      return snapshot.documents.map((doc) => Todo.fromEntity(TodoEntity.fromSnapshot(doc))).toList();
    });
  }

  @override
  Future<void> updateTodo(Todo todo) {
    return todoCollection
    .document(todo.id)
    .updateData(todo.toEntity().toDocument());
  }

}
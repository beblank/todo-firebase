
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repository/todos/models/models.dart';
import 'package:repository/todos/todo_repo.dart';

import 'entities/entities.dart';

class FirebaseTodoRepository implements TodoRepo{
  // final todoCollection = Firestore.instance.collection('todo');

  @override
  Future<void> addNewToDo(Todo todo, String uid) => Firestore.instance.collection(uid).add(todo.toEntity().toDocument());

  @override
  Future<void> deleteToDo(Todo todo, String uid) => Firestore.instance.collection(uid).document(todo.id).delete();

  @override
  Stream<List<Todo>> todos(String uid) {
    return Firestore.instance.collection(uid).snapshots().map((snapshot){
      return snapshot.documents.map((doc) => Todo.fromEntity(TodoEntity.fromSnapshot(doc))).toList();
    });
  }

  @override
  Future<void> updateTodo(Todo todo, String uid) {
    return Firestore.instance.collection(uid)
    .document(todo.id)
    .updateData(todo.toEntity().toDocument());
  }

}
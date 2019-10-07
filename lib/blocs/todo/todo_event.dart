import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository/todos/models/models.dart';

@immutable
abstract class TodoEvent extends Equatable{
  TodoEvent([List props= const[]]):super(props);
}

class LoadTodo extends TodoEvent {
  final String userId;

  LoadTodo(this.userId):super([userId]);

  @override
  String toString() => 'LoadTodo {userId:$userId}';
}

class AddTodo extends TodoEvent {
  final Todo todo;
  final String userId;

  AddTodo(this.todo, this.userId):super([todo, userId]);

  @override
  String toString() => 'AddTodo { todo: $todo}';
}

class UpdateTodo extends TodoEvent {
  final Todo updatedTodo;
  final String userId;

  UpdateTodo(this.updatedTodo, this.userId):super([updatedTodo, userId]);

  @override
  String toString() => 'updatedTodo {updatedTodo: $updatedTodo}';
}

class DeleteTodo extends TodoEvent {
  final Todo todo;
  final String userId;

  DeleteTodo(this.todo, this.userId):super([todo, userId]);

  @override
  String toString() => 'Deleted Todo {dodo: $todo}';
}

class TodosUpdated extends TodoEvent {
  final List<Todo> todos;
  final String userId;

  TodosUpdated(this.todos, this.userId);

  @override
  String toString() => 'Todos Updated';
}



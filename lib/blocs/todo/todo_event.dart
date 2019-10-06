import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository/todos/models/models.dart';

@immutable
abstract class TodoEvent extends Equatable{
  TodoEvent([List props= const[]]):super(props);
}

class LoadTodo extends TodoEvent {
  @override
  String toString() => 'LoadTodo';
}

class AddTodo extends TodoEvent {
  final Todo todo;

  AddTodo(this.todo):super([todo]);

  @override
  String toString() => 'AddTodo { todo: $todo}';
}

class UpdateTodo extends TodoEvent {
  final Todo updatedTodo;

  UpdateTodo(this.updatedTodo):super([updatedTodo]);

  @override
  String toString() => 'updatedTodo {updatedTodo: $updatedTodo}';
}

class DeleteTodo extends TodoEvent {
  final Todo todo;

  DeleteTodo(this.todo):super([todo]);

  @override
  String toString() => 'Deleted Todo {dodo: $todo}';
}

class TodosUpdated extends TodoEvent {
  final List<Todo> todos;

  TodosUpdated(this.todos);

  @override
  String toString() => 'Todos Updated';
}



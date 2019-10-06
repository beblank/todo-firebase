import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository/todos/models/models.dart';

@immutable
abstract class ListTodoEvent extends Equatable{
  ListTodoEvent([List props = const[]]):super(props);
}

class UpdateListTodo extends ListTodoEvent{
  final List<Todo> todo;

  UpdateListTodo(this.todo):super([todo]);

  @override
  String toString() => 'Update List Todo {todo: $todo}';
}
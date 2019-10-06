import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository/todos/models/models.dart';

@immutable
abstract class ListTodoState extends Equatable{
  ListTodoState([List props = const[]]):super(props);
}

class ListTodoLoading extends ListTodoState{
  @override
  String toString() => 'List to do loading';
}

class ListTodoLoaded extends ListTodoState{
  final List<Todo> listTodo;

  ListTodoLoaded(this.listTodo):super([listTodo]);

  @override
  String toString() => 'List to do loaded { ListTodo: $listTodo}';
}


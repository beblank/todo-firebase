import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository/todos/models/models.dart';

@immutable
abstract class TodoState extends Equatable{
  TodoState([List props = const[]]):super(props);
}

class TodoLoading extends TodoState{
  @override
  String toString() => "Todo Loading";
}

class TodoLoaded extends TodoState{
  final List<Todo> todos;

  TodoLoaded([this.todos=const[]]):super([todos]);

  @override
  String toString() => "Todo Loaded {todos: $todos}";
}

class TodoNotLoaded extends TodoState{
  @override
  String toString() => "Todo Not Loaded";
}
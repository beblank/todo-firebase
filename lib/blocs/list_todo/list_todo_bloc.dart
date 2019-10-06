import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:repository/todos/models/todo.dart';
import 'package:todo_firebase/blocs/todo/todo.dart';
import 'list_todo.dart';

class ListTodoBloc extends Bloc<ListTodoEvent, ListTodoState> {
  final TodoBloc _todoBloc;
  StreamSubscription _todoSubscription;

  ListTodoBloc({@required TodoBloc todoBloc})
  : assert(todoBloc != null),
  _todoBloc = todoBloc{
    _todoSubscription = todoBloc.state.listen((state){
      if (state is TodoLoaded){
        dispatch(UpdateListTodo((todoBloc.currentState as TodoLoaded).todos));
      }});
  }
  
  @override
  ListTodoState get initialState => ListTodoLoading();

  @override
  Stream<ListTodoState> mapEventToState(ListTodoEvent event) async*{
    yield* _mapTodosUpdatedToState(event);
  }

  Stream<ListTodoState> _mapTodosUpdatedToState(UpdateListTodo event) async* {
    yield ListTodoLoaded(
      _mapTodoToListTodo(
        (_todoBloc.currentState as TodoLoaded).todos
      )
    );
  }

  List<Todo> _mapTodoToListTodo(List<Todo> todos) {
    return todos.where((todo){
      return true;
    }).toList();
  }

  @override
  void dispose() {
    _todoSubscription?.cancel();
    super.dispose();
  }
  
}
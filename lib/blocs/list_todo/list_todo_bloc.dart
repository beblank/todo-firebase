import 'dart:async';

import 'package:bloc/bloc.dart';
import 'list_todo.dart';

class ListTodoBloc extends Bloc<ListTodoEvent, ListTodoState> {

  @override
  ListTodoState get initialState => null;

  @override
  Stream<ListTodoState> mapEventToState(ListTodoEvent event) {
    return null;
  }
  
}
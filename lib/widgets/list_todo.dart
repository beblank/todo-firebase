

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_firebase/blocs/list_todo/list_todo.dart';
import 'package:todo_firebase/blocs/todo/todo.dart';
import 'package:todo_firebase/screens/screens.dart';
import 'package:todo_firebase/widgets/todo_item.dart';
import 'package:todo_firebase/widgets/widgets.dart';

class ListTodo extends StatelessWidget {
  const ListTodo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);
      return BlocBuilder<ListTodoBloc, ListTodoState>(
        builder: (context, state){
          if(state is ListTodoLoading){
            return LoadingIndicator();
          } else if (state is ListTodoLoaded){
            final listTodo = state.listTodo;
            return ListView.builder(
              itemCount: listTodo.length,
              itemBuilder: (context, index){
                final todo = listTodo[index];
                return TodoItem(
                  todo: todo,
                  onDismissed: (direction){
                    todoBloc.dispatch(DeleteTodo(todo));
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('deleted'),));
                  },
                  onTap: () async {
                  final removedTodo = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return DetailScreen(id: todo.id);
                    }),
                  );
                  if (removedTodo != null) {
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('deleted'),));
                  }
                },
                  onCheckboxChanged: (_){
                    todoBloc.dispatch(UpdateTodo(todo.copyWith(complete: !todo.complete)));
                  },
                );
              },
            );
          } else {
            return Container();
          }
        },
      );
  }
}
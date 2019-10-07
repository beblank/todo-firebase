

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_firebase/blocs/todo/todo.dart';
import 'package:todo_firebase/screens/screens.dart';

class DetailScreen extends StatelessWidget {
  final String id;
  final String userId;

  const DetailScreen({Key key, @required this.id, @required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state){
        final todo = (state as TodoLoaded)
          .todos
          .firstWhere((todo) => todo.id == id, orElse: () => null);
        return Scaffold(
          appBar: AppBar(
            title: Text('Todo Details'),
            actions: <Widget>[
              IconButton(
                tooltip: 'Delete Todo',
                icon: Icon(Icons.delete),
                onPressed: (){
                  todoBloc.dispatch(DeleteTodo(todo, userId));
                  Navigator.pop(context, todo);
                }
              )
            ],
          ),
          body: todo == null
                ? Container()
                : Padding(
                  padding: EdgeInsets.all(16),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Checkbox(
                              value: todo.complete,
                              onChanged: (_){
                                todoBloc.dispatch(
                                  UpdateTodo(
                                    todo.copyWith(complete: !todo.complete),
                                    userId
                                  ));},),),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Hero(
                                  tag: '${todo.id}__heroTag',
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(top:8, bottom:16),
                                    child: Text(
                                      todo.task,
                                      style: Theme.of(context).textTheme.headline
                                    )
                                  ),
                                ),
                                Text(
                                  todo.note,
                                  style: Theme.of(context).textTheme.subhead,
                                )
                              ],
                            )
                          )
                        ],
                      )
                    ],
                  )),
                  floatingActionButton: FloatingActionButton(
            tooltip: 'Edit Todo',
            child: Icon(Icons.edit),
            onPressed: todo == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AddEditScreen(
                            onSave: (task, note) {
                              todoBloc.dispatch(
                                UpdateTodo(
                                  todo.copyWith(task: task, note: note),
                                  userId,
                                ),
                              );
                            },
                            isEditing: true,
                            todo: todo,
                          );
                        },
                      ),
                    );
                  },
          ),
        );
      },
    );
  }
}
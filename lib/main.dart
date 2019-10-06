import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';
import 'package:todo_firebase/blocs/auth/auth_bloc.dart';
import 'package:todo_firebase/blocs/blocs.dart';
import 'package:todo_firebase/blocs/list_todo/list_todo.dart';
import 'package:todo_firebase/blocs/todo/todo_bloc.dart';
import 'package:todo_firebase/screens/home_screens.dart';
import 'package:todo_firebase/widgets/loading_indicator.dart';

import 'blocs/auth/auth.dart';
import 'blocs/todo/todo.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          builder: (context){
            return AuthBloc(
              userRepo: FirebaseUserRepo(),
            )..dispatch(AppStarted());
          },
        ),
        BlocProvider<TodoBloc>(
          builder: (context){
            return TodoBloc(
              todoRepo: FirebaseTodoRepository()
            )..dispatch(LoadTodo());
          },
        )
      ],
      child: MaterialApp(
        title: 'Simple Firestore Todo',
        routes: {
          '/': (context){
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state){
                 if (state is Authenticated){
                  final todoBloc = BlocProvider.of<TodoBloc>(context);
                  return BlocProvider<ListTodoBloc>(
                    builder: (context) => ListTodoBloc(todoBloc: todoBloc),
                    child: HomeScreen(),
                  );
                }
                if (state is Unauthenticated){
                  return Center(
                    child: Text('Could not authenticate with Firestore'),
                  );
                }
                return LoadingIndicator();
              },
            );
          }
        }
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:todo_firebase/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  final String _userId;

  const HomeScreen({Key key, @required String userId})
  : assert(userId!=null),
  _userId = userId,
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Firestore Todo'),),
      body: ListTodo(userId: _userId),
      floatingActionButton: FloatingActionButton(
        onPressed:() => Navigator.pushNamed(context, '/addTodo'),
        child: Icon(Icons.add),
        tooltip: 'Add Todo',
      ),
    );
  }
}
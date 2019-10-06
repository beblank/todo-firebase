import 'package:flutter/material.dart';
import 'package:todo_firebase/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Firestore Todo'),),
      body: ListTodo(),
      floatingActionButton: FloatingActionButton(
        onPressed:() => Navigator.pushNamed(context, '/addTodo'),
        child: Icon(Icons.add),
        tooltip: 'Add Todo',
      ),
    );
  }
}
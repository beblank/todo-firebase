
import 'package:flutter/material.dart';
import 'package:repository/todos/models/models.dart';

typedef OnSaveCallback = Function(String task, String note);

class AddEditScreen extends StatefulWidget {

  final bool isEditing;
  final OnSaveCallback onSave;
  final Todo todo;

  AddEditScreen({
    Key key, 
    @required this.isEditing, 
    @required this.onSave, 
    this.todo}) : super(key: key);

  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _task;
  String _note;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing? 'Edit Todo' : 'Add Todo',
        )
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: isEditing ? widget.todo.task : '',
                autofocus: !isEditing,
                style: textTheme.headline,
                decoration: InputDecoration(
                  hintText: 'What needs to be done?',
                ),
                validator: (val){
                  return val.trim().isEmpty ? 'Please enter some text': null;
                },
                onSaved: (value) => _task = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.todo.note: '',
                maxLines: 10,,
                style: textTheme.subhead,
                decoration: InputDecoration(
                  hintText:'Aditional Notes...'
                ),
                onSaved: (value) => _note = value,
              )
            ],
          )
        )
      )
    );
  }
}
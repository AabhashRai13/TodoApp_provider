import 'package:combine/todo_with_provider/provider/todos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/taskModel.dart';



class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final taskTitleController = TextEditingController();
  bool completedStatus = false;
  
  @override
  void dispose() {
    taskTitleController.dispose();
    super.dispose();
  }
  
  void onAdd() {
    final String textVal = taskTitleController.text;
    final bool completed = completedStatus;
    if (textVal.isNotEmpty) {
      final Task todo = Task(
        title: textVal,
        completed: completed,
      );
      Provider.of<TodosModel>(context, listen: false).addTodo(todo);
      Navigator.pop(context);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(controller: taskTitleController),
                  CheckboxListTile(
                    value: completedStatus,
                    onChanged: (checked) => setState(() {
                      completedStatus = checked;
                    }),
                    title: Text('Complete?'),
                  ),
                  RaisedButton(
                    child: Text('Add'),
                    onPressed: onAdd,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
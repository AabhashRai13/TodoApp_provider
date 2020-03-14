import 'package:combine/todo_with_provider/model/taskModel.dart';
import 'package:combine/todo_with_provider/provider/todos_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';



class TaskListItem extends StatelessWidget {
  final Task task;
  
  TaskListItem({@required this.task});
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.completed,
        onChanged: (bool checked) {
          Provider.of<TodosModel>(context, listen: false).toggleTodo(task);
        },
      ),
      title: Text(task.title),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          Provider.of<TodosModel>(context, listen: false).deleteTodo(task);
        },
      ),
    );
  }
}

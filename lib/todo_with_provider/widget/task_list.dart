import 'package:combine/todo_with_provider/widget/task_list_item.dart';
import 'package:flutter/material.dart';
import 'package:combine/todo_with_provider/model/taskModel.dart';




class TaskList extends StatelessWidget {
  final List<Task> tasks;
  
  TaskList({@required this.tasks});
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getChildrenTasks(),
    );
  }
  
  List<Widget> getChildrenTasks() {
    return tasks.map((todo) => TaskListItem(task: todo)).toList();
  }
}
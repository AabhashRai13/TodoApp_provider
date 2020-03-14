// lib/tabs/completed_tasks.dart
import 'package:combine/todo_with_provider/provider/todos_provider.dart';
import 'package:combine/todo_with_provider/widget/task_list.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';



class CompletedTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TodosModel>(
        builder: (context, todos, child) => TaskList(
          tasks: todos.completedTasks,
        ),
      ),
    );
  }
}
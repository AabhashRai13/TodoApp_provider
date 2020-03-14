import 'package:combine/todo_with_provider/tab/Completed_task.dart';
import 'package:combine/todo_with_provider/tab/all_task.dart';
import 'package:combine/todo_with_provider/tab/incomplete_task.dart';
import 'package:flutter/material.dart';

import 'package:combine/todo_with_provider/add_task_screen.dart';

class TodoMainScreen extends StatefulWidget {
  @override
  _TodoMainScreenState createState() => _TodoMainScreenState();
}

class _TodoMainScreenState extends State<TodoMainScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(text: 'All'),
            Tab(text: 'Incomplete'),
            Tab(text: 'Complete'),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          AllTasksTab(),
          IncompleteTasksTab(),
          CompletedTasksTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => AddTaskScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

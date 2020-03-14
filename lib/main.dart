
import 'package:combine/flavour.dart';
import 'package:combine/homepage.dart';
import 'package:combine/notifier/task_notifier.dart';
import 'package:combine/todo_with_provider/provider/todos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // ignore: always_specify_types
  runApp(ChangeNotifierProvider(
    builder: (_) => TodosModel(),
    child: MaterialApp(
      home: HomePage(),
    ),
  ));
}

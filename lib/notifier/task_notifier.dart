import 'dart:collection';
import 'package:combine/model/listitem.dart';
import 'package:flutter/widgets.dart';

class TaskNotifier with ChangeNotifier {
  // ignore: always_specify_types
   List<ListItem> _taskList = [];

  UnmodifiableListView<ListItem> get taskList =>
      // ignore: always_specify_types
      UnmodifiableListView(_taskList);

  void addFood(ListItem listItem) {
    _taskList.add(listItem);
    notifyListeners();
  }
}

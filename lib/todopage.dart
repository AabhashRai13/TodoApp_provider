
import 'package:combine/model/listitem.dart';
import 'package:combine/notifier/task_notifier.dart';
import 'package:combine/tempVariables.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:date_format/date_format.dart';
import 'package:provider/provider.dart';

import 'model/listitem.dart';
import 'model/listitem.dart';





class strikeThrough extends StatefulWidget {
  final String todoText ;
  final bool todoCheck;
  final String finalDate;
  strikeThrough(this.todoText, this.todoCheck, this.finalDate) : super();

  @override
  _strikeThroughState createState() => _strikeThroughState();
}

class _strikeThroughState extends State<strikeThrough> {
  Widget _widget() {
    TaskNotifier taskNotifier = Provider.of<TaskNotifier>(context);
    if (widget.todoCheck) {
      return Text(
        widget.todoText,
        style: TextStyle(
          decoration: TextDecoration.lineThrough,
          fontStyle: FontStyle.italic,
          fontSize: 22.0,
          color: Colors.red[200],
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          Text(
            widget.todoText,
            style: TextStyle(fontSize: 22.0),
          ),
          Text(widget.finalDate)
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _widget();
  }
}

class App extends StatefulWidget {
  @override
  AppState createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  var counter = 0;

  var textController = TextEditingController();
  var popUpTextController = TextEditingController();

  List<ListItem> WidgetList = [];

  @override
  void dispose() {
    textController.dispose();
    popUpTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TaskNotifier taskNotifier = Provider.of<TaskNotifier>(context);
    return Scaffold(
     
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                for (final widget in WidgetList)
                  GestureDetector(
                      key: Key(widget.todoText),
                      child: Dismissible(
                        key: Key(widget.todoText),
                        child: CheckboxListTile(
                          //key: ValueKey("Checkboxtile $widget"),
                          value: widget.todoCheck,
                          title: strikeThrough(widget.todoText,
                              widget.todoCheck, widget.finalDate),
                          onChanged: (checkValue) {
                            //strikeThrough toggle
                            setState(() {
                              if (!checkValue) {
                                widget.todoCheck = false;
                              } else {
                                widget.todoCheck = true;
                              }
                            });
                          },
                        ),
                        background: Container(
                          child: Icon(Icons.delete),
                          alignment: Alignment.centerRight,
                          color: Colors.orange[300],
                        ),
                        confirmDismiss: (dismissDirection) {
                          return showDialog(
                              //On Dismissing
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Delete Todo?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                    ), //OK Button
                                    FlatButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                    ), //Cancel Button
                                  ],
                                );
                              });
                        },
                        direction: DismissDirection.endToStart,
                        movementDuration: const Duration(milliseconds: 200),
                        onDismissed: (dismissDirection) {
                          //Delete Todo
                          WidgetList.remove(widget);
                          Fluttertoast.showToast(msg: "Todo Deleted!");
                        },
                      ),
                      onDoubleTap: () {
                        popUpTextController.text = widget.todoText;
                        // Editing Todo
                        showDialog<dynamic>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Edit Todo"),
                                content: TextFormField(
                                  controller: popUpTextController,
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      setState(() {
                                        widget.todoText =
                                            popUpTextController.text;
                                      });
                                      Navigator.of(context).pop(true);
                                    },
                                  ), //OK Button
                                  FlatButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                  ), //Cancel Button
                                ],
                              );
                            });
                      })
              ],
            ),
          )
        ],
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: pushAddTodoScreen,
          tooltip: 'Add task',
          child: new Icon(Icons.add)),
    );
  }

  void pushAddTodoScreen() {
    final _formKey = GlobalKey<FormState>();
    final _scaffoldKey = GlobalKey<ScaffoldState>();


    DateTime choosenDate;
    String selectedDate;
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return new Scaffold(
          key: _scaffoldKey,
          appBar: new AppBar(title: new Text('Add a new task')),
          body: Container(
            child: new Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: TextField(
                      decoration:
                          InputDecoration(hintText: "Enter Todo Text Here"),
                      style: TextStyle(
                        fontSize: 22.0,
                        //color: Theme.of(context).accentColor,
                      ),
                      controller: textController,
                      cursorWidth: 5.0,
                      autocorrect: true,
                      autofocus: true,
                      //onSubmitted: ,
                    ),
                  ),
                  ListTile(
                    title: Text("Select Date For Task"),
                    subtitle: RaisedButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2018, 3, 5),
                            maxTime: DateTime(2020, 12, 30), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          setState(() {
                            choosenDate = date;
                          });
                          selectedDate = convertDateToString(choosenDate);
                          TempVariables.intdate = convertDateToString(DateTime.now());
                          print(TempVariables.intdate);

                          print('confirm $date');
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      child: Text("Set Date"),
                    ),
                    leading: Text(
                        (choosenDate == null) ? "Select Date" : selectedDate),
                  ),
                  ListTile(
                    title: RaisedButton(
                      child: Text("Add Todo"),
                      onPressed: () {
                        if (selectedDate == null) {
                          final validateSnackBar = SnackBar(
                            content: Text('Please Choose Date for Task completion'),
                          );
                          return _scaffoldKey.currentState.showSnackBar(validateSnackBar);
                        }
                       else if (textController.text.isNotEmpty) {
                          WidgetList.add(new ListItem(
                              textController.text, false, selectedDate));
                          setState(() {
                            textController.clear();
                          });
                        }
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ));
    }));
  }

  String convertDateToString(DateTime choosenDate) {
    String convertedDate;
    print("SucessFull");
    convertedDate = formatDate(choosenDate, [yyyy, '-', mm, '-', dd]);
    print(formatDate(choosenDate, [yyyy, '-', mm, '-', dd]));
    return convertedDate;
  }
}

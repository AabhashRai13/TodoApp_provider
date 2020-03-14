import 'package:combine/calllog.dart';
import 'package:combine/flavour.dart';
import 'package:combine/todo_with_provider/todoMainScreen.dart';
import 'package:combine/todopage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'seeContactsButton.dart';
import 'package:combine/addContacts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    TodoMainScreen(),
    SeeContactsButton(),
    Call_log(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              
              child: Text(''),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              
                title: const Text('Add Contacts'),
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                        builder: (context) => new AddContactPage()))),
            Divider(),
            ListTile(
                title: const Text('Contacts'),
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                        builder: (context) => new SeeContactsButton()))),
            Divider(),
            ListTile(
                title: const Text('Call log'),
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                        builder: (context) => new Call_log()))),
            Divider()
          ],
        ),
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: const Text('Task'),
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: const Text('Contacts'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title:const  Text('Call Logs'))
        ],
      ),
    );
  }
}

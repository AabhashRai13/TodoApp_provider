import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class testContacts extends StatefulWidget {
  testContacts({Key key}) : super(key: key);
  
  @override
  _CallLogState createState() => _CallLogState();
  
}

class _CallLogState extends State<testContacts> {
  
  
  
  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    if (permission != PermissionStatus.granted
    ) {
      final Map<PermissionGroup, PermissionStatus> permissionStatus =
      await PermissionHandler()
          .requestPermissions([PermissionGroup.contacts]);
      return permissionStatus[PermissionGroup.contacts] ??
          PermissionStatus.unknown;
    } else {
      return permission;
    }
  }
  Iterable<Contact> _log;
  dynamic  callContacts() async {
    final Iterable<Contact> entries = await ContactsService.getContacts();
    for (Contact item in entries) {
      print(item.displayName);
    }
    setState(() {
      _log = entries;
    });
  }
  
  @override
  void initState() {
    _getPermission();
//    callContacts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RaisedButton(
          onPressed: _getPermission,
          child: Text("pRESS"),
        ),
      ),
//
//      body: _log != null
//      //Build a list view of all contacts, displaying their avatar and
//      // display name
//          ? ListView.builder(
//        itemCount: _log?.length ?? 0,
//        itemBuilder: (BuildContext context, int index) {
//          Contact contact = _log?.elementAt(index);
//          return ListTile(
//            contentPadding:
//            const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
//
//            title: Text(contact.displayName ?? ''),
//            //This can be further expanded to showing contacts detail
//            // onPressed().
//          );
//        },
//      )
//          : Center(child: const CircularProgressIndicator()),
    );
  }
}
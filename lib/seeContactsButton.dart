import 'dart:ffi';

import 'package:combine/homepage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:combine/contactsPage.dart';

class SeeContactsButton extends StatefulWidget {
  @override
  _SeeContactsButtonState createState() => _SeeContactsButtonState();
}

class _SeeContactsButtonState extends State<SeeContactsButton> {
  Future<bool> _onWillPop() {
    Navigator.push(
        context, MaterialPageRoute<void>(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: RaisedButton(
        onPressed: () async {
          final PermissionStatus permissionStatus = await _getPermission();
          if (permissionStatus == PermissionStatus.granted) {
            Navigator.push(
                context, MaterialPageRoute<Void>(builder: (context) => ContactsPage()));
          } else {
            //If permissions have been denied show standard cupertino alert dialog
            showDialog<dynamic>(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                  title: Text('Permissions error'),
                  content: Text('Please enable contacts access '
                      'permission in system settings'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text('OK'),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ));
          }
        },
        child: Container(child: Text('See Contacts')),
      ),
    );
  }

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
}

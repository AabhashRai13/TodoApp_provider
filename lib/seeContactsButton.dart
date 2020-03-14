import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:combine/contactsPage.dart';

class SeeContactsButton extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
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
    );
  }
  
  //Check contacts permission
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

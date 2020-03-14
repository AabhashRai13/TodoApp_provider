import 'package:combine/homepage.dart';
import 'package:combine/seeContactsButton.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';


class AddContactPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  Contact contact = Contact();
  PostalAddress address = PostalAddress(label: "Home");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a contact"),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                _formKey.currentState.save();
                contact.postalAddresses = [address];
                ContactsService.addContact(contact);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                        builder: (context) => new SeeContactsButton()));
              },
              child: Icon(Icons.save, color: Colors.white))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                    decoration: const InputDecoration(labelText: 'First name'),
                    onSaved: (v) => contact.givenName = v),
               
                
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Phone'),
                    onSaved: (v) =>
                    contact.phones = [Item(label: "mobile", value: v)],
                    keyboardType: TextInputType.phone),
           
              ],
            )),
      ),
    );
  }
}
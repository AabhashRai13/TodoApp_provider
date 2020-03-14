import 'package:call_log/call_log.dart';
import 'package:combine/homepage.dart';
import 'package:flutter/material.dart';

class Call_log extends StatefulWidget {
  Call_log({Key key}) : super(key: key);

  @override
  _CallLogState createState() => _CallLogState();

  }
  
  class _CallLogState extends State<Call_log> {
  
    Future<bool> _onWillPop() {
      Navigator.push(
          context, MaterialPageRoute<void>(builder: (context) => HomePage()));
    }

    
    Iterable<CallLogEntry> _log;
 dynamic  callLogs() async {
    final Iterable<CallLogEntry> entries = await CallLog.get();
  for (CallLogEntry item in entries) {
    print(item.name);
  }
  setState(() {
      _log = entries;
    });
}

@override
  void initState() {
    callLogs();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
       
        body: _log != null
            //Build a list view of all contacts, displaying their avatar and
            // display name
            ? ListView.builder(
                itemCount: _log?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  CallLogEntry contact = _log?.elementAt(index);
                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                   
                    title: Text(contact.name ?? ''),
                    //This can be further expanded to showing contacts detail
                    // onPressed().
                  );
                },
              )
            : Center(child: const CircularProgressIndicator()),
      ),
    );
  }
}
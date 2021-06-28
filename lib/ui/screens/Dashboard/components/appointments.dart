import 'package:flutter/material.dart';

class Appointments extends StatelessWidget {
  const Appointments({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        // padding: new EdgeInsets.all(10.0),
        children: [
          Container(
            // padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
            child: Text("Appointments",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Color(0xFFA8E4EC),
            elevation: 8,
            child: Stack(children: [
              Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                const ListTile(
                  // leading: Icon(Icons.album, size: 60),
                  leading: Icon(Icons.notifications, size: 30),
                  title: Text('13th June 2021, 2:30pm',
                      style: TextStyle(fontSize: 11.0)),
                  subtitle: Text(
                      'NUH Diagnostic Imaging, Main Building Level 1. MRI Scan',
                      style: TextStyle(fontSize: 8.0)),
                ),
              ]),
            ]),
          )
        ]);
  }
}

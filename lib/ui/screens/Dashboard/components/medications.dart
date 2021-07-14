import 'package:flutter/material.dart';

class MedicineDashboard extends StatefulWidget {
  const MedicineDashboard({Key key}) : super(key: key);

  @override
  _MedicineDashboardState createState() => _MedicineDashboardState();
}

class _MedicineDashboardState extends State<MedicineDashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("Medications",
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 3),
      Container(
        width: 140,
        height: 180,
        padding: const EdgeInsets.all(10),
        // color: Colors.black,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          //color: Colors.black,
          //color:
          color: Colors.blue[900],
          //Color(0xFFA8E4EC),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
    ]);
  }
}

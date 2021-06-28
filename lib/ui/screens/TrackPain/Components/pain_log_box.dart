import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Profile/Components/profile_model.dart';

class PainLogBox extends StatelessWidget {
  final String date;
  final String bodyPart;
  final int painLevel;
  final int duration;
  final String otherSymptoms;
  final String medicine;
  // final Function editFunction;
  // final Function deleteFunction;

  final String logID;
  final Profile curUser;
  final BuildContext context;
  //final GlobalKey<FormState> formkey;

  const PainLogBox({
    Key key,
    this.date,
    this.bodyPart,
    this.painLevel,
    this.duration,
    this.otherSymptoms,
    this.medicine,
    // this.editFunction,
    // this.deleteFunction,
    this.logID,
    this.curUser,
    this.context,
    //this.formkey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      height: size.height * 0.12,
      margin: const EdgeInsets.all((10)),
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red[900],
            ),
            onPressed: () async {
              // delete function for firebase
              curUser.usersCol
                  .document(curUser.uid)
                  .collection("painLogs")
                  .document(logID)
                  .delete();
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Entry deleted')));
            }),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Area: $bodyPart, Pain Level: $painLevel",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            Text("Date: $date"),
            Text("Duration: $duration minutes"),
            Text("Medicines taken: $medicine"),
            Text("Other symptoms: $otherSymptoms"),
          ],
        ),
        IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.orange,
            ),
            onPressed: () {
              //edit function --> show new window and update
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Edit pain log"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [Text("Option 1"), Text("Option 2")],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Close"))
                      ],
                    );
                  });
            })
      ]),
      //SizedBox(height: size.height * 0.01),
    );
  }
}

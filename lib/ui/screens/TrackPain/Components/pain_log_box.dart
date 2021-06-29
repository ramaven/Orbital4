import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_register_auth/ui/screens/TrackPain/Components/pain_model.dart';
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
  final GlobalKey<FormState> formkey;

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
    this.formkey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pain = Pain();

    Size size = MediaQuery.of(context).size;
    String _painDropDownValue;

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
            onPressed: () async {
              //edit function --> show new window and update

              DocumentSnapshot curLogData = await curUser.usersCol
                  .document(curUser.uid)
                  .collection("painLogs")
                  .document(logID)
                  .get();

              _painDropDownValue = curLogData["bodyPart"];

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Edit pain log"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            child: Builder(
                              builder: (context) => Form(
                                key: formkey,
                                child: SingleChildScrollView(
                                  child: Column(children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "Body Part: ${curLogData['bodyPart']}"),
                                        ]),
                                    SizedBox(height: size.height * 0.04),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: size.width * 0.15,
                                          child: TextFormField(
                                            initialValue:
                                                '${curLogData.data['day']}',
                                            decoration: InputDecoration(
                                                labelText: 'Day'),
                                            validator: (value) {
                                              if (int.parse(value) <= 0 ||
                                                  int.parse(value) > 31) {
                                                String msg = 'Invalid';
                                                return msg;
                                              }
                                              // return "ok";
                                            },
                                            onSaved:
                                                // (val) => curLogData.data
                                                // .update(
                                                //     'day', (value) => value)
                                                (val) =>
                                                    _pain.day = int.parse(val),

                                            //setState(() => _pain.day = int.parse(val))
                                          ),
                                        ),
                                        Container(
                                          width: size.width * 0.15,
                                          child: TextFormField(
                                            initialValue:
                                                '${curLogData.data['month']}',
                                            decoration: InputDecoration(
                                                labelText: 'Month'),
                                            validator: (value) {
                                              if (int.parse(value) <= 0 ||
                                                  int.parse(value) > 12) {
                                                String msg = 'Invalid';
                                                return msg;
                                              }
                                              // return "ok";
                                            },
                                            onSaved:
                                                // (val) => curLogData.data
                                                // .update(
                                                //     'month', (value) => value)
                                                (val) => _pain.month =
                                                    int.parse(val),
                                            //setState(() => _pain.day = int.parse(val))
                                          ),
                                        ),
                                        Container(
                                          width: size.width * 0.20,
                                          child: TextFormField(
                                            initialValue:
                                                '${curLogData.data['year']}',
                                            decoration: InputDecoration(
                                                labelText: 'Year'),
                                            validator: (value) {
                                              if (int.parse(value) <= 1990 ||
                                                  int.parse(value) >
                                                      DateTime.now().year) {
                                                String msg = 'Invalid';
                                                return msg;
                                              }
                                              // return "ok";
                                            },
                                            onSaved:
                                                // (val) => curLogData.data
                                                // .update(
                                                //     'year', (value) => value),
                                                (val) =>
                                                    _pain.year = int.parse(val),
                                            //setState(() => _pain.day = int.parse(val))
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Container(
                                    //   width: size.width * 0.3,
                                    //   child: DropdownButton(
                                    //     hint: Text(
                                    //       _painDropDownValue,
                                    //       style: TextStyle(
                                    //           color: Colors.blue,
                                    //           fontWeight: FontWeight.bold),
                                    //     ),
                                    //     isExpanded: true,
                                    //     iconSize: 30.0,
                                    //     style: TextStyle(color: Colors.blue),
                                    //     items: [
                                    //       'Head',
                                    //       'Neck',
                                    //       'Shoulder',
                                    //       'Arm',
                                    //       'Elbow',
                                    //       'Wrist',
                                    //       'Fingers',
                                    //       'Chest',
                                    //       'Stomach',
                                    //       'Waist',
                                    //       'Hips',
                                    //       'Back',
                                    //       'Butt',
                                    //       'Thigh',
                                    //       'Knee',
                                    //       'Shin',
                                    //       'Calf',
                                    //       'Ankle',
                                    //       'Foot',
                                    //     ].map(
                                    //       (val) {
                                    //         return DropdownMenuItem<String>(
                                    //           value: val,
                                    //           child: Text(
                                    //             val,
                                    //           ),
                                    //         );
                                    //       },
                                    //     ).toList(),
                                    //     onChanged: (val) async {
                                    //       _painDropDownValue = val;
                                    //       _pain.areaOnBodyPart = val;
                                    //       curLogData.data.update(
                                    //           'bodyPart', (value) => value);
                                    //       // setState(
                                    //       //       () {
                                    //       //     _painAreaDropDownValue = val;
                                    //       //     _pain.areaOnBodyPart = val;
                                    //       //   },
                                    //       // );
                                    //     },
                                    //   ),
                                    // ),
                                    SizedBox(height: size.height * 0.01),
                                    Container(
                                      width: size.width * 0.40,
                                      child: TextFormField(
                                        initialValue:
                                            '${curLogData.data['painLevel'].round()}',
                                        decoration: InputDecoration(
                                            labelText: 'Pain Level (1-10)'),
                                        validator: (value) {
                                          if (int.parse(value) < 0 ||
                                              int.parse(value) > 10) {
                                            String msg = 'Invalid';
                                            return msg;
                                          }
                                          // return "ok";
                                        },
                                        onSaved:
                                            // (val) => curLogData.data
                                            // .update('painLevel',
                                            //     (value) => double.parse(value))
                                            (val) => _pain.painLevel =
                                                double.parse(val),
                                        //setState(() => _pain.day = int.parse(val))
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    Container(
                                      width: size.width * 0.40,
                                      child: TextFormField(
                                        initialValue:
                                            '${curLogData.data['painDuration']}',
                                        decoration: InputDecoration(
                                            labelText: 'Pain Duration'),
                                        validator: (value) {
                                          if (int.parse(value) < 0) {
                                            String msg = 'Invalid';
                                            return msg;
                                          }
                                          // return "ok";
                                        },
                                        onSaved:

                                            // (val) => curLogData.data
                                            // .update('painDuration',
                                            //     (value) => int.parse(value))
                                            (val) => _pain.painDuration =
                                                int.parse(val),
                                        //setState(() => _pain.day = int.parse(val))
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.02),
                                    TextFormField(
                                      initialValue:
                                          '${curLogData.data['otherSymptoms']}',
                                      decoration: InputDecoration(
                                          labelText: 'Other symptoms'),
                                      onSaved:
                                          //(val) =>
                                          //setState(() => _pain.otherSymptoms = val)
                                          // (val) => curLogData.data.update(
                                          //     'otherSymptoms',
                                          //     (value) => value)
                                          (val) => _pain.otherSymptoms = val,
                                    ),
                                    SizedBox(height: size.height * 0.02),
                                    TextFormField(
                                      initialValue:
                                          '${curLogData.data['medications']}',
                                      decoration: InputDecoration(
                                          labelText: 'Medications'),
                                      onSaved:

                                          // (val) => (val) => curLogData.data
                                          // .update(
                                          //     'medications', (value) => value)
                                          (val) => _pain.medication = val,
                                    ),
                                    SizedBox(height: size.height * 0.02),
                                  ]), //column
                                ),
                              ),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    final form = formkey.currentState;
                                    if (form.validate()) {
                                      form.save();

                                      await curUser.usersCol
                                          .document(curUser.uid)
                                          .collection("painLogs")
                                          .document(logID)
                                          .updateData({
                                            //'bodyPart': _pain.bodyPart,
                                            //'areaOnBodyPart': _painAreaDropDownValue,
                                            'painLevel': _pain.painLevel,
                                            'painDuration': _pain.painDuration,
                                            'otherSymptoms':
                                                _pain.otherSymptoms,
                                            'medications': _pain.medication,
                                            'day': _pain.day,
                                            'month': _pain.month,
                                            'year': _pain.year,
                                          })
                                          .then((value) => print(
                                              "Updated Pain log ID ${logID}"))
                                          .catchError((error) =>
                                              print(error.toString()));

                                      // Fluttertoast.showToast(
                                      //   msg: "Pain log updated",
                                      //   toastLength: Toast.LENGTH_SHORT,
                                      //   gravity: ToastGravity.BOTTOM,
                                      //   timeInSecForIos: 3,
                                      //   backgroundColor: Colors.black,
                                      //   textColor: Colors.white,
                                      // );

                                      // Scaffold.of(context).showSnackBar(
                                      //     SnackBar(
                                      //         content:
                                      //             Text('Updated pain log')));

                                      //_pain.save();
                                      // final FirebaseUser curUser =
                                      // await auth.currentUser();
                                      //
                                      // await usersCol
                                      //     .document(curUser.uid)
                                      //     .collection("painLogs")
                                      //     .add({
                                      //   'bodyPart': _painDropDownValue,
                                      //   'areaOnBodyPart': _painAreaDropDownValue,
                                      //   'painLevel': _pain.painLevel,
                                      //   'painDuration': _pain.painDuration,
                                      //   'otherSymptoms': _pain.otherSymptoms,
                                      //   'medications': _pain.medication,
                                      //   'day': _pain.day,
                                      //   'month': _pain.month,
                                      //   'year': _pain.year,
                                      // })
                                      //     .then((value) => print("New pain log added"))
                                      //     .catchError(
                                      //         (error) => print(error.toString()));
                                      //
                                      // _showDialog(context);
                                      // print(_painDropDownValue);
                                    }
                                  },
                                  child: Text('Save'))),
                        ],
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

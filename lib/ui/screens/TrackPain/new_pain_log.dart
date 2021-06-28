import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Components/pain_model.dart';

class NewPainLogScreen extends StatefulWidget {
  const NewPainLogScreen({Key key}) : super(key: key);
  static const routeName = '/newpainlogscreen';
  @override
  _NewPainLogScreenState createState() => _NewPainLogScreenState();
}

class _NewPainLogScreenState extends State<NewPainLogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pain = Pain();
  String _painDropDownValue;
  String _painAreaDropDownValue;

  CollectionReference usersCol = Firestore.instance.collection("users");
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("New Pain Entry"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('home');
            }),
        // actions: [
        //   IconButton(
        //       icon: Icon(Icons.save_outlined),
        //       onPressed: () {
        //         // write code to send the details to the firebase
        //         // database and save it there/ update
        //       })
        // ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                      width: size.width * 0.2,
                      child: TextFormField(
                          initialValue: '${_pain.day}',
                          decoration: InputDecoration(labelText: 'Day'),
                          validator: (value) {
                            if (int.parse(value) <= 0 ||
                                int.parse(value) > 31) {
                              String msg = 'Invalid';
                              return msg;
                            }
                            // return "ok";
                          },
                          onSaved: (val) =>
                              setState(() => _pain.day = int.parse(val))),
                    ),
                    Container(
                      width: size.width * 0.2,
                      child: TextFormField(
                          initialValue: '${_pain.month}',
                          decoration: InputDecoration(labelText: 'Month'),
                          validator: (value) {
                            if (int.parse(value) <= 0 ||
                                int.parse(value) > 12) {
                              String msg = 'Invalid';
                              return msg;
                            }
                            // return "ok";
                          },
                          onSaved: (val) =>
                              setState(() => _pain.month = int.parse(val))),
                    ),
                    Container(
                      width: size.width * 0.2,
                      child: TextFormField(
                          initialValue: '${_pain.year}',
                          decoration: InputDecoration(labelText: 'Year'),
                          validator: (value) {
                            if (int.parse(value) < 1950 ||
                                int.parse(value) > DateTime.now().year) {
                              String msg = 'Invalid';
                              return msg;
                            }
                            // return "ok";
                          },
                          onSaved: (val) =>
                              setState(() => _pain.year = int.parse(val))),
                    ),
                  ]),

                  SizedBox(height: size.height * 0.02),

                  // choose body part
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Body Part:",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        // SizedBox(
                        //   width: size.width * 0.05,
                        // ),
                        Container(
                          width: size.width * 0.5,
                          child: DropdownButton(
                            hint: _painDropDownValue == null
                                ? Text('Select your pain area')
                                : Text(
                                    _painDropDownValue,
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: TextStyle(color: Colors.blue),
                            items: [
                              'Head',
                              'Neck',
                              'Shoulder',
                              'Upper arm',
                              'Elbow',
                              'Lower arm',
                              'Hand',
                              'Wrist',
                              'Fingers',
                              'Chest',
                              'Stomach',
                              'Waist',
                              'Hips',
                              'Upper back',
                              'Mid back',
                              'Lower back',
                              'Butt',
                              'Upper thigh',
                              'Lower thigh',
                              'Knee',
                              'Shin',
                              'Calf',
                              'Ankle',
                              'Foot',
                            ].map(
                              (val) {
                                _pain.bodyPart = val;
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(
                                    val,
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  _painDropDownValue = val;
                                },
                              );
                            },
                          ),
                        ),
                      ]),

                  SizedBox(height: size.height * 0.02),

                  // //3d model
                  // Container(
                  //   height: size.height * 0.04,
                  // ),
                  // Text(
                  //   "Pain area: ${_pain.bodyPart}",
                  //   style: TextStyle(
                  //       color: Colors.black, fontWeight: FontWeight.bold),
                  // ),
                  // TextFormField(
                  //     decoration:
                  //         InputDecoration(labelText: 'Pain area eg. Left arm'),
                  //     // validator: (value) {
                  //     //   if (value.isEmpty) {
                  //     //     String msg = 'Pls enter symptoms';
                  //     //     return msg;
                  //     //   }
                  //     //   //return "ok";
                  //     // },
                  //     onChanged: (val) {
                  //       _pain.bodyPart = val;
                  //     },
                  //     onSaved: (val) => setState(() => _pain.bodyPart = val)),
                  // choose body part
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Pain area:",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        // SizedBox(
                        //   width: size.width * 0.05,
                        // ),
                        Container(
                          width: size.width * 0.5,
                          child: DropdownButton(
                            hint: _painAreaDropDownValue == null
                                ? Text('Select your pain area')
                                : Text(
                                    _painAreaDropDownValue,
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: TextStyle(color: Colors.blue),
                            items: [
                              'Left',
                              'Right',
                              'Top',
                              'Bottom',
                              'Middle',
                              'Whole body part'
                            ].map(
                              (val) {
                                _pain.areaOnBodyPart = val;
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(
                                    val,
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  _painAreaDropDownValue = val;
                                },
                              );
                            },
                          ),
                        ),
                      ]),
                  SizedBox(height: size.height * 0.02),

                  //Slider to choose pain level
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.local_hospital_rounded, size: 40),
                        Expanded(
                            child: Slider(
                          min: 0,
                          max: 10,
                          divisions: 10,
                          value: _pain.painLevel,
                          onChanged: (value) {
                            setState(() {
                              _pain.painLevel = value;
                            });
                          },
                          label: 'Pain level',
                          activeColor: (_pain.painLevel <= 3)
                              ? Colors.yellow
                              : (_pain.painLevel <= 6)
                                  ? Colors.orange
                                  : Colors.red,
                          inactiveColor: Colors.grey,
                        ))
                      ]),
                  Text(
                    "Pain level: ${_pain.painLevel}",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.02),

                  //Enter pain duration
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Duration of pain (minutes)'),
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     String msg = 'Pls enter symptoms';
                      //     return msg;
                      //   }
                      //   //return "ok";
                      // },
                      onSaved: (val) =>
                          setState(() => _pain.painDuration = int.parse(val))),
                  SizedBox(height: size.height * 0.02),

                  // Enter other symptoms
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Other symptoms eg. nausea, dizziness'),
                      onSaved: (val) =>
                          setState(() => _pain.otherSymptoms = val)),
                  SizedBox(height: size.height * 0.02),

                  // Enter medications
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Medications taken eg. Aspirin'),
                      onSaved: (val) =>
                          setState(() => _pain.otherSymptoms = val)),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            final form = _formKey.currentState;
                            if (form.validate()) {
                              form.save();
                              //_pain.save();
                              final FirebaseUser curUser =
                                  await auth.currentUser();

                              await usersCol
                                  .document(curUser.uid)
                                  .collection("painLogs")
                                  .add({
                                    'bodyPart': _pain.bodyPart,
                                    'areaOnBodyPart': _pain.areaOnBodyPart,
                                    'painLevel': _pain.painLevel,
                                    'painDuration': _pain.painDuration,
                                    'otherSymptoms': _pain.otherSymptoms,
                                    'medications': _pain.medication,
                                    'day': _pain.day,
                                    'month': _pain.month,
                                    'year': _pain.year,
                                  })
                                  .then((value) => print("New pain log added"))
                                  .catchError(
                                      (error) => print(error.toString()));

                              _showDialog(context);
                            }
                          },
                          child: Text('Save'))),
                ]),
              ) //column

              ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Saved new entry')));
  }
}

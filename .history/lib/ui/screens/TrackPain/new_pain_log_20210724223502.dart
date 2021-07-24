import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:direct_select/direct_select.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:searchfield/searchfield.dart';
import 'Components/medicine_list.dart' as med;
import 'Components/symptom_list.dart' as symptom;

import 'Components/pain_model.dart';
import 'dart:async';
import 'package:intl/intl.dart';

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
  String _durationTypeDropDownValue;

  DateTime currentDate = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  CollectionReference usersCol = Firestore.instance.collection("users");
  final FirebaseAuth auth = FirebaseAuth.instance;

  final _items =
      symptom.list.map((symp) => MultiSelectItem<String>(symp, symp)).toList();
  List<dynamic> _selectedSymptoms = [];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        print(pickedDate);
      });
  }

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
                    Col(
                      Text(formatter.format(currentDate).toString()),
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Select date'),
                      ),
                    )
                    // Input day
                    // Container(
                    //   width: size.width * 0.2,
                    //   child: TextFormField(
                    //       keyboardType: TextInputType.number,
                    //       initialValue: '${_pain.day}',
                    //       decoration: InputDecoration(labelText: 'Day'),
                    //       validator: (value) {
                    //         if (int.parse(value) <= 0 ||
                    //             int.parse(value) > 31) {
                    //           String msg = 'Invalid';
                    //           return msg;
                    //         }
                    //         // return "ok";
                    //       },
                    //       onSaved: (val) =>
                    //           setState(() => _pain.day = int.parse(val))),
                    // ),
                    // Input month
                    // Container(
                    //   width: size.width * 0.2,
                    //   child: TextFormField(
                    //       keyboardType: TextInputType.number,
                    //       initialValue: '${_pain.month}',
                    //       decoration: InputDecoration(labelText: 'Month'),
                    //       validator: (value) {
                    //         if (int.parse(value) <= 0 ||
                    //             int.parse(value) > 12) {
                    //           String msg = 'Invalid';
                    //           return msg;
                    //         }
                    //         // return "ok";
                    //       },
                    //       onSaved: (val) =>
                    //           setState(() => _pain.month = int.parse(val))),
                    // ),
                    // Input year
                    // Container(
                    //   width: size.width * 0.2,
                    //   child: TextFormField(
                    //       keyboardType: TextInputType.number,
                    //       initialValue: '${_pain.year}',
                    //       decoration: InputDecoration(labelText: 'Year'),
                    //       validator: (value) {
                    //         if (int.parse(value) < 1950 ||
                    //             int.parse(value) > DateTime.now().year) {
                    //           String msg = 'Invalid';
                    //           return msg;
                    //         }
                    //         // return "ok";
                    //       },
                    //       onSaved: (val) =>
                    //           setState(() => _pain.year = int.parse(val))),
                    // ),
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
                                ? Text('Select body part')
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
                              'Arm',
                              'Elbow',
                              'Wrist',
                              'Fingers',
                              'Chest',
                              'Stomach',
                              'Waist',
                              'Hips',
                              'Back',
                              'Butt',
                              'Thigh',
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
                                  _pain.bodyPart = val;
                                },
                              );
                              print(val);
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
                                ? Text('Select specific pain area')
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
                                  _pain.areaOnBodyPart = val;
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
                          min: 1,
                          max: 10,
                          divisions: 9,
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: size.width * 0.4,
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration:
                                  InputDecoration(labelText: 'Duration'),
                              // validator: (value) {
                              //   if (value.isEmpty) {
                              //     String msg = 'Pls enter symptoms';
                              //     return msg;
                              //   }
                              //   //return "ok";
                              // },
                              onSaved: (val) => setState(
                                  () => _pain.painDuration = int.parse(val))),
                        ),
                        Container(
                          width: size.width * 0.4,
                          child: DropdownButton(
                            hint: _durationTypeDropDownValue == null
                                ? Text('Duration type')
                                : Text(
                                    _durationTypeDropDownValue,
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: TextStyle(color: Colors.blue),
                            items: ['seconds', 'minutes', 'hours'].map(
                              (val) {
                                _pain.durationType = val;
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
                                  _durationTypeDropDownValue = val;
                                  _pain.durationType = val;
                                },
                              );
                              print(val);
                            },
                          ),
                        ),
                      ]),
                  SizedBox(height: size.height * 0.02),

                  // Enter medications
                  // TextFormField(
                  //     decoration: InputDecoration(
                  //         labelText: 'Medications taken eg. Aspirin'),
                  //     onSaved: (val) => setState(() => _pain.medication = val)),
                  SearchField(
                    hint: 'Medications',
                    suggestions: med.list,
                    validator: (x) {
                      if (!med.list.contains(x) || x.isEmpty) {
                        return 'Please Enter a valid State';
                      }
                      return null;
                    },
                    searchInputDecoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    maxSuggestionsInViewPort: 6,
                    itemHeight: 50,
                    onTap: (x) {
                      print(x);
                      setState(() {
                        _pain.medication = x;
                      });
                    },
                  ),

                  SizedBox(height: size.height * 0.02),

                  // Enter other symptoms

                  // TextFormField(
                  //     decoration: InputDecoration(
                  //         labelText: 'Other symptoms eg. nausea, dizziness'),
                  //     onSaved: (val) =>
                  //         setState(() => _pain.otherSymptoms = val)),

                  Container(
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[50].withOpacity(0.4),
                      //color: Theme.of(context).primaryColor.withOpacity(.4),
                      border: Border.all(
                        color: Colors.grey[200],
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Column(
                      children: <Widget>[
                        MultiSelectBottomSheetField(
                          initialChildSize: 0.4,
                          listType: MultiSelectListType.CHIP,
                          searchable: true,
                          buttonText: Text("Other Symptoms"),
                          title: Text("Symptoms"),
                          items: _items,
                          onConfirm: (values) {
                            _selectedSymptoms = values;
                            setState(() {
                              _pain.otherSymptoms = values.toString();
                            });
                          },
                          chipDisplay: MultiSelectChipDisplay(
                            onTap: (value) {
                              setState(() {
                                _selectedSymptoms.remove(value);
                              });
                            },
                          ),
                        ),
                        (_selectedSymptoms == null || _selectedSymptoms.isEmpty)
                            ? Container(
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "None selected",
                                  style: TextStyle(color: Colors.black54),
                                ))
                            : Container(),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.02),

                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            final form = _formKey.currentState;
                            if (form.validate() && _painDropDownValue != null) {
                              form.save();
                              //_pain.save();
                              final FirebaseUser curUser =
                                  await auth.currentUser();

                              await usersCol
                                  .document(curUser.uid)
                                  .collection("painLogs")
                                  .add({
                                    'bodyPart': _painDropDownValue,
                                    'areaOnBodyPart': _painAreaDropDownValue,
                                    'painLevel': _pain.painLevel,
                                    'painDuration': _pain.painDuration,
                                    'durationType': _durationTypeDropDownValue,
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
                              print(_painDropDownValue);
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

class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: FittedBox(
          child: Text(
        title,
      )),
    );
  }
}

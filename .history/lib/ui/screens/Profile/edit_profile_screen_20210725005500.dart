import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_register_auth/ui/screens/Profile/profile_screen.dart';
import 'package:search_widget/search_widget.dart';
import 'Components/profile_model.dart';
// import 'track_pain_screen.dart';

import 'package:login_register_auth/ui/screens/Dashboard/nav_dashboard_screen.dart';
import 'package:login_register_auth/ui/screens/Profile/profile_field.dart';
import 'package:login_register_auth/ui/screens/Settings/account_settings_option.dart';
import 'package:login_register_auth/ui/screens/Settings/notification_settings_option.dart';

import '../../../services/auth.dart';

import 'package:login_register_auth/globals.dart' as globals;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key key}) : super(key: key);
  //const ProfileScreen({Key key}) : super(key: key);
  static const routeName = '/editprofile';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  //final _profile = Profile();
  final _profile = globals.Userprofile;
  String _dropDownValue = globals.Userprofile.gender;
  AuthBase authBase = AuthBase();

  CollectionReference usersCol = Firestore.instance.collection("users");
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //_profile.get();
    // final edit = ValueNotifier<int>(0);

    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        centerTitle: true,
        backgroundColor: Colors.orange,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              //Navigator.pop(context);
              Navigator.of(context)
                  .pushReplacementNamed(ProfileScreen.routeName);
              // Navigator.of(context)
              //     .pushReplacementNamed(DashboardScreen.routeName);
              // find how to go back to dashboard screen instead of pushing
              // another screen onto navigator stack
            }),
        // actions: [
        //   IconButton(
        //       icon: Icon(Icons.edit),
        //       onPressed: () {
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
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.orange),
                    SizedBox(width: 10),
                    Text("Personal Information",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))
                  ],
                ),
                Divider(
                  height: size.height * 0.03,
                  thickness: 1,
                ),

                // First name
                TextFormField(
                    decoration: InputDecoration(
                        labelText: 'First Name: ${_profile.firstName}'),
                    initialValue: '${_profile.firstName}',
                    validator: (value) {
                      if (value.isEmpty) {
                        String msg = 'Pls enter your first name';
                        return msg;
                      }
                    },
                    onSaved: (val) => setState(() => _profile.firstName = val)),
                SizedBox(height: size.height * 0.02),

                // Last name
                TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Last Name: ${_profile.lastName}'),
                    initialValue: '${_profile.lastName}',
                    validator: (value) {
                      if (value.isEmpty) {
                        String msg = 'Pls enter your last name';
                        return msg;
                      }
                    },
                    onSaved: (val) => setState(() => _profile.lastName = val)),
                SizedBox(height: size.height * 0.02),
                // // Username: Cannot change
                // TextFormField(
                //     enabled: false,
                //     decoration: InputDecoration(
                //       labelText: "${_profile.username}",
                //     )),
                // SizedBox(height: size.height * 0.02),

                // Email: Cannot change
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Email: ",
                  ),
                  initialValue: '${_profile.email}',
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // DATE OF BIRTH
                      // START: DATE VALIDATION DAY-MONTH-YEAR
                      Text("Date of birth:"),
                      // SizedBox(
                      //   width: size.width * 0.02,
                      // ),
                      Container(
                        width: size.width * 0.2,
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue: '${_profile.day}',
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
                                setState(() => _profile.day = int.parse(val))),
                      ),
                      Container(
                        width: size.width * 0.2,
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue: '${_profile.month}',
                            decoration: InputDecoration(labelText: 'Month'),
                            validator: (value) {
                              if (int.parse(value) <= 0 ||
                                  int.parse(value) > 12) {
                                String msg = 'Invalid';
                                return msg;
                              }
                              // return "ok";
                            },
                            onSaved: (val) => setState(
                                () => _profile.month = int.parse(val))),
                      ),
                      Container(
                        width: size.width * 0.2,
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue: '${_profile.year}',
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
                                setState(() => _profile.year = int.parse(val))),
                      ),
                    ]),
                // END: DATE VALIDATION DAY-MONTH-YEAR
                //SizedBox(height: size.height * 0.02),

                // Gender

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Gender:"),
                      // SizedBox(
                      //   width: size.width * 0.05,
                      // ),
                      Container(
                        width: size.width * 0.6,
                        child: DropdownButton(
                          hint: _dropDownValue == null
                              ? Text('Select your gender')
                              : Text(
                                  _dropDownValue,
                                  style: TextStyle(color: Colors.blue),
                                ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: Colors.blue),
                          items: ['Female', 'Male', 'Others'].map(
                            (val) {
                              //_profile.gender = val;
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                _dropDownValue = val;
                                _profile.gender = val;
                              },
                            );
                            print(val);
                            print(_profile.gender);
                            print(_dropDownValue);
                          },
                        ),
                      ),
                    ]),

                SizedBox(height: size.height * 0.02),
                Row(
                  children: [
                    Icon(Icons.healing, color: Colors.orange),
                    SizedBox(width: 10),
                    Text("Medical Information",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                Divider(
                  height: size.height * 0.04,
                  thickness: 1,
                ),
                // Height
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Height'),
                    initialValue: '${_profile.height}',
                    validator: (value) {
                      if (value.isEmpty) {
                        String msg = 'Pls enter your height';
                        return msg;
                      }
                    },
                    onSaved: (val) =>
                        setState(() => _profile.height = int.parse(val))),
                SizedBox(height: size.height * 0.02),

                // Weight
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Weight (kg)'),
                    initialValue: '${_profile.weight}',
                    validator: (value) {
                      if (value.isEmpty) {
                        String msg = 'Pls enter your weight';
                        return msg;
                      }
                    },
                    onSaved: (val) =>
                        setState(() => _profile.weight = int.parse(val))),
                SizedBox(height: size.height * 0.02),

                // Existing Conditions
                TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Existing Conditions'),
                    initialValue: '${_profile.existingConditions}',
                    validator: (value) {
                      // Since user may not have exisitng condi
                      // if (value.isEmpty) {
                      //   String msg = 'Pls enter ';
                      //   return msg;
                      // }
                    },
                    onSaved: (val) =>
                        setState(() => _profile.existingConditions = val)),
                SizedBox(height: size.height * 0.02),

                // Drug Allergies
                TextFormField(
                    decoration: InputDecoration(labelText: 'Drug Allergies'),
                    initialValue: '${_profile.drugAllergies}',
                    // validator: (value) {
                    //   // Since user may not have exisitng allergies
                    //   // if (value.isEmpty) {
                    //   //   String msg = 'Pls enter ';
                    //   //   return msg;
                    //   // }
                    // },
                    onSaved: (val) =>
                        setState(() => _profile.drugAllergies = val)),
                SizedBox(height: size.height * 0.02),

                // Family Meidcal History
                TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Family Medical History'),
                    initialValue: '${_profile.familyMedicalHistory}',
                    // validator: (value) {
                    //   // Since user may not have Family Medical History
                    //   // if (value.isEmpty) {
                    //   //   String msg = 'Pls enter ';
                    //   //   return msg;
                    //   // }
                    // },
                    onSaved: (val) =>
                        setState(() => _profile.familyMedicalHistory = val)),
                SizedBox(height: size.height * 0.02),

                // SUBMITTING FORM
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          final form = _formKey.currentState;
                          if (form.validate()) {
                            form.save();
                            // _profile.save();
                            final FirebaseUser curUser =
                                await auth.currentUser();

                            usersCol
                                .document(curUser.uid)
                                .get()
                                .then((docSnapshot) => {
                                      if (docSnapshot.exists)
                                        {
                                          usersCol
                                              .document(curUser.uid)
                                              .setData({
                                                'firstName': _profile.firstName,
                                                'lastName': _profile.lastName,
                                                //'username': _profile.username,
                                                'email': _profile.email,
                                                'dayOfBirth': _profile.day,
                                                'monthOfBirth': _profile.month,
                                                'yearOfBirth': _profile.year,
                                                'gender': _profile.gender,
                                                'height': _profile.height,
                                                'weight': _profile.weight,
                                                'existingConditions':
                                                    _profile.existingConditions,
                                                'drugAllergies':
                                                    _profile.drugAllergies,
                                                'familyMedicalHistory': _profile
                                                    .familyMedicalHistory,
                                              }, merge: true)
                                              .then((value) =>
                                                  print("Profile info updated"))
                                              .catchError((error) =>
                                                  print(error.toString()))
                                        }
                                      else
                                        {
                                          usersCol
                                              .document(curUser.uid)
                                              .setData({
                                                'firstName': _profile.firstName,
                                                'lastName': _profile.lastName,
                                                //'username': _profile.username,
                                                'email': _profile.email,
                                                'dayOfBirth': _profile.day,
                                                'monthOfBirth': _profile.month,
                                                'yearOfBirth': _profile.year,
                                                'gender': _profile.gender,
                                                'height': _profile.height,
                                                'weight': _profile.weight,
                                                'existingConditions':
                                                    _profile.existingConditions,
                                                'drugAllergies':
                                                    _profile.drugAllergies,
                                                'familyMedicalHistory': _profile
                                                    .familyMedicalHistory,
                                                'savedClinics':
                                                    genSavedClinicsString(),
                                                'savedNews':
                                                    "00000000000000000000",
                                              })
                                              .then((value) =>
                                                  print("Profile info updated"))
                                              .catchError((error) =>
                                                  print(error.toString()))
                                        }
                                    });

                            Navigator.of(context).pop;
                            _showDialog(context);
                          }
                        },
                        child: Text('Save'))),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Saved profile')));
  }

  String genSavedClinicsString() {
    String savedClinics = "";

    for (int i = 0; i < 1166; i++) {
      savedClinics = savedClinics + "0";
    }
    return savedClinics;
  }
}

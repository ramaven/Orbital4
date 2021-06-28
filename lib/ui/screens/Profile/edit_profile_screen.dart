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
  String _dropDownValue;
  AuthBase authBase = AuthBase();

  CollectionReference usersCol = Firestore.instance.collection("users");
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _profile.get();
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
                // Username: Cannot change
                TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: "${_profile.username}",
                    )),
                SizedBox(height: size.height * 0.02),

                // Email: Cannot change
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email: ${_profile.email}",
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
                              _profile.gender = val;
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
                              },
                            );
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
                    decoration: InputDecoration(labelText: 'Weight'),
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
                    enabled: false,
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

                            await usersCol
                                .document(curUser.uid)
                                .updateData({
                                  'firstName': _profile.firstName,
                                  'lastName': _profile.lastName,
                                  'username': _profile.username,
                                  'email': _profile.email,
                                  'dayOfBirth': _profile.day,
                                  'monthOfBirth': _profile.month,
                                  'yearOfBirth': _profile.year,
                                  'gender': _profile.gender,
                                  'height': _profile.height,
                                  'weight': _profile.weight,
                                  'existingConditions':
                                      _profile.existingConditions,
                                  'drugAllergies': _profile.drugAllergies,
                                  'familyMedicalHistory':
                                      _profile.familyMedicalHistory,
                                })
                                .then((value) => print("New pain log added"))
                                .catchError((error) => print(error.toString()));
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
}
// THIS IS THE ORIGINAL PROFILE SCREEN FOR REFERENCE
// import 'package:flutter/material.dart';
// import 'package:login_register_auth/ui/screens/Dashboard/nav_dashboard_screen.dart';
// import 'package:login_register_auth/ui/screens/Profile/profile_field.dart';
// import 'package:login_register_auth/ui/screens/Settings/account_settings_option.dart';
// import 'package:login_register_auth/ui/screens/Settings/notification_settings_option.dart';

// import '../../../services/auth.dart';

// class ProfileScreen extends StatefulWidget {
//   //const ProfileScreen({Key key}) : super(key: key);
//   static const routeName = '/profile';

//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   //UserModel currentUser = locator.get<UserProfileController>().currentUser;
//   AuthBase authBase = AuthBase();

//   bool valNotify1 = true;
//   bool valNotify2 = true;
//   bool valNotify3 = false;

//   onChangeFunction1(bool newVal) {
//     setState(() {
//       valNotify1 = newVal;
//     });
//   }

//   onChangeFunction2(bool newVal) {
//     setState(() {
//       valNotify2 = newVal;
//     });
//   }

//   onChangeFunction3(bool newVal) {
//     setState(() {
//       valNotify2 = newVal;
//     });
//   }

//   // File _image;
//   // ImagePicker imagePicker;
//   // void initState() {
//   //   super.initState();
//   //   imagePicker = ImagePicker();
//   // }
//   //
//   // Future<void> chooseImageFromGallery() async {
//   //   PickedFile pickedFile =
//   //       await imagePicker.getImage(source: ImageSource.gallery);
//   //   setState(() {
//   //     _image = File(pickedFile.path);
//   //   });
//   // }
//   //
//   // Future<void> captureImageFromCamera() async {
//   //   PickedFile pickedFile =
//   //       await imagePicker.getImage(source: ImageSource.camera);
//   //   setState(() {
//   //     _image = File(pickedFile.path);
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My Profile"),
//         centerTitle: true,
//         backgroundColor: Colors.orange,
//         leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               //Navigator.pop(context);
//               Navigator.of(context).pushReplacementNamed('home');
//               // Navigator.of(context)
//               //     .pushReplacementNamed(DashboardScreen.routeName);
//               // find how to go back to dashboard screen instead of pushing
//               // another screen onto navigator stack
//             }),
//         actions: [
//           IconButton(
//               icon: Icon(Icons.save_outlined),
//               onPressed: () {
//                 // write code to send the details to the firebase
//                 // database and save it there/ update
//               })
//         ],
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(10),
//         child: ListView(
//           children: [
//             Column(
//               children: [
//                 // _image != null
//                 //     ? ClipOval(
//                 //         clipper: RoundClipper(), child: Image.file(_image))
//                 //     : Icon(Icons.person_pin, size: 100),
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.center,
//                 //   children: [
//                 //     IconButton(
//                 //         icon: Icon(Icons.photo_library),
//                 //         onPressed: () {
//                 //           chooseImageFromGallery();
//                 //         }),
//                 //     IconButton(
//                 //         icon: Icon(Icons.add_a_photo),
//                 //         onPressed: () {
//                 //           captureImageFromCamera();
//                 //         }),
//                 //   ],
//                 // ),
//                 Icon(Icons.person_pin, size: 100),
//               ],
//             ),
//             SizedBox(height: size.height * 0.04),
//             Row(
//               children: [
//                 Icon(Icons.person, color: Colors.orange),
//                 SizedBox(width: 10),
//                 Text("Personal Information",
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
//               ],
//             ),
//             Divider(
//               height: size.height * 0.03,
//               thickness: 1,
//             ),
//             ProfileField(label: "Username", value: "default"),
//             //value: "${currentUser?.username ?? "Johnny appleseed"}"),
//             AccountSettingsOption(label: "Full name"),
//             AccountSettingsOption(label: "Email"),
//             AccountSettingsOption(
//               label: "Date of birth",
//             ),
//             AccountSettingsOption(label: "Gender"),
//             AccountSettingsOption(label: "Citizenship"),
//             SizedBox(height: size.height * 0.04),
//             Row(
//               children: [
//                 Icon(Icons.healing, color: Colors.orange),
//                 SizedBox(width: 10),
//                 Text("Medical Information",
//                     style:
//                         TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//               ],
//             ),
//             Divider(
//               height: size.height * 0.04,
//               thickness: 1,
//             ),
//             NotificationSettingsOption(
//                 label: "Height (metres)",
//                 value: valNotify1,
//                 onChangeMethod: onChangeFunction1),
//             NotificationSettingsOption(
//                 label: "Weight (kg)",
//                 value: valNotify2,
//                 onChangeMethod: onChangeFunction2),
//             NotificationSettingsOption(
//                 label: "Pre-existing conditions",
//                 value: valNotify3,
//                 onChangeMethod: onChangeFunction3),
//             NotificationSettingsOption(
//                 label: "Drug allergies",
//                 value: valNotify3,
//                 onChangeMethod: onChangeFunction3),
//             NotificationSettingsOption(
//                 label: "Family medical history",
//                 value: valNotify3,
//                 onChangeMethod: onChangeFunction3),
//             Row(),
//             SizedBox(height: size.height * 0.05),
//             Center(
//               child: OutlinedButton(
//                 style: OutlinedButton.styleFrom(
//                     backgroundColor: Colors.orange.shade100,
//                     padding: const EdgeInsets.symmetric(horizontal: 40),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20))),
//                 onPressed: () async {
//                   await authBase.logout();
//                   Navigator.of(context).pushReplacementNamed('login');
//                 },
//                 child: Text(
//                   "SIGN OUT",
//                   style: TextStyle(
//                       fontSize: 16, letterSpacing: 2.2, color: Colors.black),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//       // body: Padding(
//       //   padding: const EdgeInsets.all(12.0),
//       //   child: SafeArea(
//       //     child: Text("settings"),
//       //   ),
//       // ),
//     );
//   }
// }

// // implementing a clipper class to clip our profile pic into a circle
// class RoundClipper extends CustomClipper<Rect> {
//   Rect getClip(Size size) {
//     return Rect.fromLTWH(110, 50, 150, 150);
//   }

//   bool shouldReclip(oldClipper) {
//     return true;
//   }
// }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:login_register_auth/ui/screens/Dashboard/nav_dashboard_screen.dart';
// import 'package:login_register_auth/ui/screens/Profile/profile_field.dart';
// import 'package:login_register_auth/ui/screens/Settings/account_settings_option.dart';
// import 'package:login_register_auth/ui/screens/Settings/notification_settings_option.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:login_register_auth/globals.dart' as globals;
//
// import '../../../services/auth.dart';
//
// class ProfileScreen extends StatefulWidget {
//   //const ProfileScreen({Key key}) : super(key: key);
//   static const routeName = '/profile';
//
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   //UserModel currentUser = locator.get<UserProfileController>().currentUser;
//
//   CollectionReference usersCol = Firestore.instance.collection("users");
//   final FirebaseAuth auth = FirebaseAuth.instance;
//
//   AuthBase authBase = AuthBase();
//
//   bool valNotify1 = true;
//   bool valNotify2 = true;
//   bool valNotify3 = false;
//
//   onChangeFunction1(bool newVal) {
//     setState(() {
//       valNotify1 = newVal;
//     });
//   }
//
//   onChangeFunction2(bool newVal) {
//     setState(() {
//       valNotify2 = newVal;
//     });
//   }
//
//   onChangeFunction3(bool newVal) {
//     setState(() {
//       valNotify2 = newVal;
//     });
//   }
//
//   // File _image;
//   // ImagePicker imagePicker;
//   // void initState() {
//   //   super.initState();
//   //   imagePicker = ImagePicker();
//   // }
//   //
//   // Future<void> chooseImageFromGallery() async {
//   //   PickedFile pickedFile =
//   //       await imagePicker.getImage(source: ImageSource.gallery);
//   //   setState(() {
//   //     _image = File(pickedFile.path);
//   //   });
//   // }
//   //
//   // Future<void> captureImageFromCamera() async {
//   //   PickedFile pickedFile =
//   //       await imagePicker.getImage(source: ImageSource.camera);
//   //   setState(() {
//   //     _image = File(pickedFile.path);
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My Profile"),
//         centerTitle: true,
//         backgroundColor: Colors.orange,
//         leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               //Navigator.pop(context);
//               Navigator.of(context).pushReplacementNamed('home');
//               // Navigator.of(context)
//               //     .pushReplacementNamed(DashboardScreen.routeName);
//               // find how to go back to dashboard screen instead of pushing
//               // another screen onto navigator stack
//             }),
//         actions: [
//           IconButton(
//               icon: Icon(Icons.save_outlined),
//               onPressed: () {
//                 // write code to send the details to the firebase
//                 // database and save it there/ update
//               })
//         ],
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(10),
//         child: ListView(
//           children: [
//             Column(
//               children: [
//                 // _image != null
//                 //     ? ClipOval(
//                 //         clipper: RoundClipper(), child: Image.file(_image))
//                 //     : Icon(Icons.person_pin, size: 100),
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.center,
//                 //   children: [
//                 //     IconButton(
//                 //         icon: Icon(Icons.photo_library),
//                 //         onPressed: () {
//                 //           chooseImageFromGallery();
//                 //         }),
//                 //     IconButton(
//                 //         icon: Icon(Icons.add_a_photo),
//                 //         onPressed: () {
//                 //           captureImageFromCamera();
//                 //         }),
//                 //   ],
//                 // ),
//                 Icon(Icons.person_pin, size: 100),
//               ],
//             ),
//             SizedBox(height: size.height * 0.04),
//             Row(
//               children: [
//                 Icon(Icons.person, color: Colors.orange),
//                 SizedBox(width: 10),
//                 Text("Personal Information",
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
//               ],
//             ),
//             Divider(
//               height: size.height * 0.03,
//               thickness: 1,
//             ),
//             ProfileField(label: "Username", value: "default"),
//             // ElevatedButton(
//             //   onPressed: () async {
//             //     final FirebaseUser curUser = await auth.currentUser();
//             //
//             //     await usersCol
//             //         .document(curUser.uid)
//             //         .updateData({'firstName': '8979687296'})
//             //         .then((value) => print("name updated"))
//             //         .catchError((error) => print(error.toString()));
//             //   },
//             // ),
//             //value: "${currentUser?.username ?? "Johnny appleseed"}"),
//             AccountSettingsOption(label: "Full name"),
//             AccountSettingsOption(label: "Email"),
//             AccountSettingsOption(
//               label: "Date of birth",
//             ),
//             AccountSettingsOption(label: "Gender"),
//             AccountSettingsOption(label: "Citizenship"),
//             SizedBox(height: size.height * 0.04),
//             Row(
//               children: [
//                 Icon(Icons.healing, color: Colors.orange),
//                 SizedBox(width: 10),
//                 Text("Medical Information",
//                     style:
//                         TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//               ],
//             ),
//             Divider(
//               height: size.height * 0.04,
//               thickness: 1,
//             ),
//             NotificationSettingsOption(
//                 label: "Height (metres)",
//                 value: valNotify1,
//                 onChangeMethod: onChangeFunction1),
//             NotificationSettingsOption(
//                 label: "Weight (kg)",
//                 value: valNotify2,
//                 onChangeMethod: onChangeFunction2),
//             NotificationSettingsOption(
//                 label: "Pre-existing conditions",
//                 value: valNotify3,
//                 onChangeMethod: onChangeFunction3),
//             NotificationSettingsOption(
//                 label: "Drug allergies",
//                 value: valNotify3,
//                 onChangeMethod: onChangeFunction3),
//             NotificationSettingsOption(
//                 label: "Family medical history",
//                 value: valNotify3,
//                 onChangeMethod: onChangeFunction3),
//             Row(),
//             SizedBox(height: size.height * 0.05),
//             Center(
//               child: OutlinedButton(
//                 style: OutlinedButton.styleFrom(
//                     backgroundColor: Colors.orange.shade100,
//                     padding: const EdgeInsets.symmetric(horizontal: 40),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20))),
//                 onPressed: () async {
//                   await authBase.logout();
//                   Navigator.of(context).pushReplacementNamed('login');
//                 },
//                 child: Text(
//                   "SIGN OUT",
//                   style: TextStyle(
//                       fontSize: 16, letterSpacing: 2.2, color: Colors.black),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//       // body: Padding(
//       //   padding: const EdgeInsets.all(12.0),
//       //   child: SafeArea(
//       //     child: Text("settings"),
//       //   ),
//       // ),
//     );
//   }
// }
//
// // implementing a clipper class to clip our profile pic into a circle
// class RoundClipper extends CustomClipper<Rect> {
//   Rect getClip(Size size) {
//     return Rect.fromLTWH(110, 50, 150, 150);
//   }MaterialStateOutlinedBorder
//
//   bool shouldReclip(oldClipper) {
//     return true;
//   }
// }

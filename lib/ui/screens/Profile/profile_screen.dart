import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_register_auth/ui/screens/Profile/edit_profile_screen.dart';
import 'package:search_widget/search_widget.dart';
import 'Components/profile_model.dart';
// import 'track_pain_screen.dart';

import 'package:login_register_auth/ui/screens/Dashboard/nav_dashboard_screen.dart';
import 'package:login_register_auth/ui/screens/Profile/profile_field.dart';
import 'package:login_register_auth/ui/screens/Settings/account_settings_option.dart';
import 'package:login_register_auth/ui/screens/Settings/notification_settings_option.dart';
import '../../../services/auth.dart';

import 'package:login_register_auth/globals.dart' as globals;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);
  //const ProfileScreen({Key key}) : super(key: key);
  static const routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String _dropDownValue;
  AuthBase authBase = AuthBase();

  var _profile;

  @override
  void initState() {
    setState(() {
      _profile = Profile();
    });
  }

  CollectionReference usersCol = Firestore.instance.collection("users");
  final FirebaseAuth auth = FirebaseAuth.instance;
  //final edit = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _profile.get().then((response) {
      setState(() {
        globals.Userprofile = _profile;
      });
    });
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
              Navigator.of(context).pushReplacementNamed('home');
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(
                              EditProfileScreen.routeName);
                        },
                        child: Text("Edit Profile"))
                  ],
                ),
                SizedBox(height: size.height * 0.02),

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
                ProfileField(
                    label: 'First Name:', value: '${_profile.firstName}'),
                SizedBox(height: size.height * 0.02),

                // Last name
                ProfileField(
                    label: 'Last Name:', value: '${_profile.lastName}'),

                SizedBox(height: size.height * 0.02),
                // Username: Cannot change
                //ProfileField(label: 'Username:', value: '${_profile.username}'),

                //SizedBox(height: size.height * 0.02),

                // Email: Cannot change
                ProfileField(label: 'Email:', value: " ${_profile.email}"),

                SizedBox(height: size.height * 0.02),
                ProfileField(
                    label: 'Date of Birth (d/m/y)',
                    value:
                        '${_profile.day} / ${_profile.month} / ${_profile.year}'),
                SizedBox(height: size.height * 0.02),

                // END: DATE VALIDATION DAY-MONTH-YEAR
                //SizedBox(height: size.height * 0.02),

                // Gender
                ProfileField(label: 'Gender:', value: '${_profile.gender}'),

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
                ProfileField(
                    label: 'Height(cm) :', value: '${_profile.height}'),

                SizedBox(height: size.height * 0.02),

                // Weight
                ProfileField(
                    label: 'Weight(kg) :', value: '${_profile.weight}'),

                SizedBox(height: size.height * 0.02),

                // Existing Conditions
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Existing Medical Conditions",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600]),
                        ),
                      ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_profile.existingConditions}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ]),
                ),

                SizedBox(height: size.height * 0.02),

                // Drug Allergies
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Drug Allergies",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600]),
                        ),
                      ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_profile.drugAllergies}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ]),
                ),
                SizedBox(height: size.height * 0.02),

                // Family Meidcal History
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Family Medical History",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600]),
                        ),
                      ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_profile.familyMedicalHistory}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ]),
                ),
                SizedBox(height: size.height * 0.02),

                // Center(
                //   child: OutlinedButton(
                //     style: OutlinedButton.styleFrom(
                //         backgroundColor: Colors.orange.shade100,
                //         padding: const EdgeInsets.symmetric(horizontal: 40),
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(20))),
                //     onPressed: () async {
                //       await authBase.logout();
                //       Navigator.of(context).pushReplacementNamed('login');
                //     },
                //     child: Text(
                //       "SIGN OUT",
                //       style: TextStyle(
                //           fontSize: 16,
                //           letterSpacing: 2.2,
                //           color: Colors.black),
                //     ),
                //   ),
                // ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }
}

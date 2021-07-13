import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_register_auth/ui/screens/Settings/account_settings_option.dart';
import 'package:login_register_auth/ui/screens/Settings/notification_settings_option.dart';
import 'package:login_register_auth/globals.dart' as globals;

import '../../../services/auth.dart';

class SettingsScreen extends StatefulWidget {
  //const SettingsScreen({Key key}) : super(key: key);
  static const routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AuthBase authBase = AuthBase();
  CollectionReference usersCol = Firestore.instance.collection("users");
  String password;

  bool valNotify1 = true;
  // bool valNotify2 = true;
  // bool valNotify3 = false;

  onChangeFunction1(bool newVal) {
    setState(() {
      valNotify1 = newVal;
    });
  }
  //
  // onChangeFunction2(bool newVal) {
  //   setState(() {
  //     valNotify2 = newVal;
  //   });
  // }
  //
  // onChangeFunction3(bool newVal) {
  //   setState(() {
  //     valNotify2 = newVal;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    globals.Userprofile.get();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
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
        actions: [
          // IconButton(
          //     icon: Icon(Icons.save_outlined),
          //     onPressed: () {
          //       // write code to send the details to the firebase
          //       // database and save it there/ update
          //     })
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            //Text("To be completed by 1st August"),
            SizedBox(height: size.height * 0.04),
            Row(
              children: [
                Icon(Icons.person, color: Colors.orange),
                SizedBox(width: 10),
                Text("Account",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
            Divider(
              height: size.height * 0.03,
              thickness: 1,
            ),
            //change password
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Change Password'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Send password reset instructions?"),
                            TextButton(
                              child: Text("Yes"),
                              onPressed: () {
                                FirebaseAuth.instance.sendPasswordResetEmail(
                                    email: globals.Userprofile.email);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Password Reset'),
                                        content: Text(
                                            'Please check your email inbox for instructions to reset your password.'),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('OK'))
                                        ],
                                      );
                                    });
                              },
                            )
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Back"))
                        ],
                      );
                    });
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Change Password',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.grey[600])),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),

            // delete entire account
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('DELETE ACCOUNT'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                                "Are you sure you want to delete your account?"),
                            SizedBox(height: size.height * 0.04),
                            Text(
                              "This will delete all your data and is irreversible.",
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(height: size.height * 0.04),
                            ElevatedButton(
                              child: Text("Yes"),
                              onPressed: () {
                                // usersCol
                                //     .document(globals.Userprofile.uid)
                                //     .delete()
                                //     .then((x) => print("Deleted pain log data"))
                                //     .catchError((error) => {
                                //           showError(error.toString(), context),
                                //           print("Failed to delete data: $error")
                                //         });
                                //
                                // AuthCredential credentials =
                                //     EmailAuthProvider.getCredential(
                                //         email: email, password: password);
                                //
                                // FirebaseUser user = await globals
                                //     .Userprofile.auth
                                //     .currentUser();
                                // await user.delete();

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('DELETE ACCOUNT'),
                                        content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('Enter your password'),
                                              SizedBox(
                                                  height: size.height * 0.02),
                                              SizedBox(
                                                width: 200,
                                                height: 50,
                                                child: TextField(
                                                  obscureText: true,
                                                  onChanged: (val) {
                                                    password = val;
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                  height: size.height * 0.04),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  try {
                                                    usersCol
                                                        .document(globals
                                                            .Userprofile.uid)
                                                        .delete()
                                                        .then((x) => print(
                                                            "Deleted user's data"))
                                                        .catchError((error) => {
                                                              showError(
                                                                  error
                                                                      .toString(),
                                                                  context),
                                                              print(
                                                                  "Failed to delete user's data: $error")
                                                            });

                                                    AuthCredential credentials =
                                                        EmailAuthProvider
                                                            .getCredential(
                                                                email: globals
                                                                    .Userprofile
                                                                    .email,
                                                                password:
                                                                    password);
                                                    print('gkhfkghfgsgs');
                                                    FirebaseUser user =
                                                        await FirebaseAuth
                                                            .instance
                                                            .currentUser();
                                                    AuthResult result = await user
                                                        .reauthenticateWithCredential(
                                                            credentials);
                                                    FirebaseUser curUser =
                                                        result.user;

                                                    await curUser.delete().then(
                                                        (value) => Navigator.of(
                                                                context)
                                                            .pushNamed(
                                                                'login'));
                                                    // .catchError((err) =>
                                                    // showError(
                                                    //     err.toString(),
                                                    //     context));
                                                  } on PlatformException catch (e) {
                                                    showError(
                                                        'Incorrect password.',
                                                        context);
                                                  }
                                                  // if (curUser != null) {

                                                  // Navigator.of(context)
                                                  //     .pushNamed('login');
                                                  // } else {
                                                  //   showError(
                                                  //       "Incorrect passwprd",
                                                  //       context);
                                                  // }
                                                },
                                                child: Text('DELETE ACCOUNT'),
                                              ),
                                            ]),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Back'))
                                        ],
                                      );
                                    });

                                // showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return AlertDialog(
                                //         title: Text('Account deleted'),
                                //         content: Text(
                                //             'Your account has been successfully deleted.'),
                                //         actions: <Widget>[
                                //           TextButton(
                                //               onPressed: () {
                                //                 Navigator.of(context).pop();
                                //                 Navigator.of(context).pop();
                                //                 Navigator.of(context)
                                //                     .pushNamed('login');
                                //               },
                                //               child: Text('OK'))
                                //         ],
                                //       );
                                //     });
                              },
                            )
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Back"))
                        ],
                      );
                    });
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delete Account',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.grey[600])),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),

            // AccountSettingsOption(label: "Change password"),
            // AccountSettingsOption(label: "Content settings"),
            // AccountSettingsOption(label: "Social"),
            // AccountSettingsOption(
            //   label: "Language",
            // ),
            //AccountSettingsOption(label: "Privacy and Security"),
            SizedBox(height: size.height * 0.04),
            Row(
              children: [
                Icon(Icons.volume_up_rounded, color: Colors.orange),
                SizedBox(width: 10),
                Text("Notifications",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
            Divider(
              height: size.height * 0.04,
              thickness: 1,
            ),
            NotificationSettingsOption(
                label: "Allow notifications",
                value: valNotify1,
                onChangeMethod: onChangeFunction1),
            // NotificationSettingsOption(
            //     label: "Theme Dark",
            //     value: valNotify2,
            //     onChangeMethod: onChangeFunction2),
            // NotificationSettingsOption(
            //     label: "Account Active",
            //     value: valNotify3,
            //     onChangeMethod: onChangeFunction3),
            SizedBox(height: size.height * 0.05),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.orange.shade100,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () async {
                  await authBase.logout();
                  Navigator.of(context).pushReplacementNamed('login');
                },
                child: Text(
                  "SIGN OUT",
                  style: TextStyle(
                      fontSize: 16, letterSpacing: 2.2, color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(12.0),
      //   child: SafeArea(
      //     child: Text("settings"),
      //   ),
      // ),
    );
  }

  showError(String errormessage, BuildContext context) {
    print(errormessage.toString() + 'jhdtkjhtrskjlghsr');
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }
}

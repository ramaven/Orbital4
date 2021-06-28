import 'package:flutter/material.dart';
import 'package:login_register_auth/ui/screens/Settings/account_settings_option.dart';
import 'package:login_register_auth/ui/screens/Settings/notification_settings_option.dart';

import '../../../services/auth.dart';

class SettingsScreen extends StatefulWidget {
  //const SettingsScreen({Key key}) : super(key: key);
  static const routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AuthBase authBase = AuthBase();

  bool valNotify1 = true;
  bool valNotify2 = true;
  bool valNotify3 = false;

  onChangeFunction1(bool newVal) {
    setState(() {
      valNotify1 = newVal;
    });
  }

  onChangeFunction2(bool newVal) {
    setState(() {
      valNotify2 = newVal;
    });
  }

  onChangeFunction3(bool newVal) {
    setState(() {
      valNotify2 = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          IconButton(
              icon: Icon(Icons.save_outlined),
              onPressed: () {
                // write code to send the details to the firebase
                // database and save it there/ update
              })
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
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
            AccountSettingsOption(label: "Change password"),
            AccountSettingsOption(label: "Content settings"),
            AccountSettingsOption(label: "Social"),
            AccountSettingsOption(
              label: "Language",
            ),
            AccountSettingsOption(label: "Privacy and Security"),
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
            NotificationSettingsOption(
                label: "Theme Dark",
                value: valNotify2,
                onChangeMethod: onChangeFunction2),
            NotificationSettingsOption(
                label: "Account Active",
                value: valNotify3,
                onChangeMethod: onChangeFunction3),
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
}

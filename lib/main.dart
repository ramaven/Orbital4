import 'package:flutter/material.dart';
import 'package:login_register_auth/ui/change_pass_screen.dart';
import 'package:login_register_auth/ui/screens/Dashboard/nav_dashboard_screen.dart';
import 'package:login_register_auth/ui/screens/Profile/edit_profile_screen.dart';
import 'package:login_register_auth/ui/screens/Profile/profile_screen.dart';
import 'package:login_register_auth/ui/screens/Settings/settings_screen.dart';
import 'package:login_register_auth/ui/screens/TrackPain/new_pain_log.dart';
import 'package:login_register_auth/ui/screens/TrackPain/track_pain_screen.dart';
import 'package:login_register_auth/ui/screens/auth_screen.dart';
import 'package:login_register_auth/ui/screens/home_screen.dart';
import 'package:login_register_auth/ui/screens/intro_screen.dart';

import 'ui/screens/TrackPain/all_pain_logs.dart';

import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final FirebaseApp
  //
  final Future<FirebaseApp> _initialization = FirebaseApp.configure(
      name: 'HealthTgt',
      options: FirebaseOptions(
        googleAppID: '1:483005309611:ios:3a403aad7479377e6c8dee',
        gcmSenderID: '483005309611',
        apiKey: 'AIzaSyAUxLsCTQ919GVlWq4FfwUFyf_R_-4_cDc',
      ));
  //Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
              home: Scaffold(
            body: Center(child: Text("Error")),
          ));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Health Together',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Color(0xfff2f9fe),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[200]),
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[200]),
                  borderRadius: BorderRadius.circular(25),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[200]),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            home: IntroScreen(),
            routes: {
              'intro': (context) => IntroScreen(),
              'home': (context) => DashboardScreen(),
              'login': (context) => AuthScreen(authType: AuthType.login),
              'register': (context) => AuthScreen(authType: AuthType.register),
              'changePassword': (context) => ChangePassScreen(),
              //TrackPainBackground.routeName: (ctx) => TrackPainBackground(),
              SettingsScreen.routeName: (ctx) => SettingsScreen(),
              ProfileScreen.routeName: (ctx) => ProfileScreen(),
              EditProfileScreen.routeName: (ctx) => EditProfileScreen(),
              AllPainLogs.routeName: (ctx) => AllPainLogs(),
              NewPainLogScreen.routeName: (ctx) => NewPainLogScreen(),
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

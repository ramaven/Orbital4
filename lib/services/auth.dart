import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:login_register_auth/globals.dart' as globals;

class User {
  final String uid;

  User({@required this.uid});
}

class AuthBase {
  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Future<void> registerWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      final authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (authResult != null) {
        await authResult.user.sendEmailVerification();
        await FirebaseAuth.instance.signOut();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Account created!'),
                content: Text('Please verify your email before logging in.'),
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
      // CollectionReference usersCol = Firestore.instance.collection('users');
      // var userUID = authResult.user.uid;
      // usersCol.document(userUID).setData({
      //   'uid': userUID,
      // });

      return _userFromFirebase(authResult.user);
    } catch (e) {
      print(e.toString());
      showError("Email already in use", context);
      return;
    }
  }

  // Future<void> loginWithEmailAndPassword(String email, String password) async {
  //   try {
  //     final authResult = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //     return _userFromFirebase(authResult.user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  Future<bool> loginWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      final authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        if (authResult.user.isEmailVerified == false) {
          showError("Please verify your email.", context);
        } else {
          globals.curUserUid = authResult.user.uid;
          Navigator.of(context).pushReplacementNamed('home');
        }
      }
    } on PlatformException catch (e) {
      print(e.toString());
      showError("Invalid email or password", context);

      return false;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}

//
showError(String errormessage, BuildContext context) {
  showDialog(
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

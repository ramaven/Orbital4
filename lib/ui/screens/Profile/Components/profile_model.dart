import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile {
  CollectionReference usersCol = Firestore.instance.collection("users");
  final FirebaseAuth auth = FirebaseAuth.instance;

  //List of pain logs
  List<Map<String, dynamic>> painLogs;

  // Profile details
  String username = 'NIL';
  String email = 'NIL';
  String firstName = 'NIL';
  String lastName = 'NIL';

  //Date of birth
  int day = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  String gender = 'NIL';
  String citizenship = 'NIL';

  int height = 0;
  int weight = 0;
  String existingConditions = 'NIL';
  String drugAllergies = 'NIL';
  String familyMedicalHistory = 'NIL';

  get() async {
    final FirebaseUser curUser = await auth.currentUser();
    Map<String, dynamic> userProfileInfo;

    usersCol
        .document(curUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists');
        userProfileInfo = documentSnapshot.data;

        firstName = userProfileInfo['firstName'];
        lastName = userProfileInfo['lastName'];
        username = userProfileInfo['username'];
        email = userProfileInfo['email'];
        day = userProfileInfo['dayOfBirth'];
        month = userProfileInfo['monthOfBirth'];
        year = userProfileInfo['yearOfBirth'];
        gender = userProfileInfo['gender'];
        height = userProfileInfo['height'];
        weight = userProfileInfo['weight'];
        existingConditions = userProfileInfo['existingConditions'];
        drugAllergies = userProfileInfo['drugAllergies'];
        familyMedicalHistory = userProfileInfo['familyMedicalHistory'];
      } else {
        print('Document does not exist on the database');
      }
    });

    Map<String, dynamic> APainLog;
    List<DocumentSnapshot> allPainLogsDocuments;
    List<Map<String, dynamic>> allPainLogsList = [];

    CollectionReference usersPainLogs =
        usersCol.document(curUser.uid).collection("painLogs");
    QuerySnapshot querySnapshot = await usersPainLogs.getDocuments();

    allPainLogsDocuments = querySnapshot.documents;

    for (var i = 0; i < allPainLogsDocuments.length; i++) {
      DocumentSnapshot curDocument = allPainLogsDocuments[i];
      Map<String, dynamic> curPainLog = curDocument.data;
      allPainLogsList.add(curPainLog);
    }

    painLogs = allPainLogsList;
  }

  // getPainLogs() async {
  //   final FirebaseUser curUser = await auth.currentUser();
  //   Map<String, dynamic> APainLog;
  //   List<DocumentSnapshot> allPainLogsDocuments;
  //   List<Map<String, dynamic>> allPainLogsList = [];
  //
  //   CollectionReference usersPainLogs =
  //       usersCol.document(curUser.uid).collection("painLogs");
  //   QuerySnapshot querySnapshot = await usersPainLogs.getDocuments();
  //
  //   allPainLogsDocuments = querySnapshot.documents;
  //
  //   for (var i = 0; i < allPainLogsDocuments.length; i++) {
  //     DocumentSnapshot curDocument = allPainLogsDocuments[i];
  //     Map<String, dynamic> curPainLog = curDocument.data;
  //     allPainLogsList.add(curPainLog);
  //   }
  //
  //   painLogs = allPainLogsList;
  // }
}

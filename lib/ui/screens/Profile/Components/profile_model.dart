import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile {
  CollectionReference usersCol = Firestore.instance.collection("users");
  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid;

  //List of pain logs
  List<Map<String, dynamic>> painLogs;
  List<String> painLogsIds;

  String savedClinics;
  String savedNews;

  // Profile details
  //String username = 'NIL';
  String email;
  String firstName = 'NIL';
  String lastName = 'NIL';

  //Date of birth
  int day = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  String gender = null;
  String citizenship = 'NIL';

  int height = 0;
  int weight = 0;
  String existingConditions = 'NIL';
  String drugAllergies = 'NIL';
  String familyMedicalHistory = 'NIL';

  get() async {
    final FirebaseUser curUser = await auth.currentUser();
    Map<String, dynamic> userProfileInfo;

    uid = curUser.uid;
    email = curUser.email;

    usersCol
        .document(curUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists');
        userProfileInfo = documentSnapshot.data;

        firstName = userProfileInfo['firstName'];
        lastName = userProfileInfo['lastName'];
        //username = userProfileInfo['username'];
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
        savedClinics = userProfileInfo['savedClinics'];
        savedNews = userProfileInfo['savedNews'];
      } else {
        print('Document does not exist on the database');
        usersCol.document(curUser.uid).setData({
          'savedClinics': genSavedClinicsString(),
          'firstName': firstName,
          'lastName': lastName,
          //'username': _profile.username,
          'email': email,
          'dayOfBirth': day,
          'monthOfBirth': month,
          'yearOfBirth': year,
          'gender': gender,
          'height': height,
          'weight': weight,
          'existingConditions': existingConditions,
          'drugAllergies': drugAllergies,
          'familyMedicalHistory': familyMedicalHistory,
        }, merge: true);
      }
    });

    Map<String, dynamic> APainLog;
    List<DocumentSnapshot> allPainLogsDocuments;
    List<Map<String, dynamic>> allPainLogsList = [];
    List<String> painLogIDsList = [];

    CollectionReference usersPainLogs =
        usersCol.document(curUser.uid).collection("painLogs");
    QuerySnapshot querySnapshot = await usersPainLogs.getDocuments();

    allPainLogsDocuments = querySnapshot.documents;

    for (var i = 0; i < allPainLogsDocuments.length; i++) {
      DocumentSnapshot curDocument = allPainLogsDocuments[i];
      painLogIDsList.add(curDocument.documentID);
      Map<String, dynamic> curPainLog = curDocument.data;
      allPainLogsList.add(curPainLog);
    }

    painLogs = allPainLogsList;
    painLogsIds = painLogIDsList;
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

String genSavedClinicsString() {
  String savedClinics = "";

  for (int i = 0; i < 1166; i++) {
    savedClinics = savedClinics + "0";
  }
  return savedClinics;
}

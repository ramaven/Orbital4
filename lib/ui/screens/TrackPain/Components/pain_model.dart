import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Pain {
  CollectionReference usersCol = Firestore.instance.collection("users");
  final FirebaseAuth auth = FirebaseAuth.instance;

  //Date of entry
  int day = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  //Description of pain
  String bodyPart = 'NIL';
  String areaOnBodyPart = 'NIL';
  double painLevel = 1;
  int painDuration = 0;
  String otherSymptoms = 'NIL';
  String medication = 'NIL';

  // save() {
  //   print('Saving new pain entry');
  // }

}

import 'package:flutter/material.dart';
import 'package:search_widget/search_widget.dart';
import 'Components/pain_log_box.dart';
import 'track_pain_screen.dart';
import 'package:login_register_auth/globals.dart' as globals;

class AllPainLogs extends StatefulWidget {
  const AllPainLogs({Key key}) : super(key: key);
  static const routeName = '/allpainlogs';

  @override
  _AllPainLogsState createState() => _AllPainLogsState();
}

class _AllPainLogsState extends State<AllPainLogs> {
  List<Map<String, dynamic>> painLogs;

  @override
  void initState() {
    setState(() {
      painLogs = globals.Userprofile.painLogs;
    });
  }

  @override
  Widget build(BuildContext context) {
    //refresh pain log data from firestore

    globals.Userprofile.get().then((response) {
      setState(() {
        painLogs = globals.Userprofile.painLogs;
      });
    });

    return Scaffold(
        appBar: AppBar(
          title: Text("All Pain Logs"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('home');
              }),
          // actions: [
          //   IconButton(
          //       icon: Icon(Icons.save_outlined),
          //       onPressed: () {
          //         // write code to send the details to the firebase
          //         // database and save it there/ update
          //       })
          // ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(children: createPainLogBoxes(painLogs)
              //     [
              //   PainLogBox(
              //       date: "01/06/2021",
              //       bodyPart: "Eyes",
              //       painLevel: 5,
              //       duration: 35,
              //       otherSymptoms: "NIL",
              //       medicine: "Aspirin"),
              //   PainLogBox(
              //       date: "01/06/2021",
              //       bodyPart: "Eyes",
              //       painLevel: 5,
              //       duration: 35,
              //       otherSymptoms: "NIL",
              //       medicine: "Aspirin"),
              //   PainLogBox(
              //       date: "01/06/2021",
              //       bodyPart: "Eyes",
              //       painLevel: 5,
              //       duration: 35,
              //       otherSymptoms: "NIL",
              //       medicine: "Aspirin")
              // ]
              ),
        ));
  }

  List<PainLogBox> createPainLogBoxes(
      List<Map<String, dynamic>> painLogsFirebase) {
    List<PainLogBox> finalList = [];
    for (int i = 0; i < painLogsFirebase.length; i++) {
      Map<String, dynamic> curLog = painLogsFirebase[i];
      double day = curLog['day'];
      double month = curLog['month'];
      double year = curLog['year'];
      String date = '$day/$month/$year';
      String bodyPart = curLog['bodyPart'];
      double painLevel = curLog['painLevel'];
      int painDuration = curLog['painDuration'];
      String otherSymptoms = curLog['otherSymptoms'];
      String medications = curLog['medications'];

      finalList.add(new PainLogBox(
        date: date,
        bodyPart: bodyPart,
        painLevel: painLevel.round(),
        duration: painDuration.round(),
        otherSymptoms: otherSymptoms,
        medicine: medications,
      ));
    }
    return finalList;
  }
}

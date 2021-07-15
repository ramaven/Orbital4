import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:login_register_auth/globals.dart' as globals;
import 'dart:collection';

import '../../../constants.dart';

class PainLevel extends StatefulWidget {
  const PainLevel({Key key}) : super(key: key);
  // static const routeName = '/allpainlogs';

  @override
  _PainLevelState createState() => _PainLevelState();
}

class _PainLevelState extends State<PainLevel> {
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
    Size size = MediaQuery.of(context).size;

    globals.Userprofile.get().then((response) {
      setState(() {
        painLogs = globals.Userprofile.painLogs;
      });
    });
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        //color: Colors.black,
        //color:
        color: Colors.white,
        //Color(0xFFA8E4EC),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(children: [
        Container(
          // padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Text(" Pain Level Distribution",
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        // padding: new EdgeInsets.all(10.0),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          //color: Colors.black,
          color: Colors.white,
          //Color(0xFFA8E4EC),
          elevation: 0,
          child: Stack(
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 35,
                    // startDegreeOffset: -90,
                    // List<PieChartSectionData> paiChartSelectionDatas
                    // createPieChartSectionData(painLogs) returns list of ^
                    sections: createPieChartSectionData(painLogs),
                  ),
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

// START OF METHOD TO GET DATA
  List<PieChartSectionData> createPieChartSectionData(
      List<Map<String, dynamic>> painLogsFirebase) {
    int lowCount = 0;
    int medCount = 0;
    int highCount = 0;

    // Update counter for all pain logs using occurrences of body parts
    for (int i = 0; i < painLogsFirebase.length; i++) {
      print(painLogsFirebase.length);
      Map<String, dynamic> curLog = painLogsFirebase[i];
      print(i);

      // Retrieve body part from firestore
      double painLevel = curLog['painLevel'];
      if (painLevel.compareTo(4.0) == -1) {
        lowCount += 1;
      }
      // Medium
      else if (painLevel.compareTo(8) == -1) {
        medCount += 1;
      }
      // Low
      else {
        highCount += 1;
      }
    }
    // Total number of pain logs
    int totalLogs = painLogsFirebase.length;

    //var colorArr = [Colors.yellow[400], Colors.orange[300], Colors.red[300]];
    var colorArr = [Colors.green[200], Colors.yellow[400], Colors.red[300]];

    var value = [lowCount, medCount, highCount];
    print(value);

    var title = ['Low', 'Medium', 'High'];

    List<PieChartSectionData> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(PieChartSectionData(
          title: title[i],
          titleStyle: TextStyle(
              color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
          value: (value[i] * 100 / totalLogs).toDouble(),
          color: colorArr[i]));
    }
    return list;
  }
}

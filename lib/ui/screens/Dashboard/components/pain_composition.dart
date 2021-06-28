import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:login_register_auth/globals.dart' as globals;
import 'dart:collection';

import '../../../constants.dart';

class PainComposition extends StatefulWidget {
  const PainComposition({Key key}) : super(key: key);
  // static const routeName = '/allpainlogs';

  @override
  _PainCompositionState createState() => _PainCompositionState();
}

class _PainCompositionState extends State<PainComposition> {
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
    return Column(children: [
      Container(
        // padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Text(" Pain Composition",
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      // padding: new EdgeInsets.all(10.0),
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color(0xFFA8E4EC),
        elevation: 8,
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
    ]);
  }

// START OF METHOD TO GET DATA
  List<PieChartSectionData> createPieChartSectionData(
      List<Map<String, dynamic>> painLogsFirebase) {
    // Create HashMap Key:bodyPart, Value:counter
    HashMap map = new HashMap<String, int>();

    //Map<String, int> map = new HashMap<String, int>();

    List<String> bodyPartArr = [
      'Head',
      'Neck',
      'Shoulder',
      'Arm',
      'Elbow',
      'Wrist',
      'Fingers',
      'Chest',
      'Stomach',
      'Waist',
      'Hips',
      'Back',
      'Butt',
      'Thigh',
      'Knee',
      'Shin',
      'Calf',
      'Ankle',
      'Foot'
    ];

    // Initialise all counters to 0
    for (int i = 0; i < bodyPartArr.length; i++) {
      String curPart = bodyPartArr[i];
      map[bodyPartArr[i]] = 0;
      //map[curPart] = 0;
    }
    // print(painLogsFirebase.length);
    // Update counter for all pain logs using occurrences of body parts
    for (int i = 0; i < painLogsFirebase.length; i++) {
      Map<String, dynamic> curLog = painLogsFirebase[i];

      // Retrieve body part from firestore
      String bodyPart = curLog['bodyPart'];
      //print("line 215" + bodyPart);

      // Retrieve the current counter, then add 1
      int newCounter = 0;
      newCounter = map[bodyPart] + 1;

      // Update
      map[bodyPart] = newCounter;
    }

    // Count total number of occurences (add all values)
    var counters = map.values;
    int counterSum = 0;
    //var counterSum = counters.reduce((sum, element) => sum + element);
    for (int k = 0; k < counters.length; k++) {
      counterSum += counters.elementAt(k);
    }

    // Method to Calculate percentage
    // double calculatePercentage(int currBodyPart, int totalBodyPart) {
    //   return (currBodyPart.toDouble()) / (totalBodyPart.toDouble());
    // }
    int calculatePercentage(int currBodyPart, int totalBodyPart) {
      return ((currBodyPart) * 100 / (totalBodyPart)).round();
    }

    // Replaces int values (num of occurences) with percentages
    for (int i = 0; i < bodyPartArr.length; i++) {
      // Num of occurences of curr body part
      int currCounter = map[bodyPartArr[i]];
      // Update with percentage
      map[bodyPartArr[i]] = calculatePercentage(currCounter, counterSum);
    }

    // Method to Sort map based on values/percentages
    LinkedHashMap sortListMap(HashMap map) {
      List mapKeys = map.keys.toList(growable: false);
      mapKeys.sort((k1, k2) => map[k2] - map[k1]);
      LinkedHashMap resMap = new LinkedHashMap();
      mapKeys.forEach((k1) {
        resMap[k1] = map[k1];
      });
      return resMap;
    }

    LinkedHashMap sortedMap = sortListMap(map);

    // The 5 colours to use in the pie chart
    var colorArr = [
      Colors.pinkAccent,
      Color(0xFF26E5FF), // Blue
      Color(0xFFFFCF26), // Yellow
      Color(0xFFEE2727), // Red
      Colors.green
    ];

    // Convert map to list, and add colour in for only the top 5 frequency.
    int x = 0;
    List<PieChartSectionData> list = [];
    sortedMap.forEach((bodyPart, frequency) => {
          if (x < 5)
            {
              list.add(PieChartSectionData(
                  title: bodyPart,
                  value: frequency.toDouble(),
                  color: colorArr[x])),
              x++
            }
        });
    //print(list[1].value);
    return list;
  }
}

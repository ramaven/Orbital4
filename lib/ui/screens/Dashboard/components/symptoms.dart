import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_register_auth/globals.dart' as globals;
import 'dart:collection';
import 'package:login_register_auth/globals.dart' as globals;

class SymptomsDashboard extends StatefulWidget {
  const SymptomsDashboard({Key key}) : super(key: key);

  @override
  _SymptomsDashboardState createState() => _SymptomsDashboardState();
}

class _SymptomsDashboardState extends State<SymptomsDashboard> {
  String symptoms;
  List<Map<String, dynamic>> painLogs;

  @override
  void initState() {
    setState(() {
      painLogs = globals.Userprofile.painLogs;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //refresh pain log data from firestore
    globals.Userprofile.get().then((response) {
      setState(() {
        painLogs = globals.Userprofile.painLogs;
      });
    });

    return Column(children: [
      Text(" Symptoms",
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 3),
      Container(
        width: 140,
        height: 180,
        padding: const EdgeInsets.all(10),
        // color: Colors.black,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          //color: Colors.black,
          //color:
          color: Colors.blue[900],
          //Color(0xFFA8E4EC),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),

        child: Column(children: stringListToTextList(getTopSymptoms(painLogs))
            //[
            // Text("Most Frequent", style: TextStyle(color: Colors.blueAccent)),
            // ListView(
            //   children: [
            //     Text("a", style: TextStyle(color: Colors.white)),
            //     Text("b", style: TextStyle(color: Colors.white)),
            //     Text("c", style: TextStyle(color: Colors.white))
            //   ],
            // ),
            //],
            ),
      ),
    ]);
  }

  List<Widget> stringListToTextList(List<String> ls) {
    List<Widget> texts = [
      Text("Most Frequent",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      SizedBox(
        height: 10,
      ),
    ];

    for (String word in ls) {
      texts.add(Text(word,
          style: TextStyle(
            color: Colors.white,
            //Colors.blue[100],
          )));
      texts.add(SizedBox(
        height: 4,
      ));
    }

    return texts;
  }

  //METHOD TO GET DATA OF SYMPTOMS

  List<String> getTopSymptoms(List<Map<String, dynamic>> painLogsFirebase) {
    List<String> symptomsList = [
      "Others",
      "NIL",
      "Fever",
      "Cough",
      "Flu-like symptoms",
      "Runny nose",
      "Sneezing",
      "SoreThroat",
      "Nausea",
      "Vomitting",
      "Dizziness",
      "General body ache",
      "Body weakness",
      "Fatigue",
      "Numbness",
      "Mood swings",
      "Depression",
      "Anxiety",
      "Breathlessness",
      "Vertigo",
      "Poor appetite",
      "Increased appetite",
      "Difficulty concentrating",
      "Confusion",
      "Memory loss",
      "Diarrhea",
      "Gastric",
      "Nosebleed"
    ];

    // Create HashMap Key:symptom, Value:counter
    HashMap map = new HashMap<String, int>();
    // Initialise all counters to 0
    for (int i = 0; i < symptomsList.length; i++) {
      // String curPart = symptomsList[i];
      map[symptomsList[i]] = 0;
      //map[curPart] = 0;
    }

    // Update counter for all pain logs using occurrences of symptoms
    for (int i = 0; i < painLogsFirebase.length; i++) {
      Map<String, dynamic> curLog = painLogsFirebase[i];

      // Retrieve body part from firestore
      String symptomStr = curLog['otherSymptoms'];

      String symptomCommas = symptomStr.substring(1, symptomStr.length - 1);
      List<String> splitSymptoms = symptomCommas.split(
        ",",
      );
      // print(symptomStr);
      // print(symptomCommas);
      // print(splitSymptoms);

      for (String s in splitSymptoms) {
        print(s.runtimeType);
        print(map[s]);
        List<String> splitAgain = s.split(" ");
        for (String ss in splitAgain) {
          if (map.containsKey(ss)) {
            // Retrieve the current counter, then add 1
            int newCounter = 0;
            newCounter = map[ss] + 1;
            // Update
            map[ss] = newCounter;
          }
        }
      }
    }

    // Count total number of occurences (add all values)
    var counters = map.values;
    int counterSum = 0;
    //var counterSum = counters.reduce((sum, element) => sum + element);
    for (int k = 0; k < counters.length; k++) {
      counterSum += counters.elementAt(k);
    }

    int calculatePercentage(int currBodyPart, int totalBodyPart) {
      return ((currBodyPart) * 100 / (totalBodyPart)).round();
    }

    // Replaces int values (num of occurences) with percentages
    for (int i = 0; i < symptomsList.length; i++) {
      // Num of occurences of curr body part
      int currCounter = map[symptomsList[i]];
      // Update with percentage
      map[symptomsList[i]] = calculatePercentage(currCounter, counterSum);
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

    List<String> topSymptoms = [];

    //while (topSymptoms.length <= 5 ) {
    sortedMap.forEach((sym, frequency) => {
          if (topSymptoms.length < 5 &&
              frequency != 0 &&
              sym.compareTo("NIL") != 0)
            {topSymptoms.add(sym)}
        });

    return topSymptoms;
  }
}

int getMax(List<int> values) {
  int max = 0;
  for (int i = 0; i < values.length; i++) {
    if (values[i] > max) {
      max = values[i];
    }
  }
  return max;
}

import 'package:flutter/material.dart';
import 'package:login_register_auth/globals.dart' as globals;
import 'dart:collection';

List<String> bodyPartList = [];
List<int> avgPainDurationList = [];
List<String> unitsList = [];

int counter = 0;

class DurationDashboard extends StatefulWidget {
  const DurationDashboard({Key key}) : super(key: key);

  @override
  _DurationDashboardState createState() => _DurationDashboardState();
}

class _DurationDashboardState extends State<DurationDashboard> {
  final ScrollController _scrollController = ScrollController();
  String medications;
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
    getData(painLogs);

    return Container(
        height: 150,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),

        // // child: Scrollbar(
        // //   isAlwaysShown: true,
        // //   controller: _scrollController,
        child: ListView(
          // controller: _scrollController,
          padding: const EdgeInsets.all(8),
          children: generatePainDurations(size),
        )
        // ),
        );
  }

  List<Container> generatePainDurations(Size size) {
    List<Container> durationBoxList = [
      Container(
        height: 8,
      ),
      Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            width: 15,
          ),
          Text(
            "Average Pain Duration Per Body Part",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ]),
      ),
    ];
    for (int i = 0; i < 5; i++) {
      durationBoxList.add(makeDurationBox(size));
      counter++;
    }
    print("duration box list size");
    print(durationBoxList.length);
    return durationBoxList;
  }

  Container makeDurationBox(Size size) {
    return Container(
      child: Column(children: [
        Container(
          width: size.width * 0.9,
          height: 50,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
          ),
          // padding: const EdgeInsets.all(8),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              width: 5,
            ),
            Text(
              bodyPartList.elementAt(counter),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.blue),
            ),

            SizedBox(
              width: 20,
            ),
            // replace this space with the big number for duration
            Text(
              (avgPainDurationList[counter] / 100 < 60
                  ? ((avgPainDurationList[counter] / 100).round().toString() +
                      ' seconds')
                  : (avgPainDurationList[counter] / 100 < 3600)
                      ? (((avgPainDurationList[counter] / 6000).round())
                              .toString() +
                          " minutes")
                      : (((avgPainDurationList[counter] / 360000).round())
                              .toString() +
                          " hours")),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.orange),
            ),
            SizedBox(
              width: 5,
            ),
            // Text(unitsList[counter]),
          ]),
        ),
        // SizedBox(height: 2),
      ]),
    );
  }

// START OF METHOD TO GET DATA
  void getData(List<Map<String, dynamic>> painLogsFirebase) {
    // Create HashMap Key:bodyPart, Value:counter
    HashMap mapFreq = new HashMap<String, int>();
    HashMap mapDuration = new HashMap<String, int>();

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
      mapFreq[bodyPartArr[i]] = 0;
      mapDuration[bodyPartArr[i]] = 0;
    }

    int calculatePainDuration(int painDuration, String durationType) {
      if (durationType == 'minutes') {
        painDuration = painDuration * 60;
      }
      if (durationType == 'hours') {
        painDuration = painDuration * 60 * 60;
      }
      return painDuration;
    }

    // Update counter for all pain logs using occurrences of body parts
    for (int i = 0; i < painLogsFirebase.length; i++) {
      Map<String, dynamic> curLog = painLogsFirebase[i];

      // Retrieve body part from firestore
      String bodyPart = curLog['bodyPart'];
      int painDuration = curLog['painDuration'];
      String durationType = curLog['durationType'];

      // Retrieve the current counter, then add 1
      int newFreq = 0;
      int newDuration = 0;
      newFreq = mapFreq[bodyPart] + 1;
      // Durations are all in seconds
      newDuration = (mapDuration[bodyPart] +
              calculatePainDuration(painDuration, durationType))
          .round();
      print("painduration in seconds");
      print(newDuration);

      // Update
      mapFreq[bodyPart] = newFreq;
      mapDuration[bodyPart] = newDuration;
    }

    // Count total number of occurences (add all values)
    var counters = mapFreq.values;
    int counterSum = 0;
    //var counterSum = counters.reduce((sum, element) => sum + element);
    for (int k = 0; k < counters.length; k++) {
      counterSum += counters.elementAt(k);
    }

    // print("mapfreqbodypartarr[3]");
    // print(mapFreq[bodyPartArr[3]]);
    // Method to Calculate percentage
    int calculateAvgPainDuration(int totalDuration, int totalLogs) {
      if (totalDuration == 0 || totalLogs == 0) {
        return 0;
      }
      return ((totalDuration) * 100 / (totalLogs)).round();
    }

    // Replaces int values (num of occurences) with averages
    for (int i = 0; i < bodyPartArr.length; i++) {
      // Total duration for each bodypart
      int currDuration = mapDuration[bodyPartArr[i]];

      // Update with percentage
      mapDuration[bodyPartArr[i]] =
          calculateAvgPainDuration(currDuration, mapFreq[bodyPartArr[i]]);

      // Total freq for each bodypart
      int currCounter = mapFreq[bodyPartArr[i]];
      // Update with percentage
      mapFreq[bodyPartArr[i]] =
          calculateAvgPainDuration(currCounter, counterSum);
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

    LinkedHashMap sortedMap = sortListMap(mapFreq);

    // Convert map to list, and add colour in for only the top 5 frequency.
    int x = 0;
    // List<PieChartSectionData> list = [];
    sortedMap.forEach((bodyPart, frequency) => {
          if (x < 5)
            {
              bodyPartList.add(bodyPart),
              avgPainDurationList.add(mapDuration[bodyPart]),
              x++
            }
        });

    // GET UNITS FOR DURATION
    // for (int i = 0; i < 5; i++) {
    //   int currDuration = avgPainDurationList[i];
    //
    //   // More than 1 hr
    //   if (currDuration > (60 * 60)) {
    //     avgPainDurationList[i] = (currDuration / (60 * 60)).round();
    //     unitsList.add('hour(s)');
    //   }
    //
    //   // More than 1 minute
    //   else if (currDuration > 60) {
    //     avgPainDurationList[i] = (currDuration / 60).round();
    //     unitsList.add('minutes');
    //   } else {
    //     unitsList.add('seconds');
    //   }
    // }
  }
}

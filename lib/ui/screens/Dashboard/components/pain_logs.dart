// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:login_register_auth/globals.dart' as globals;
// import 'dart:collection';
//
// import '../../../constants.dart';
//
// class PainLogs extends StatefulWidget {
//   const PainLogs({Key key}) : super(key: key);
//   // static const routeName = '/allpainlogs';
//
//   @override
//   _PainLogsState createState() => _PainLogsState();
// }
//
// class _PainLogsState extends State<PainLogs> {
//   List<Map<String, dynamic>> painLogs;
//
//   @override
//   void initState() {
//     setState(() {
//       painLogs = globals.Userprofile.painLogs;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Container(
//         // padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
//         child: Text("Pain Logs",
//             textAlign: TextAlign.left,
//             style: TextStyle(fontWeight: FontWeight.bold)),
//       ),
//       Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         color: Color(0xFFA8E4EC),
//         elevation: 8,
//         child: Stack(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(15),
//               child: SizedBox(
//                 height: 150,
//                 width: 300,
//                 child: LineChart(
//                   LineChartData(
//                       lineTouchData: LineTouchData(enabled: false),
//                       lineBarsData: createLineData(painLogs),
//                       minY: 0,
//                       maxY: 10,
//                       minX: 6.20,
//                       maxX: 6.30,
//                       titlesData: FlTitlesData()
//                       // bottomTitles: SideTitles(
//                       //     showTitles: true,
//                       //     getTextStyles: (value) => const TextStyle(
//                       //         fontSize: 9,
//                       //         color: Colors.black,
//                       //         fontWeight: FontWeight.bold),
//                       //     getTitles: (value) {
//                       //       switch (value.toInt()) {
//                       //         case 0:
//                       //           return '1/6';
//                       //         case 1:
//                       //           return '2/6';
//                       //         case 2:
//                       //           return '3/6';
//                       //         case 3:
//                       //           return '4/6';
//                       //         case 4:
//                       //           return '5/6';
//                       //         case 5:
//                       //           return '6/6';
//                       //         default:
//                       //           return '';
//                       //       }
//                       //     }),
//                       //   leftTitles: SideTitles(
//                       //       showTitles: true,
//                       //       getTitles: (value) {
//                       //         if (value <= 100) {
//                       //           return ' ${value + 20} ';
//                       //         }
//                       //         return '';
//                       //       }),
//                       // ),
//                       // gridData: FlGridData(
//                       //   show: true,
//                       //   checkToShowHorizontalLine: (double value) {
//                       //     return value == 20 ||
//                       //         value == 40 ||
//                       //         value == 60 ||
//                       //         value == 80 ||
//                       //         value == 100;
//                       //   },
//                       // ),
//                       ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ]);
//   }
//
//   // START OF METHOD TO GET DATA
//   // #flSpots = num of entries
//   List<LineChartBarData> createLineData(
//       List<Map<String, dynamic>> painLogsFirebase) {
//     List<LineChartBarData> finalList = [];
//     List<FlSpot> halfList = [];
//
//     // ABSTRACTION: THE METHOD THAT RETURNS the #1 frequent BODY PART
//     // after calling this method gotta iterate through
//     // and plot down the necesasry info
//     String getTopBodyParts(List<Map<String, dynamic>> painLogsFirebase) {
//       // Create HashMap Key:bodyPart, Value:counter
//       HashMap map = new HashMap<String, int>();
//
//       //Map<String, int> map = new HashMap<String, int>();
//
//       List<String> bodyPartArr = [
//         'Head',
//         'Neck',
//         'Shoulder',
//         'Arm',
//         'Elbow',
//         'Wrist',
//         'Fingers',
//         'Chest',
//         'Stomach',
//         'Waist',
//         'Hips',
//         'Back',
//         'Butt',
//         'Thigh',
//         'Knee',
//         'Shin',
//         'Calf',
//         'Ankle',
//         'Foot'
//       ];
//
//       // Initialise all counters to 0
//       for (int i = 0; i < bodyPartArr.length; i++) {
//         String curPart = bodyPartArr[i];
//         map[bodyPartArr[i]] = 0;
//         //map[curPart] = 0;
//       }
//       // print(painLogsFirebase.length);
//       // Update counter for all pain logs using occurrences of body parts
//       for (int i = 0; i < painLogsFirebase.length; i++) {
//         Map<String, dynamic> curLog = painLogsFirebase[i];
//
//         // Retrieve body part from firestore
//         String bodyPart = curLog['bodyPart'];
//         //print("line 215" + bodyPart);
//
//         // Retrieve the current counter, then add 1
//         int newCounter = 0;
//         newCounter = map[bodyPart] + 1;
//
//         // Update
//         map[bodyPart] = newCounter;
//       }
//
//       // Count total number of occurences (add all values)
//       var counters = map.values;
//       int counterSum = 0;
//       //var counterSum = counters.reduce((sum, element) => sum + element);
//       for (int k = 0; k < counters.length; k++) {
//         counterSum += counters.elementAt(k);
//       }
//
//       // Method to Calculate percentage
//       // double calculatePercentage(int currBodyPart, int totalBodyPart) {
//       //   return (currBodyPart.toDouble()) / (totalBodyPart.toDouble());
//       // }
//       int calculatePercentage(int currBodyPart, int totalBodyPart) {
//         return ((currBodyPart) * 100 / (totalBodyPart)).round();
//       }
//
//       // Replaces int values (num of occurences) with percentages
//       for (int i = 0; i < bodyPartArr.length; i++) {
//         // Num of occurences of curr body part
//         int currCounter = map[bodyPartArr[i]];
//         // Update with percentage
//         map[bodyPartArr[i]] = calculatePercentage(currCounter, counterSum);
//       }
//
//       // Method to Sort map based on values/percentages
//       LinkedHashMap sortListMap(HashMap map) {
//         List mapKeys = map.keys.toList(growable: false);
//         mapKeys.sort((k1, k2) => map[k2] - map[k1]);
//         LinkedHashMap resMap = new LinkedHashMap();
//         mapKeys.forEach((k1) {
//           resMap[k1] = map[k1];
//         });
//         return resMap;
//       }
//
//       LinkedHashMap sortedMap = sortListMap(map);
//
//       // The 5 colours to use in the pie chart
//       var colorArr = [
//         Colors.pinkAccent,
//         Color(0xFF26E5FF), // Blue
//         Color(0xFFFFCF26), // Yellow
//         Color(0xFFEE2727), // Red
//         Colors.green
//       ];
//
//       // Convert map to list, and add colour in for only the top 5 frequency.
//       int x = 0;
//       List<String> list = [];
//       sortedMap.forEach((bodyPart, frequency) => {
//             if (x < 1) {list.add(bodyPart), x++}
//           });
//       // print(list[0]);
//       return list[0];
//       //print("top: " + sortedMap[0].toString());
//       //return sortedMap[0].toString();
//     }
//     // END OF ABSTRACTION
//
//     // The top frequently appeared body parts
//     String topBodyPart = getTopBodyParts(painLogs);
//
//     double getDate(int day, int month) {
//       double res = 0;
//       res += month;
//
//       if (day >= 10) {
//         res += day / 100;
//       } else {
//         res += day / 10;
//       }
//       return res;
//     }
//
//     // Fill in the dates for the most freq body part (dates may not be evently spaced)
//     // Iterate thru the db, only if(bodypart) then take note and add the date, pain level
//     for (int i = 0; i < painLogsFirebase.length; i++) {
//       Map<String, dynamic> curLog = painLogsFirebase[i];
//
//       int day = curLog['day'];
//       int month = curLog['month'];
//
//       // X axis
//       double date = getDate(day, month);
//
//       String bodyPart = curLog['bodyPart'];
//       // Y axis
//       double painLevel = curLog['painLevel'];
//
//       // We are looking at the most frequent pain
//       if (bodyPart == topBodyPart) {
//         // Add data to flSpots array
//         // List<flspots>.add(day, level) --> returns List<FLSpots> with many plot points
//         halfList.add(FlSpot(date, painLevel));
//       }
//     }
//     print("heres the points on the graph");
//     print(halfList);
//     print("im sorting");
//     halfList.sort((a, b) => a.x.compareTo(b.x));
//     print(halfList);
//     // add List<flspots> to list<finaliST>
//     LineChartBarData finalData = new LineChartBarData(
//         spots: halfList,
//         isCurved: true,
//         barWidth: 2,
//         colors: [
//           Colors.white,
//         ],
//         dotData: FlDotData(
//           show: false,
//         ));
//     finalList.add(finalData);
//     return finalList;
//   }
//
// // LineBarsData: List<LineChartBarData>
// // LineChartBarData: List<FlSpot>
// // FlSpot: (val1, val2)
//
// // One LineChartBarData = one body part
// // FlSpot: (x axis, y axis)
//
// // Line bars data format
// // : [
// //   LineChartBarData(
// //     spots: [
// //       FlSpot(0, 10),
// //       FlSpot(1, 30),
// //       FlSpot(2, 5),
// //       FlSpot(3, 12),
// //       FlSpot(4, 14),
// //       FlSpot(5, 31),
// //     ],
// //     isCurved: true,
// //     barWidth: 2,
// //     colors: [
// //       Colors.white,
// //     ],
// //     dotData: FlDotData(
// //       show: false,
// //     ),
// //   ),
// //   LineChartBarData(
// //     spots: [
// //       FlSpot(0, 10),
// //       FlSpot(1, 43),
// //       FlSpot(2, 24),
// //       FlSpot(3, 30),
// //       FlSpot(4, 48),
// //       FlSpot(5, 21),
// //     ],
// //     isCurved: true,
// //     barWidth: 2,
// //     colors: [
// //       Colors.black,
// //     ],
// //     dotData: FlDotData(
// //       show: false,
// //     ),
// //   ),
// }
//
// // import 'package:fl_chart/fl_chart.dart';
// // import 'package:flutter/material.dart';
// //
// // class Pain_Logs extends StatelessWidget {
// //   const Pain_Logs({
// //     Key key,
// //   }) : super(key: key);
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(children: [
// //       Container(
// //         // padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
// //         child: Text("Pain Logs",
// //             textAlign: TextAlign.left,
// //             style: TextStyle(fontWeight: FontWeight.bold)),
// //       ),
// //       Card(
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(15.0),
// //         ),
// //         color: Color(0xFFA8E4EC),
// //         elevation: 8,
// //         child: Stack(
// //           children: [
// //             Padding(
// //               padding: EdgeInsets.all(15),
// //               child: SizedBox(
// //                 height: 150,
// //                 width: 300,
// //                 child: LineChart(
// //                   LineChartData(
// //                     lineTouchData: LineTouchData(enabled: false),
// //                     lineBarsData: [
// //                       LineChartBarData(
// //                         spots: [
// //                           FlSpot(0, 10),
// //                           FlSpot(1, 30),
// //                           FlSpot(2, 5),
// //                           FlSpot(3, 12),
// //                           FlSpot(4, 14),
// //                           FlSpot(5, 31),
// //                         ],
// //                         isCurved: true,
// //                         barWidth: 2,
// //                         colors: [
// //                           Colors.white,
// //                         ],
// //                         dotData: FlDotData(
// //                           show: false,
// //                         ),
// //                       ),
// //                       LineChartBarData(
// //                         spots: [
// //                           FlSpot(0, 10),
// //                           FlSpot(1, 43),
// //                           FlSpot(2, 24),
// //                           FlSpot(3, 30),
// //                           FlSpot(4, 48),
// //                           FlSpot(5, 21),
// //                         ],
// //                         isCurved: true,
// //                         barWidth: 2,
// //                         colors: [
// //                           Colors.black,
// //                         ],
// //                         dotData: FlDotData(
// //                           show: false,
// //                         ),
// //                       ),
// //                     ],
// //                     // betweenBarsData: [
// //                     //   BetweenBarsData(
// //                     //     fromIndex: 0,
// //                     //     toIndex: 2,
// //                     // colors: [Colors.red.withOpacity(0.3)],
// //                     // )
// //                     // ],
// //                     minY: 0,
// //                     titlesData: FlTitlesData(
// //                       bottomTitles: SideTitles(
// //                           showTitles: true,
// //                           getTextStyles: (value) => const TextStyle(
// //                               fontSize: 9,
// //                               color: Colors.black,
// //                               fontWeight: FontWeight.bold),
// //                           getTitles: (value) {
// //                             switch (value.toInt()) {
// //                               case 0:
// //                                 return '1/6';
// //                               case 1:
// //                                 return '2/6';
// //                               case 2:
// //                                 return '3/6';
// //                               case 3:
// //                                 return '4/6';
// //                               case 4:
// //                                 return '5/6';
// //                               case 5:
// //                                 return '6/6';
// //                               default:
// //                                 return '';
// //                             }
// //                           }),
// //                       leftTitles: SideTitles(
// //                           showTitles: true,
// //                           getTitles: (value) {
// //                             if (value <= 100) {
// //                               return ' ${value + 20} ';
// //                             }
// //                             return '';
// //                           }),
// //                     ),
// //                     gridData: FlGridData(
// //                       show: true,
// //                       checkToShowHorizontalLine: (double value) {
// //                         return value == 20 ||
// //                             value == 40 ||
// //                             value == 60 ||
// //                             value == 80 ||
// //                             value == 100;
// //                       },
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     ]);
// //   }
// // }

// newer one

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:login_register_auth/globals.dart' as globals;
import 'dart:collection';

import '../../../constants.dart';

class PainLogs extends StatefulWidget {
  const PainLogs({Key key}) : super(key: key);
  // static const routeName = '/allpainlogs';

  @override
  _PainLogsState createState() => _PainLogsState();
}

class _PainLogsState extends State<PainLogs> {
  List<Map<String, dynamic>> painLogs;

  @override
  void initState() {
    setState(() {
      painLogs = globals.Userprofile.painLogs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        // padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
        child: Text("Log of Most Affected Body Part",
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color(0xFFA8E4EC),
        elevation: 8,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: SizedBox(
                height: 150,
                width: 350,
                child: LineChart(
                  LineChartData(
                      lineTouchData: LineTouchData(enabled: false),
                      lineBarsData: createLineData(painLogs),
                      minY: 0,
                      maxY: 10,
                      minX: 1,
                      maxX: 30,
                      titlesData: FlTitlesData()
                      // bottomTitles: SideTitles(
                      //     showTitles: true,
                      //     getTextStyles: (value) => const TextStyle(
                      //         fontSize: 9,
                      //         color: Colors.black,
                      //         fontWeight: FontWeight.bold),
                      //     getTitles: (value) {
                      //       switch (value.toInt()) {
                      //         case 0:
                      //           return '1/6';
                      //         case 1:
                      //           return '2/6';
                      //         case 2:
                      //           return '3/6';
                      //         case 3:
                      //           return '4/6';
                      //         case 4:
                      //           return '5/6';
                      //         case 5:
                      //           return '6/6';
                      //         default:
                      //           return '';
                      //       }
                      //     }),
                      //   leftTitles: SideTitles(
                      //       showTitles: true,
                      //       getTitles: (value) {
                      //         if (value <= 100) {
                      //           return ' ${value + 20} ';
                      //         }
                      //         return '';
                      //       }),
                      // ),
                      // gridData: FlGridData(
                      //   show: true,
                      //   checkToShowHorizontalLine: (double value) {
                      //     return value == 20 ||
                      //         value == 40 ||
                      //         value == 60 ||
                      //         value == 80 ||
                      //         value == 100;
                      //   },
                      // ),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  // START OF METHOD TO GET DATA
  // #flSpots = num of entries
  List<LineChartBarData> createLineData(
      List<Map<String, dynamic>> painLogsFirebase) {
    List<LineChartBarData> finalList = [];
    List<FlSpot> halfList = [];

    // ABSTRACTION: THE METHOD THAT RETURNS the #1 frequent BODY PART
    // after calling this method gotta iterate through
    // and plot down the necesasry info
    String getTopBodyParts(List<Map<String, dynamic>> painLogsFirebase) {
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
      List<String> list = [];
      sortedMap.forEach((bodyPart, frequency) => {
            if (x < 1) {list.add(bodyPart), x++}
          });
      // print(list[0]);
      return list[0];
      //print("top: " + sortedMap[0].toString());
      //return sortedMap[0].toString();
    }
    // END OF ABSTRACTION

    // The top frequently appeared body parts
    String topBodyPart = getTopBodyParts(painLogs);

    // double getDate(int day, int month) {
    //   double res = 0;
    //   res += month;

    //   if (day >= 10) {
    //     res += day / 100;
    //   } else {
    //     res += day / 10;
    //   }
    //   return res;
    // }

    // Fill in the dates for the most freq body part (dates may not be evently spaced)
    // Iterate thru the db, only if(bodypart) then take note and add the date, pain level
    for (int i = 0; i < painLogsFirebase.length; i++) {
      Map<String, dynamic> curLog = painLogsFirebase[i];

      int day = curLog['day'];
      int month = curLog['month'];

      // X axis
      double date = day.toDouble();

      String bodyPart = curLog['bodyPart'];
      // Y axis
      double painLevel = curLog['painLevel'];

      // We are looking at the most frequent pain
      if (bodyPart == topBodyPart) {
        // Add data to flSpots array
        // List<flspots>.add(day, level) --> returns List<FLSpots> with many plot points
        halfList.add(FlSpot(date, painLevel));
      }
    }
    print("heres the points on the graph");
    print(halfList);
    print("im sorting");
    halfList.sort((a, b) => a.x.compareTo(b.x));
    print(halfList);
    // add List<flspots> to list<finaliST>
    LineChartBarData finalData = new LineChartBarData(
        spots: halfList,
        isCurved: true,
        barWidth: 2,
        colors: [
          Colors.white,
        ],
        dotData: FlDotData(
          show: false,
        ));
    finalList.add(finalData);
    return finalList;
  }

// LineBarsData: List<LineChartBarData>
// LineChartBarData: List<FlSpot>
// FlSpot: (val1, val2)

// One LineChartBarData = one body part
// FlSpot: (x axis, y axis)

// Line bars data format
// : [
//   LineChartBarData(
//     spots: [
//       FlSpot(0, 10),
//       FlSpot(1, 30),
//       FlSpot(2, 5),
//       FlSpot(3, 12),
//       FlSpot(4, 14),
//       FlSpot(5, 31),
//     ],
//     isCurved: true,
//     barWidth: 2,
//     colors: [
//       Colors.white,
//     ],
//     dotData: FlDotData(
//       show: false,
//     ),
//   ),
//   LineChartBarData(
//     spots: [
//       FlSpot(0, 10),
//       FlSpot(1, 43),
//       FlSpot(2, 24),
//       FlSpot(3, 30),
//       FlSpot(4, 48),
//       FlSpot(5, 21),
//     ],
//     isCurved: true,
//     barWidth: 2,
//     colors: [
//       Colors.black,
//     ],
//     dotData: FlDotData(
//       show: false,
//     ),
//   ),
}

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
//
// class Pain_Logs extends StatelessWidget {
//   const Pain_Logs({
//     Key key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Container(
//         // padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
//         child: Text("Pain Logs",
//             textAlign: TextAlign.left,
//             style: TextStyle(fontWeight: FontWeight.bold)),
//       ),
//       Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         color: Color(0xFFA8E4EC),
//         elevation: 8,
//         child: Stack(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(15),
//               child: SizedBox(
//                 height: 150,
//                 width: 300,
//                 child: LineChart(
//                   LineChartData(
//                     lineTouchData: LineTouchData(enabled: false),
//                     lineBarsData: [
//                       LineChartBarData(
//                         spots: [
//                           FlSpot(0, 10),
//                           FlSpot(1, 30),
//                           FlSpot(2, 5),
//                           FlSpot(3, 12),
//                           FlSpot(4, 14),
//                           FlSpot(5, 31),
//                         ],
//                         isCurved: true,
//                         barWidth: 2,
//                         colors: [
//                           Colors.white,
//                         ],
//                         dotData: FlDotData(
//                           show: false,
//                         ),
//                       ),
//                       LineChartBarData(
//                         spots: [
//                           FlSpot(0, 10),
//                           FlSpot(1, 43),
//                           FlSpot(2, 24),
//                           FlSpot(3, 30),
//                           FlSpot(4, 48),
//                           FlSpot(5, 21),
//                         ],
//                         isCurved: true,
//                         barWidth: 2,
//                         colors: [
//                           Colors.black,
//                         ],
//                         dotData: FlDotData(
//                           show: false,
//                         ),
//                       ),
//                     ],
//                     // betweenBarsData: [
//                     //   BetweenBarsData(
//                     //     fromIndex: 0,
//                     //     toIndex: 2,
//                     // colors: [Colors.red.withOpacity(0.3)],
//                     // )
//                     // ],
//                     minY: 0,
//                     titlesData: FlTitlesData(
//                       bottomTitles: SideTitles(
//                           showTitles: true,
//                           getTextStyles: (value) => const TextStyle(
//                               fontSize: 9,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold),
//                           getTitles: (value) {
//                             switch (value.toInt()) {
//                               case 0:
//                                 return '1/6';
//                               case 1:
//                                 return '2/6';
//                               case 2:
//                                 return '3/6';
//                               case 3:
//                                 return '4/6';
//                               case 4:
//                                 return '5/6';
//                               case 5:
//                                 return '6/6';
//                               default:
//                                 return '';
//                             }
//                           }),
//                       leftTitles: SideTitles(
//                           showTitles: true,
//                           getTitles: (value) {
//                             if (value <= 100) {
//                               return ' ${value + 20} ';
//                             }
//                             return '';
//                           }),
//                     ),
//                     gridData: FlGridData(
//                       show: true,
//                       checkToShowHorizontalLine: (double value) {
//                         return value == 20 ||
//                             value == 40 ||
//                             value == 60 ||
//                             value == 80 ||
//                             value == 100;
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ]);
//   }
// }

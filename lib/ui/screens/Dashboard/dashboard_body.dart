import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:login_register_auth/ui/screens/Dashboard/components/bar_chart_pain.dart';
import 'package:login_register_auth/ui/screens/Dashboard/components/medications.dart';
import 'package:login_register_auth/ui/screens/Dashboard/components/pain_level.dart';
import 'package:login_register_auth/ui/screens/Dashboard/components/pain_logs.dart';
import 'package:login_register_auth/ui/screens/Dashboard/components/symptoms.dart';
import 'package:login_register_auth/ui/screens/Dashboard/components/testingPainLog/line_chart.dart';
import 'package:login_register_auth/ui/screens/Dashboard/top_bodypart_average.dart';

import 'components/activity.dart';
import 'components/appointments.dart';
import 'components/medicine_relief.dart';
import 'components/pain_composition.dart';
// import 'components/pain_logs.dart';
import 'components/testingPainLog/line_chart.dart';
import 'components/tbc_chart.dart';

import 'package:login_register_auth/globals.dart' as globals;

// class DashboardBackground extends StatelessWidget {
//   const DashboardBackground({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text("Dashboard page"),
//     );
//   }
// }

class DashboardBackground extends StatefulWidget {
  const DashboardBackground({Key key}) : super(key: key);

  @override
  _DashboardBackgroundState createState() => _DashboardBackgroundState();
}

class _DashboardBackgroundState extends State<DashboardBackground> {
  List<Map<String, dynamic>> painLogs;
  Widget loading = CircularProgressIndicator();

  @override
  void initState() {
    setState(() {
      globals.Userprofile.get();
      painLogs = globals.Userprofile.painLogs;
    });
  }

  @override
  Widget build(BuildContext context) {
    globals.Userprofile.get();
    Size size = MediaQuery.of(context).size;
    // If no more than
    if (painLogs.length < 1) {
      setState(() {
        loading = Column(children: [
          SizedBox(
            width: size.width * 0.07,
          ),
          (globals.Userprofile.firstName == "NIL" ||
                  globals.Userprofile.firstName == null)
              ? Text("Please fill up your Profile",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue))
              : Text("${globals.Userprofile.firstName}'s Pain Summary",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
          Divider(
            height: size.height * 0.03,
            thickness: 1,
          ),
          // SizedBox(height: size.height * 0.03),
          // Appointments(),
          SizedBox(
            height: size.height * 0.015,
          ),
          Text(
            "Please enter at least 1 pain log to view the dashboard summary",
            textAlign: TextAlign.center,
          ),
        ]);
      });
    } else {
      setState(() {
        loading = new ListView(
          children: [
            SizedBox(
              height: size.height * 0.015,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: size.width * 0.07,
              ),
              (globals.Userprofile.firstName == "NIL" ||
                      globals.Userprofile.firstName == null)
                  ? Text("Please fill up your Profile",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue))
                  : Text("${globals.Userprofile.firstName}'s Pain Summary",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
              // OutlinedButton(
              //   style: OutlinedButton.styleFrom(
              //       backgroundColor: Colors.blue.shade100,
              //       //padding: const EdgeInsets.symmetric(horizontal: 20),
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(20))),
              //   onPressed: () {
              //     //Navigator.of(context).pushReplacementNamed('login');
              //   },
              //   child: Text(
              //     "About",
              //     style: TextStyle(
              //         fontSize: 12, letterSpacing: 2.2, color: Colors.black),
              //   ),
              // ),
            ]),
            Divider(
              height: size.height * 0.03,
              thickness: 1,
            ),
            // SizedBox(height: size.height * 0.03),
            // Appointments(),
            SizedBox(
              height: size.height * 0.015,
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      child: PainComposition(),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Pain Composition Chart'),
                                content: Text(
                                    "This pie chart shows the top 5  body parts that you have felt pain in."),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'))
                                ],
                              );
                            });
                      }),
                  GestureDetector(
                      child: SymptomsDashboard(),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Frequent Symptoms List'),
                                content: Text(
                                    "This list shows the top 5 symptoms that you have logged when you felt pain."),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'))
                                ],
                              );
                            });
                      }),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      child: PainLevel(),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Pain level Chart'),
                                content: Text(
                                    "This pie chart shows the distribution of the pain scores that you have logged. Low refers to a pain score of 1 to 3, medium refers to a pain score of 4-6 and high refers to a pain score of 7-10"),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'))
                                ],
                              );
                            });
                      }),
                  GestureDetector(
                      child: MedicineDashboard(),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Frequent Medications List'),
                                content: Text(
                                    "This list shows the top 5 medications that you have taken when you felt pain."),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'))
                                ],
                              );
                            });
                      }),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              DurationDashboard(),
            ]),
            SizedBox(
              height: 20,
            ),
          ],
        );
      });
    }

    return loading;
  }
}

// (col, row)
List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  // Upcoming appointments
  const StaggeredTile.count(4, 1.2),
  // Daily pain logs
  const StaggeredTile.count(4, 2.2),
  // Relief from med
  const StaggeredTile.count(2, 2.2),
  // Pain composition
  const StaggeredTile.count(2, 2.2),
  // Activity bar graph
  const StaggeredTile.count(4, 2.2),
];

// List<Widget> _tiles = const <Widget>[
//   // Upcoming appointments
//   const Appointments(),
//   // Daily pain logs
//   const StockChartExample(),
//   // Relief from med
//   const MedicineRelief(),
//   // Pain composition
//   const PainComposition(),
//   // Activity bar graph
//   const Activity()
// ];

// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:login_register_auth/ui/screens/Dashboard/components/pain_level.dart';
// import 'package:login_register_auth/ui/screens/Dashboard/components/testingPainLog/line_chart.dart';
//
// import 'components/activity.dart';
// import 'components/appointments.dart';
// import 'components/medicine_relief.dart';
// import 'components/pain_composition.dart';
// import 'components/pain_logs.dart';
// import 'components/tbc_chart.dart';
//
// import 'package:login_register_auth/globals.dart' as globals;
//
// // class DashboardBackground extends StatelessWidget {
// //   const DashboardBackground({Key key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       child: Text("Dashboard page"),
// //     );
// //   }
// // }
//
// class DashboardBackground extends StatefulWidget {
//   const DashboardBackground({Key key}) : super(key: key);
//
//   @override
//   _DashboardBackgroundState createState() => _DashboardBackgroundState();
// }
//
// class _DashboardBackgroundState extends State<DashboardBackground> {
//   List<Map<String, dynamic>> painLogs;
//
//   @override
//   void initState() {
//     setState(() {
//       globals.Userprofile.get();
//       painLogs = globals.Userprofile.painLogs;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     globals.Userprofile.get();
//     Size size = MediaQuery.of(context).size;
//     // If no more than
//     if (painLogs.length < 1) {
//       return Text(
//           "Please enter more than 1 pain log to view the dashboard summary");
//     }
//
//     return new ListView(
//       children: [
//         Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//           (globals.Userprofile.firstName == "NIL" ||
//                   globals.Userprofile.firstName == null)
//               ? Text("Please fill up your Profile",
//                   style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue))
//               : Text("Hello ${globals.Userprofile.firstName}!",
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue)),
//         ]),
//         Divider(
//           height: size.height * 0.03,
//           thickness: 1,
//         ),
//         Appointments(),
//         SizedBox(
//           height: 20,
//         ),
//         Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           PainComposition(),
//           SizedBox(
//             height: 20,
//           ),
//           PainLevel(),
//         ]),
//         SizedBox(
//           height: 20,
//         ),
//         // PainLogs(),
//         StockChartExample(),
//         SizedBox(
//           height: 20,
//         ),
//         MedicineRelief(),
//         Activity(),
//       ],
//     );
//     //return new SizedBox(
//     //     width: 200.0,
//     //     height: 300.0,
//     // Padding(
//     // padding: const EdgeInsets.only(top: 12.0),
//     //  child: Appointments()
//     // child: new StaggeredGridView.count(
//     //   crossAxisCount: 4,
//     //   staggeredTiles: _staggeredTiles,
//     //   children: _tiles,
//     //   mainAxisSpacing: 4.0,
//     //   crossAxisSpacing: 4.0,
//     //   padding: const EdgeInsets.all(4.0),
//     // ),
//     // );
//     //return Container(child: Text("Dashboard page"));
//   }
// }
//
// // (col, row)
// List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
//   // Upcoming appointments
//   const StaggeredTile.count(4, 1.2),
//   // Daily pain logs
//   const StaggeredTile.count(4, 2.2),
//   // Relief from med
//   const StaggeredTile.count(2, 2.2),
//   // Pain composition
//   const StaggeredTile.count(2, 2.2),
//   // Activity bar graph
//   const StaggeredTile.count(4, 2.2),
// ];
//
// List<Widget> _tiles = const <Widget>[
//   // Upcoming appointments
//   const Appointments(),
//   // Daily pain logs
//   const PainLogs(),
//   // Relief from med
//   const MedicineRelief(),
//   // Pain composition
//   const PainComposition(),
//   // Activity bar graph
//   const Activity()
// ];

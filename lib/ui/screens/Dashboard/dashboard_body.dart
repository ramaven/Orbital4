import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'components/activity.dart';
import 'components/appointments.dart';
import 'components/medicine_relief.dart';
import 'components/pain_composition.dart';
import 'components/pain_logs.dart';
import 'components/tbc_chart.dart';

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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new ListView(
      children: [
        Appointments(),
        SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Pain_Composition(),
          TBC_Chart(),
        ]),
        SizedBox(
          height: 20,
        ),
        Pain_Logs(),
        SizedBox(
          height: 20,
        ),
        MedicineRelief(),
        Activity(),
      ],
    );
    //return new SizedBox(
    //     width: 200.0,
    //     height: 300.0,
    // Padding(
    // padding: const EdgeInsets.only(top: 12.0),
    //  child: Appointments()
    // child: new StaggeredGridView.count(
    //   crossAxisCount: 4,
    //   staggeredTiles: _staggeredTiles,
    //   children: _tiles,
    //   mainAxisSpacing: 4.0,
    //   crossAxisSpacing: 4.0,
    //   padding: const EdgeInsets.all(4.0),
    // ),
    // );
    //return Container(child: Text("Dashboard page"));
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

List<Widget> _tiles = const <Widget>[
  // Upcoming appointments
  const Appointments(),
  // Daily pain logs
  const Pain_Logs(),
  // Relief from med
  const MedicineRelief(),
  // Pain composition
  const Pain_Composition(),
  // Activity bar graph
  const Activity()
];

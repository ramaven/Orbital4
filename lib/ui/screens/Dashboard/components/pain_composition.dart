import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Pain_Composition extends StatelessWidget {
  const Pain_Composition({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  sections: paiChartSelectionDatas,
                ),
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // children: [
                //   SizedBox(height: defaultPadding),
                //   Text(
                //     "Pain",
                //     style: Theme.of(context).textTheme.headline6!.copyWith(
                //           color: Colors.white,
                //           fontWeight: FontWeight.w600,
                //           height: 0.3,
                //         ),
                //   ),
                //   Text("Composition")
                // ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

List<PieChartSectionData> paiChartSelectionDatas = [
  PieChartSectionData(
    color: Colors.pinkAccent,
    value: 25,
    showTitle: false,
    radius: 25,
  ),
  PieChartSectionData(
    color: Color(0xFF26E5FF),
    value: 20,
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    color: Color(0xFFFFCF26),
    value: 10,
    showTitle: false,
    radius: 19,
  ),
  PieChartSectionData(
    color: Color(0xFFEE2727),
    value: 15,
    showTitle: false,
    radius: 16,
  ),
  PieChartSectionData(
    color: Colors.green,
    value: 25,
    showTitle: false,
    radius: 13,
  ),
];

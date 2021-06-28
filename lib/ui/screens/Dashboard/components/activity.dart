import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Activity extends StatelessWidget {
  const Activity({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: EdgeInsets.all(15),
        child: Text(" Activity Monitor",
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
              padding: EdgeInsets.only(top: 40, right: 20),
              child: SizedBox(
                height: 150,
                width: 300,
                child: BarChart(
                  BarChartData(
                    // borderData: FlBorderData(
                    //     border: Border(
                    //   top: BorderSide(width: 1),
                    //   right: BorderSide(width: 1),
                    //   left: BorderSide(width: 1),
                    //   bottom: BorderSide(width: 1),
                    // )),
                    groupsSpace: 10,
                    barGroups: [
                      BarChartGroupData(x: 1, barRods: [
                        BarChartRodData(y: 3, width: 8, colors: [Colors.amber]),
                        BarChartRodData(y: 4.2, width: 8, colors: [Colors.red]),
                        BarChartRodData(y: 5, width: 8, colors: [Colors.blue]),
                      ]),
                      BarChartGroupData(x: 2, barRods: [
                        BarChartRodData(y: 8, width: 8, colors: [Colors.amber]),
                        BarChartRodData(y: 6.2, width: 8, colors: [Colors.red]),
                        BarChartRodData(y: 1, width: 8, colors: [Colors.blue]),
                      ]),
                      BarChartGroupData(x: 3, barRods: [
                        BarChartRodData(y: 7, width: 8, colors: [Colors.amber]),
                        BarChartRodData(y: 5.1, width: 8, colors: [Colors.red]),
                        BarChartRodData(
                            y: 5.3, width: 8, colors: [Colors.blue]),
                      ]),
                      BarChartGroupData(x: 4, barRods: [
                        BarChartRodData(y: 5, width: 8, colors: [Colors.amber]),
                        BarChartRodData(y: 2, width: 8, colors: [Colors.red]),
                        BarChartRodData(y: 7, width: 8, colors: [Colors.blue]),
                      ]),
                      BarChartGroupData(x: 5, barRods: [
                        BarChartRodData(y: 8, width: 8, colors: [Colors.amber]),
                        BarChartRodData(y: 5, width: 8, colors: [Colors.red]),
                        BarChartRodData(y: 6, width: 8, colors: [Colors.blue]),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
    // return Container(
    //   decoration: const BoxDecoration(
    //     border: Border(
    //       top: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
    //       left: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
    //       right: BorderSide(width: 1.0, color: Color(0xFF000000)),
    //       bottom: BorderSide(width: 1.0, color: Color(0xFF000000)),
    //     ),
    //   ),
    //   child: Container(
    //     padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
    //     decoration: const BoxDecoration(
    //       border: Border(
    //         top: BorderSide(width: 1.0, color: Color(0xFFDFDFDF)),
    //         left: BorderSide(width: 1.0, color: Color(0xFFDFDFDF)),
    //         right: BorderSide(width: 1.0, color: Color(0xFF7F7F7F)),
    //         bottom: BorderSide(width: 1.0, color: Color(0xFF7F7F7F)),
    //       ),
    //       color: Color(0xFFBFBFBF),
    //     ),
    //     child: const Text('OK',
    //         textAlign: TextAlign.center,
    //         style: TextStyle(color: Color(0xFF000000))),
    //   ),
    // );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Pain_Logs extends StatelessWidget {
  const Pain_Logs({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        // padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
        child: Text("Pain Logs",
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
                width: 300,
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(enabled: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 10),
                          FlSpot(1, 30),
                          FlSpot(2, 5),
                          FlSpot(3, 12),
                          FlSpot(4, 14),
                          FlSpot(5, 31),
                        ],
                        isCurved: true,
                        barWidth: 2,
                        colors: [
                          Colors.white,
                        ],
                        dotData: FlDotData(
                          show: false,
                        ),
                      ),
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 10),
                          FlSpot(1, 43),
                          FlSpot(2, 24),
                          FlSpot(3, 30),
                          FlSpot(4, 48),
                          FlSpot(5, 21),
                        ],
                        isCurved: true,
                        barWidth: 2,
                        colors: [
                          Colors.black,
                        ],
                        dotData: FlDotData(
                          show: false,
                        ),
                      ),
                    ],
                    // betweenBarsData: [
                    //   BetweenBarsData(
                    //     fromIndex: 0,
                    //     toIndex: 2,
                    // colors: [Colors.red.withOpacity(0.3)],
                    // )
                    // ],
                    minY: 0,
                    titlesData: FlTitlesData(
                      bottomTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                              fontSize: 9,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          getTitles: (value) {
                            switch (value.toInt()) {
                              case 0:
                                return '1/6';
                              case 1:
                                return '2/6';
                              case 2:
                                return '3/6';
                              case 3:
                                return '4/6';
                              case 4:
                                return '5/6';
                              case 5:
                                return '6/6';
                              default:
                                return '';
                            }
                          }),
                      leftTitles: SideTitles(
                          showTitles: true,
                          getTitles: (value) {
                            if (value <= 100) {
                              return ' ${value + 20} ';
                            }
                            return '';
                          }),
                    ),
                    gridData: FlGridData(
                      show: true,
                      checkToShowHorizontalLine: (double value) {
                        return value == 20 ||
                            value == 40 ||
                            value == 60 ||
                            value == 80 ||
                            value == 100;
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

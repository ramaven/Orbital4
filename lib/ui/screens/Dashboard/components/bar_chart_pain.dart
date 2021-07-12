import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:login_register_auth/globals.dart' as globals;
import 'dart:collection';

DateTime todayDate = DateTime.now();
int todayYear = DateTime.now().year;
int todayMonth = DateTime.now().month;
int todayDay = DateTime.now().day;

DateTime twoWeeksAgo = todayDate.subtract(const Duration(days: 14));
int twoWeeksAgoYear = twoWeeksAgo.year;
int twoWeeksAgoMonth = twoWeeksAgo.month;
int twoWeeksAgoDay = twoWeeksAgo.day;

class PainLogsBar extends StatefulWidget {
  const PainLogsBar({Key key}) : super(key: key);
  // static const routeName = '/allpainlogs';

  @override
  _PainLogsBarState createState() => _PainLogsBarState();

// TimeSeriesBar(this.seriesList, {this.animate});

// / Creates a [TimeSeriesChart] with sample data and no transition.
// factory TimeSeriesBar.withSampleData() {
//   return new TimeSeriesBar(
//     _createSampleData(),
//     // Disable animations for image tests.
//     animate: false,
//   );
// }

// List<Map<String, dynamic>> painLogs;
}

class _PainLogsBarState extends State<PainLogsBar> {
  List<Map<String, dynamic>> painLogs;
  List<charts.Series<TimeSeriesPainLevel, DateTime>> seriesList;
  bool animate;

  @override
  void initState() {
    setState(() {
      painLogs = globals.Userprofile.painLogs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Set the default renderer to a bar renderer.
      // This can also be one of the custom renderers of the time series chart.
      defaultRenderer: new charts.BarRendererConfig<DateTime>(),
      // It is recommended that default interactions be turned off if using bar
      // renderer, because the line point highlighter is the default for time
      // series chart.
      defaultInteractions: false,
      // If default interactions were removed, optionally add select nearest
      // and the domain highlighter that are typical for bar charts.
      behaviors: [new charts.SelectNearest(), new charts.DomainHighlighter()],
    );
  }

  /// Create one series with sample hard coded data.
  List<charts.Series<TimeSeriesPainLevel, DateTime>> _createSampleData() {
    final data = createBarDataList(painLogs);

    return [
      new charts.Series<TimeSeriesPainLevel, DateTime>(
        id: 'Pain Level of Most Frequent Body Part for the Last 2 weeks',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesPainLevel pain, _) => pain.date,
        measureFn: (TimeSeriesPainLevel pain, _) => pain.level,
        data: data,
      )
    ];
  }

  // Format: TimeSeriesPainLevel(DateTime(Year, Month, Day), level)
  // START OF METHOD TO GET DATA
  // #flSpots = num of entries
  List<TimeSeriesPainLevel> createBarDataList(
      List<Map<String, dynamic>> painLogsFirebase) {
    List<TimeSeriesPainLevel> finalList = [];

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

    // Fill in the dates for the most freq body part (dates may not be evently spaced)
    // Iterate thru the db, only if(bodypart) then take note and add the date, pain level
    for (int i = 0; i < painLogsFirebase.length; i++) {
      Map<String, dynamic> curLog = painLogsFirebase[i];

      // This chunk is to get the DateTime of this entry and check
      // If it's wtihin the last two weeks
      String day = curLog['day'].toString().padLeft(2, '0');
      String month = curLog['month'].toString().padLeft(2, '0');
      String year = curLog['year'].toString().padLeft(4, '0');
      // Format it such that we can parse it into DateTime
      String dateString = year + '-' + month + '-' + day;
      // datetime for this log
      DateTime dateDateTime = DateTime.parse(dateString);

      String bodyPart = curLog['bodyPart'];
      // Y axis
      double painLevel = curLog['painLevel'];

      // We are looking at the most frequent pain
      // Make sure the date of this entry is within the last two weeks
      if (bodyPart == topBodyPart && dateDateTime.compareTo(twoWeeksAgo) > 0) {
        int currYear = dateDateTime.year;
        int currMonth = dateDateTime.month;
        int currDay = dateDateTime.day;

        // Format of finalList: TimeSeriesPainLevel(DateTime(Year, Month, Day), level)
        // List<flspots>.add(day, level) --> returns List<FLSpots> with many plot points
        finalList.add(TimeSeriesPainLevel(
            DateTime(currYear, currMonth, currDay), painLevel));
      }
    }
    // print("heres the points on the graph");
    // print(halfList);
    // print("im sorting");
    finalList.sort((a, b) => a.date.compareTo(b.date));
    // print(halfList);
    // add List<flspots> to list<finaliST>
    return finalList;
  }
}

/// Sample time series data type.
class TimeSeriesPainLevel {
  final DateTime date;
  final double level;

  TimeSeriesPainLevel(this.date, this.level);
}

// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:flutter/material.dart';
//
// class TimeSeriesBar extends StatelessWidget {
//   final List<charts.Series<TimeSeriesSales, DateTime>> seriesList;
//   final bool animate;
//
//   TimeSeriesBar(this.seriesList, {this.animate});
//
//   /// Creates a [TimeSeriesChart] with sample data and no transition.
//   factory TimeSeriesBar.withSampleData() {
//     return new TimeSeriesBar(
//       _createSampleData(),
//       // Disable animations for image tests.
//       animate: false,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new charts.TimeSeriesChart(
//       seriesList,
//       animate: animate,
//       // Set the default renderer to a bar renderer.
//       // This can also be one of the custom renderers of the time series chart.
//       defaultRenderer: new charts.BarRendererConfig<DateTime>(),
//       // It is recommended that default interactions be turned off if using bar
//       // renderer, because the line point highlighter is the default for time
//       // series chart.
//       defaultInteractions: false,
//       // If default interactions were removed, optionally add select nearest
//       // and the domain highlighter that are typical for bar charts.
//       behaviors: [new charts.SelectNearest(), new charts.DomainHighlighter()],
//     );
//   }
//
//   /// Create one series with sample hard coded data.
//   static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
//     final data = [
//       new TimeSeriesSales(new DateTime(2017, 9, 1), 5),
//       new TimeSeriesSales(new DateTime(2017, 9, 2), 5),
//       new TimeSeriesSales(new DateTime(2017, 9, 3), 25),
//       new TimeSeriesSales(new DateTime(2017, 9, 4), 100),
//       new TimeSeriesSales(new DateTime(2017, 9, 5), 75),
//       new TimeSeriesSales(new DateTime(2017, 9, 6), 88),
//       new TimeSeriesSales(new DateTime(2017, 9, 7), 65),
//       new TimeSeriesSales(new DateTime(2017, 9, 8), 91),
//       new TimeSeriesSales(new DateTime(2017, 9, 9), 100),
//       new TimeSeriesSales(new DateTime(2017, 9, 10), 111),
//       new TimeSeriesSales(new DateTime(2017, 9, 11), 90),
//       new TimeSeriesSales(new DateTime(2017, 9, 12), 50),
//       new TimeSeriesSales(new DateTime(2017, 9, 13), 40),
//       new TimeSeriesSales(new DateTime(2017, 9, 14), 30),
//       new TimeSeriesSales(new DateTime(2017, 9, 15), 40),
//       new TimeSeriesSales(new DateTime(2017, 9, 16), 50),
//       new TimeSeriesSales(new DateTime(2017, 9, 17), 30),
//       new TimeSeriesSales(new DateTime(2017, 9, 18), 35),
//       new TimeSeriesSales(new DateTime(2017, 9, 19), 40),
//       new TimeSeriesSales(new DateTime(2017, 9, 20), 32),
//       new TimeSeriesSales(new DateTime(2017, 9, 21), 31),
//     ];
//
//     return [
//       new charts.Series<TimeSeriesSales, DateTime>(
//         id: 'Sales',
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//         domainFn: (TimeSeriesSales sales, _) => sales.time,
//         measureFn: (TimeSeriesSales sales, _) => sales.sales,
//         data: data,
//       )
//     ];
//   }
// }
//
// /// Sample time series data type.
// class TimeSeriesSales {
//   final DateTime time;
//   final int sales;
//
//   TimeSeriesSales(this.time, this.sales);
// }

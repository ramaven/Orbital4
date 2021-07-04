// import 'package:intl/intl.dart';
//
// class Datum {
//   Datum({this.date, this.level});
//
//   final DateTime date;
//   final double level;
//
//   Datum.fromJson(Map<String, dynamic> json)
//       // : date = DateTime.parse(json['date']),
//       : date = new DateFormat("dd/MM/yyyy")
//             .parse(json['day'] + "/" + json['month'] + "/" + json['year']),
//         level = json['level'].toDouble();
// }

class Datum {
  Datum({this.date, this.close});

  final DateTime date;
  final double close;

  Datum.fromJson(Map<String, dynamic> json)
      : date = DateTime.parse(json['date']),
        close = json['close'].toDouble();
}

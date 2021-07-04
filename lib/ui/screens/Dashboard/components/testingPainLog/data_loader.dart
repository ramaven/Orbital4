// import 'dart:async';
// import 'dart:convert' show jsonDecode;
// import 'package:flutter/services.dart' show rootBundle;
//
// import 'datum.dart';
//
// import 'package:flutter/material.dart';
// import 'package:login_register_auth/globals.dart' as globals;
// import 'dart:collection';
//
// Future<List<Datum>> loadStockData() async {
//   List<Map<String, dynamic>> painLogs;
//   painLogs = globals.Userprofile.painLogs;
//
//   List<Datum> dataList = [];
//
//   for (int i = 0; i < painLogs.length; i++) {
//     Map<String, dynamic> curLog = painLogs[i];
//     dataList.add(Datum.fromJson(curLog));
//   }
//   return dataList;
// }
//
// // Future<List<Datum>> loadStockData() async {
// //   final String fileContent = await rootBundle.loadString('assets/data.json');
// //   final List<dynamic> data = jsonDecode(fileContent);
//
// // Format of json: Map<String, dynamic>
// //   return data.map((json) => Datum.fromJson(json)).toList();
// // }

import 'dart:async';
import 'dart:convert' show jsonDecode;
import 'package:flutter/services.dart' show rootBundle;
import 'package:login_register_auth/ui/screens/Dashboard/components/testingPainLog/datum.dart';

//import 'package:fluttersafari/datum.dart';

Future<List<Datum>> loadStockData() async {
  final String fileContent = await rootBundle.loadString('assets/data.json');
  final List<dynamic> data = jsonDecode(fileContent);
  return data.map((json) => Datum.fromJson(json)).toList();
}

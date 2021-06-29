import 'package:flutter/material.dart';
import 'package:login_register_auth/ui/screens/TrackPain/all_pain_logs.dart';
import 'package:login_register_auth/ui/screens/TrackPain/new_pain_log.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'Components/pain_log_box.dart';

class TrackPainBackground extends StatefulWidget {
  const TrackPainBackground({Key key}) : super(key: key);
  static const routeName = '/trackpainpage';

  @override
  _TrackPainBackgroundState createState() => _TrackPainBackgroundState();
}

class _TrackPainBackgroundState extends State<TrackPainBackground> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SfCalendar(
            view: CalendarView.week,
            firstDayOfWeek: 7,
            initialSelectedDate: DateTime.now(),
            dataSource: PainLogSource(getPainLog()),
          ),
          SizedBox(height: size.height * 0.03),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pain Diary Entries",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AllPainLogs.routeName);
                  },
                  child: Text("View All Entries")),
              SizedBox(height: size.height * 0.01),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(NewPainLogScreen.routeName);
                  },
                  child: Text(" Add New Entry"))
            ],
          ),
          SizedBox(height: size.height * 0.03),
          Container(
            width: size.width * 0.95,
            height: size.height * 0.10,
            margin: const EdgeInsets.all((10)),
            decoration: BoxDecoration(
              color: Colors.yellow[200],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(" The calendar feature is still under construction."),
              Text("You can currently add new entries, view them"),
              Text("and see a summary in the Home tab."),
            ]),
          ),
          //createPainLogArray()
        ],
      ),
    );
  }
}

class PainLogSource extends CalendarDataSource {
  PainLogSource(List<Appointment> source) {
    appointments = source;
  }
}

class PainLog extends Appointment {
  //final String bodyPart;
  final int painLevel = 0;
  final int duration = 0;
  final String otherSymptoms = 'NIL';
  final String medication = 'NIL';

  PainLog(DateTime startTime, DateTime endTime, String bodypart, int painLevel,
      int duration, String otherSymptoms, String medication) {
    startTime = this.startTime;
    endTime = this.endTime;
    subject = bodypart;
    color = Colors.orange;
    painLevel = this.painLevel;
    duration = this.duration;
    otherSymptoms = this.otherSymptoms;
    medication = this.medication;
  }
}

List<Appointment> getPainLog() {
  List<Appointment> painLogs = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 1));

  painLogs.add(Appointment(
    startTime: startTime,
    endTime: endTime,
    subject: 'Pain',
    color: Colors.blue,
    isAllDay: true,
  ));

  return painLogs;
}

Expanded createPainLogArray() {
  List<PainLogBox> painChildren = <PainLogBox>[];
  painChildren.add(new PainLogBox(
      date: "28/06/2021",
      bodyPart: "Eyes",
      painLevel: 5,
      duration: 35,
      otherSymptoms: "NIL",
      medicine: "Aspirin"));

  return Expanded(
    child: ListView(
      children: painChildren,
    ),
  );
}

import 'package:flutter/material.dart';

class PainLogBox extends StatelessWidget {
  final String date;
  final String bodyPart;
  final int painLevel;
  final int duration;
  final String otherSymptoms;
  final String medicine;
  const PainLogBox({
    Key key,
    this.date,
    this.bodyPart,
    this.painLevel,
    this.duration,
    this.otherSymptoms,
    this.medicine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      height: size.height * 0.12,
      margin: const EdgeInsets.all((10)),
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Area: $bodyPart, Pain Level: $painLevel",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          Text("Date: $date"),
          Text("Duration: $duration minutes"),
          Text("Medicines taken: $medicine"),
          Text("Other symptoms: $otherSymptoms"),
        ],
      ),
      //SizedBox(height: size.height * 0.01),
    );
  }
}

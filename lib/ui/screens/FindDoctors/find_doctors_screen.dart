import 'package:flutter/material.dart';
import "dart:collection";

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_register_auth/ui/screens/FindDoctors/all_clinics_screen.dart';
import 'package:login_register_auth/ui/screens/FindDoctors/map_all_screen.dart';
import 'package:login_register_auth/ui/screens/FindDoctors/saved_clinics_screen.dart';

class FindDoctorsBackground extends StatefulWidget {
  const FindDoctorsBackground({Key key}) : super(key: key);

  @override
  _FindDoctorsBackgroundState createState() => _FindDoctorsBackgroundState();
}

class _FindDoctorsBackgroundState extends State<FindDoctorsBackground> {
  int screen = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: [
      Container(
        //color: Colors.blueGrey,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextButton(
              onPressed: () {
                setState(() {
                  screen = 0;
                });
              },
              child: Text(
                " All clinics ",
                style: TextStyle(color: Colors.black),
              ),
              style: ButtonStyle(
                  backgroundColor: screen == 0
                      ? MaterialStateProperty.all(Colors.lightBlue[100])
                      : MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.grey))))),
          TextButton(
              onPressed: () {
                setState(() {
                  screen = 1;
                });
              },
              child:
                  Text("     Map     ", style: TextStyle(color: Colors.black)),
              style: ButtonStyle(
                  backgroundColor: screen == 1
                      ? MaterialStateProperty.all(Colors.lightBlue[100])
                      : MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.grey))))),
          TextButton(
              onPressed: () {
                setState(() {
                  screen = 2;
                });
              },
              child:
                  Text("    Saved    ", style: TextStyle(color: Colors.black)),
              style: ButtonStyle(
                  backgroundColor: screen == 2
                      ? MaterialStateProperty.all(Colors.lightBlue[100])
                      : MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.grey))))),
        ]),
      ),
      SizedBox(
        height: size.height * 0.01,
      ),
      (screen == 0)
          ? AllClinicsScreen()
          : (screen == 1)
              ? MapAllClinicsScreen()
              : SavedClinicsScreen(),
      // Expanded(
      //   child: SingleChildScrollView(
      //     child: Container(
      //       height: size.height * 0.8,
      //       child: GoogleMap(
      //         initialCameraPosition: CameraPosition(
      //             bearing: 192.8334901395799,
      //             target: LatLng(37.43296265331129, -122.08832357078792),
      //             tilt: 59.440717697143555,
      //             zoom: 19.151926040649414),
      //       ),
      //       //Text("To be completed by 1st August"),
      //     ),
      //   ),
      // ),
    ]);
  }
}

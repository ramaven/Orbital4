import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_register_auth/ui/screens/FindDoctors/all_clinics_screen.dart';

import 'clinic_model.dart';

class MapAllClinicsScreen extends StatefulWidget {
  const MapAllClinicsScreen({Key key}) : super(key: key);

  @override
  _MapAllClinicsScreenState createState() => _MapAllClinicsScreenState();
}

class _MapAllClinicsScreenState extends State<MapAllClinicsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //
    // List<Clinic> clinicList = [];
    // int clinicID = 0;
    // for (Map<String, Object> clinic in data) {
    //   clinicList.add(Clinic(
    //       clinicID,
    //       clinic['Description'],
    //       clinic['Contact'],
    //       clinic['Postal'],
    //       clinic['Block'],
    //       clinic['Floor'],
    //       clinic['Unit'],
    //       clinic['Street'],
    //       clinic['Building'],
    //       clinic['Coordinates']));
    //   clinicID++;
    // }

    return Expanded(
      //child: SingleChildScrollView(
      child: Container(
        height: size.height * 0.8,
        child: mapWithMarkers,
        // GoogleMap(
        //   markers: createAllMarkers(clinicList),
        //   initialCameraPosition: CameraPosition(
        //       bearing: 192.8334901395799,
        //       target: LatLng(1.319728, 103.8421),
        //       tilt: 59.440717697143555,
        //       zoom: 16.151926040649414),
        // ),
      ),
      // ),
    );
  }

  // Set<Marker> createAllMarkers(List<Clinic> clinicList) {
  //   List<Marker> markers = [];
  //
  //   for (Clinic clinic in clinicList) {
  //     String name = clinic.name;
  //     List<double> coords = clinic.coordinates;
  //
  //     markers.add(Marker(
  //         markerId: MarkerId(name), position: LatLng(coords[1], coords[0])));
  //   }
  //
  //   return markers.toSet();
  // }
}
//
// class MapWithMarkers extends StatelessWidget {
//   const MapWithMarkers({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

final GoogleMap mapWithMarkers = GoogleMap(
  markers: createAllMarkers(),
  initialCameraPosition: CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(1.319728, 103.8421),
      tilt: 59.440717697143555,
      zoom: 16.151926040649414),
);

Set<Marker> createAllMarkers() {
  List<Clinic> clinicList = [];
  int clinicID = 0;
  for (Map<String, Object> clinic in data) {
    clinicList.add(Clinic(
        clinicID,
        clinic['Description'],
        clinic['Contact'],
        clinic['Postal'],
        clinic['Block'],
        clinic['Floor'],
        clinic['Unit'],
        clinic['Street'],
        clinic['Building'],
        clinic['Coordinates']));
    clinicID++;
  }

  List<Marker> markers = [];

  for (Clinic clinic in clinicList) {
    String name = clinic.name;
    List<double> coords = clinic.coordinates;

    markers.add(Marker(
        markerId: MarkerId(name), position: LatLng(coords[1], coords[0])));
  }

  return markers.toSet();
}

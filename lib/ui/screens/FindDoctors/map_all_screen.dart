import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

    return Expanded(
      //child: SingleChildScrollView(
      child: Container(
        height: size.height * 0.8,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(1.319728, 103.8421),
              tilt: 59.440717697143555,
              zoom: 19.151926040649414),
        ),
      ),
      // ),
    );
  }
}

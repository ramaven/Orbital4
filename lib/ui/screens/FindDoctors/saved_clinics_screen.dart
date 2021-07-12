import 'package:flutter/material.dart';

class SavedClinicsScreen extends StatefulWidget {
  const SavedClinicsScreen({Key key}) : super(key: key);

  @override
  _SavedClinicsScreenState createState() => _SavedClinicsScreenState();
}

class _SavedClinicsScreenState extends State<SavedClinicsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Saved Clinics"),
    );
  }
}

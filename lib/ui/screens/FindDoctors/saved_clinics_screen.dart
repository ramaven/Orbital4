import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_register_auth/globals.dart' as globals;
import 'package:login_register_auth/ui/screens/FindDoctors/clinic_model.dart';
import 'package:login_register_auth/ui/screens/FindDoctors/all_clinics_screen.dart';

class SavedClinicsScreen extends StatefulWidget {
  const SavedClinicsScreen({Key key}) : super(key: key);

  @override
  _SavedClinicsScreenState createState() => _SavedClinicsScreenState();
}

class _SavedClinicsScreenState extends State<SavedClinicsScreen> {
  String savedClinicsID;
  String userID;
  final ScrollController _scrollController = ScrollController();
  CollectionReference usersCol = Firestore.instance.collection("users");
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    setState(() {
      globals.Userprofile.get();
      savedClinicsID = globals.Userprofile.savedClinics;
      //userID = globals.Userprofile.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Clinic> savedClinicList = generateSavedClinicsListings(savedClinicsID);
    // globals.Userprofile.get();
    // savedClinicsID = globals.Userprofile.savedClinics;

    globals.Userprofile.get().then((response) {
      setState(() {
        savedClinicsID = globals.Userprofile.savedClinics;
      });
    });

    return
        // Container(
        // child:
        Expanded(
      child: Scrollbar(
        isAlwaysShown: true,
        controller: _scrollController,
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.all(8),
          children: generateClinicListings(savedClinicList, size),
        ),
      ),
    );
  }

  List<Clinic> generateSavedClinicsListings(String savedClinicsID) {
    List<Clinic> savedClinicsList = [];

    for (int i = 0; i < savedClinicsID.length; i++) {
      if (savedClinicsID[i].compareTo("1") == 0) {
        var clinic = data[i];
        savedClinicsList.add(Clinic(
            i,
            clinic['Description'],
            clinic['Contact'],
            clinic['Postal'],
            clinic['Block'],
            clinic['Floor'],
            clinic['Unit'],
            clinic['Street'],
            clinic['Building'],
            clinic['Coordinates']));
      }
    }
    return savedClinicsList;
  }

  List<Container> generateClinicListings(List<Clinic> clinicList, Size size) {
    List<Container> clinicBoxList = [];
    for (Clinic clinic in clinicList) {
      clinicBoxList.add(makeClinicBox(clinic, size));
    }
    return clinicBoxList;
  }

  Container makeClinicBox(Clinic clinic, Size size) {
    List<double> coords = clinic.coordinates;
    // print(coords);
    // print(coords[0]);
    // print(coords[1]);

    return Container(
      //padding: const EdgeInsets.all(3),
      child: Column(children: [
        Container(
          width: size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.lightGreen[100],
          ),
          padding: const EdgeInsets.all(8),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: size.width * 0.7,
                  child: Text(
                    clinic.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  clinic.street,
                  style: TextStyle(fontSize: 11),
                ),
                SizedBox(height: 15),
                SizedBox(
                  height: 30,
                  child: TextButton(
                      onPressed: () {
                        // show a pop up that displays addresss and map
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(clinic.name),
                                content: Column(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Address",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          "Block ${clinic.block}, ${clinic.street}"),
                                      Text(
                                          '${clinic.floor}-${clinic.unit} ${clinic.building}'),
                                      Text("Singapore ${clinic.postal}"),
                                      SizedBox(height: 10),
                                      Text(
                                        "Contact:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(clinic.contact),
                                      SizedBox(height: 10),
                                      Expanded(
                                        //child: SingleChildScrollView(
                                        child: Container(
                                          height: size.height * 0.8,
                                          child: GoogleMap(
                                            markers: [
                                              Marker(
                                                  markerId:
                                                      MarkerId(clinic.name),
                                                  position: LatLng(
                                                      coords[1], coords[0]))
                                            ].toSet(),
                                            initialCameraPosition:
                                                CameraPosition(
                                                    bearing: 192.8334901395799,
                                                    // target:
                                                    //     LatLng(1.319728, 103.8421),
                                                    target: LatLng(
                                                        coords[1], coords[0]),
                                                    tilt: 59.440717697143555,
                                                    zoom: 17),
                                          ),
                                        ),
                                        // ),
                                      )
                                    ]),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        //print(coords);
                                      },
                                      child: Text('OK'))
                                ],
                              );
                            });
                      },
                      child: Text(
                        "More details",
                        style: TextStyle(color: Colors.blue[900], fontSize: 12),
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.blue[900]))))),
                ),
                SizedBox(
                  height: 10,
                ),
                // Text("Block ${clinic.block}, ${clinic.street}"),
                // Text('${clinic.floor}-${clinic.unit} ${clinic.building}'),
                // Text("Singapore ${clinic.postal}"),
                // Text("Contact: ${clinic.contact}"),
              ],
            ),
            IconButton(
                icon: Icon(
                  Icons.remove_circle_outline,
                  //size: 30,
                ),
                onPressed: () async {
                  //ADD TO SAVED DOCS
                  // ADD TO FIREBASE
                  String newSavedClinics =
                      replaceCharAt(savedClinicsID, clinic.clinicID, "0");

                  final FirebaseUser curUser = await auth.currentUser();

                  usersCol.document(curUser.uid).get().then((docSnapshot) => {
                        if (docSnapshot.exists)
                          {
                            usersCol
                                .document(curUser.uid)
                                .setData({'savedClinics': newSavedClinics},
                                    merge: true)
                                .then((value) =>
                                    print("Removed clinic from saved clinics"))
                                .catchError((error) => print(error.toString()))
                          }
                        else
                          {
                            usersCol
                                .document(curUser.uid)
                                .setData({'savedClinics': newSavedClinics})
                                .then((value) =>
                                    print("Removed clinic from saved clinics"))
                                .catchError((error) => print(error.toString()))
                          }
                      });

                  // setState(() {
                  //   globals.Userprofile.get();
                  //   savedClinicsID = globals.Userprofile.savedClinics;
                  //   //userID = globals.Userprofile.uid;
                  // });

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Removed Clinic'),
                          content: Text('Removed clinic from Saved Clinics'),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'))
                          ],
                        );
                      });

                  // 1165 entries in clinics dataset
                })
          ]),
        ),
        SizedBox(height: 25),
      ]),
    );
  }
}

String replaceCharAt(String oldString, int index, String newChar) {
  return oldString.substring(0, index) +
      newChar +
      oldString.substring(index + 1);
}

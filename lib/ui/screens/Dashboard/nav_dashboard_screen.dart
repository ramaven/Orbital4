import 'package:flutter/material.dart';
import 'package:login_register_auth/ui/screens/Community/community_screen.dart';
import 'package:login_register_auth/ui/screens/Dashboard/dashboard_body.dart';
import 'package:login_register_auth/services/auth.dart';
import 'package:login_register_auth/ui/screens/FindDoctors/find_doctors_screen.dart';
import 'package:login_register_auth/ui/screens/Profile/profile_screen.dart';
import 'package:login_register_auth/ui/screens/Settings/settings_screen.dart';
import 'package:login_register_auth/ui/screens/TrackPain/track_pain_screen.dart';

import 'components/all.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//import 'package:flutter/rendering.dart';

// // (col, row)
// List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
//   // Upcoming appointments
//   const StaggeredTile.count(4, 1.2),
//   // Daily pain logs
//   const StaggeredTile.count(4, 2.2),
//   // Relief from med
//   const StaggeredTile.count(2, 2.2),
//   // Pain composition
//   const StaggeredTile.count(2, 2.2),
//   // Activity bar graph
//   const StaggeredTile.count(4, 2.2),
// ];
//
// List<Widget> _tiles = const <Widget>[
//   // Upcoming appointments
//   const Appointments(),
//   // Daily pain logs
//   const Pain_Logs(),
//   // Relief from med
//   const MedicineRelief(),
//   // Pain composition
//   const Pain_Composition(),
//   // Activity bar graph
//   const Activity()
// ];

class DashboardScreen extends StatefulWidget {
  //const LoginScreen({Key key}) : super(key: key);
  static const routeName = '/home';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  AuthBase authBase = AuthBase();
  final GlobalKey<FormState> _formKey = GlobalKey();
  Text titleText = Text("Dashboard");
  int _currentIndex = 0;
  Widget childScreen = DashboardBackground();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleText,
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        leading: IconButton(
            icon: Icon(Icons.person_pin),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProfileScreen.routeName);
            }),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(SettingsScreen.routeName);
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: childScreen,
        ),
      ),
      // End of top bar

      // Start of bottom bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[500],
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: "Track Pain"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_search_sharp), label: "Find Doctors"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Community"),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;

            switch (index) {
              case 0:
                childScreen = DashboardBackground();
                titleText = Text("Dashboard");
                break;
              case 1:
                childScreen = TrackPainBackground();
                titleText = Text("Track Your Pain");
                break;
              case 2:
                childScreen = FindDoctorsBackground();
                titleText = Text("Find Doctors");
                break;
              case 3:
                childScreen = CommunityBackground();
                titleText = Text("Community");
                break;
            }
          });
        },
      ),
    );
  }
}

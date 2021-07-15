//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:login_register_auth/globals.dart' as globals;
//
// import './news_model.dart';
// import './mockData.dart' as news;
//
// class CommunityBackground extends StatefulWidget {
//   const CommunityBackground({Key key}) : super(key: key);
//
//   @override
//   _CommunityBackgroundState createState() => _CommunityBackgroundState();
// }
//
// class _CommunityBackgroundState extends State<CommunityBackground> {
//   final ScrollController _scrollController = ScrollController();
//   final formkey = GlobalKey<FormState>();
//   String filterResult;
//   List<String> filterResultList;
//
//   String userID;
//   String savedNews;
//
//   CollectionReference usersCol = Firestore.instance.collection("users");
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   List<News> newsList = [];
//
//   @override
//   void initState() {
//     setState(() {
//       globals.Userprofile.get();
//       savedNews = globals.Userprofile.savedNews;
//       userID = globals.Userprofile.uid;
//       newsList = [];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     int newsID = 0;
//     for (Map<String, Object> news in news.data) {
//       newsList.add(News(
//         newsID,
//         news['author'],
//         news['title'],
//         news['description'],
//         news['url'],
//         news['urlToImage'],
//       ));
//       newsID++;
//     }
//     print("this is the newslist length");
//     print(newsList.length);
//     // for (News news in newsList) {
//     //   print(news.title);
//     // }
//
//     bool newsContains(String input) {
//       for (String filterWord in filterResultList) {
//         if (!input.contains(filterWord.trim())) {
//           return false;
//         }
//       }
//       return true;
//     }
//
//     return Column(children: [
//       TextButton(
//           onPressed: () {
//             return showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   newsList = [];
//                   return AlertDialog(
//                       contentPadding: const EdgeInsets.all(16.0),
//                       content: Container(
//                           child: Builder(
//                         builder: (context) => Form(
//                           key: formkey,
//                           child: Column(children: <Widget>[
//                             TextFormField(
//                                 enabled: true,
//                                 autofocus: true,
//                                 decoration: new InputDecoration(
//                                     labelText: 'Keywords to filter',
//                                     hintText: 'eg. Diet'),
//                                 onSaved: (val) => {
//                                       // save the value
//                                       this.filterResult = val,
//                                     }),
//                             FlatButton(
//                               onPressed: () {
//                                 final form = formkey.currentState;
//                                 form.save();
//                                 if (filterResult != null) {
//                                   filterResultList = filterResult.split(',');
//                                   print(filterResultList);
//                                   print("this is the newslist length original");
//                                   print(newsList.length);
//                                   List<News> copiedNewsList = []
//                                     ..addAll(newsList);
//                                   print(copiedNewsList);
//                                   for (Map<String, Object> news in news.data) {
//                                     String newsAuthor = (news['author'] != null)
//                                         ? news['author'].toString()
//                                         : '';
//                                     String newsTitle = (news['title'] != null)
//                                         ? news['title'].toString()
//                                         : '';
//                                     String newsDescription =
//                                         (news['description'] != null)
//                                             ? news['description'].toString()
//                                             : '';
//
//                                     String compiled = newsAuthor +
//                                         ' ' +
//                                         newsTitle +
//                                         ' ' +
//                                         newsDescription;
//                                     print(newsContains(compiled));
//                                     if (!newsContains(compiled)) {
//                                       // copiedNewsList.removeWhere(
//                                       //     (news) => news.title == news.title);
//                                       copiedNewsList.remove(news);
//                                       print("removing~");
//                                       print(copiedNewsList.length);
//                                     }
//                                   }
//                                   print('this is copiedNewsList');
//                                   print(copiedNewsList);
//                                   setState(() {
//                                     newsList = copiedNewsList;
//                                   });
//                                   Navigator.pop(context);
//                                 }
//                               },
//                               child: new Text('SEND'),
//                             ),
//                           ]),
//                         ),
//                       )),
//                       actions: <Widget>[
//                         new FlatButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: Text('CANCEL'),
//                         ),
//                       ]);
//                 });
//           },
//           child: new Text("Filter")),
//       Expanded(
//         child: Scrollbar(
//           isAlwaysShown: true,
//           controller: _scrollController,
//           child: ListView(
//             controller: _scrollController,
//             padding: const EdgeInsets.all(8),
//             children: generateNewsListings(newsList, size),
//           ),
//         ),
//       ),
//     ]);
//     // );
//   }
//
//   List<Container> generateNewsListings(List<News> newsList, Size size) {
//     List<Container> newsBoxList = [];
//     for (News news in newsList) {
//       newsBoxList.add(makeNewsBox(news, size));
//     }
//     return newsBoxList;
//   }
//
//   Container makeNewsBox(News news, Size size) {
//     return Container(
//       child: Column(children: [
//         Container(
//           width: size.width * 0.9,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(15)),
//             color: Colors.lightBlue[50],
//           ),
//           padding: const EdgeInsets.all(8),
//           child:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             SizedBox(
//               width: 5,
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 10,
//                 ),
//
//                 // Title of news
//                 Container(
//                   width: size.width * 0.7,
//                   child: Text(
//                     news.title != null ? news.title : '',
//                     style: TextStyle(
//                         decoration: TextDecoration.underline, fontSize: 16),
//                   ),
//                 ),
//                 SizedBox(height: 1),
//
//                 Container(
//                   width: size.width * 0.7,
//                   child: news.imageLink != null
//                       ? Image.network(news.imageLink.toString())
//                       : Image.network(
//                           'https://winmr.com/wp-content/uploads/2019/04/health-wellness.jpg'),
//                 ),
//                 SizedBox(height: 1),
//
//                 // Description of news
//                 Container(
//                   width: size.width * 0.7,
//                   child: Text(
//                     news.description != null ? news.description : '',
//                     style: TextStyle(fontSize: 13),
//                   ),
//                 ),
//
//                 TextButton(
//                     child:
//                         Text('Click here to read this article in your browser'),
//                     style: TextButton.styleFrom(
//                       primary: Colors.white,
//                       backgroundColor: Colors.teal,
//                       onSurface: Colors.grey,
//                     ),
//                     onPressed: () {
//                       launch(news.link);
//                     }),
//
//                 SizedBox(height: 15),
//                 SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           ]),
//         ),
//         SizedBox(height: 25),
//       ]),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:login_register_auth/ui/screens/Community/all_news_screen.dart';
import 'package:login_register_auth/ui/screens/Community/saved_news_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:login_register_auth/globals.dart' as globals;

import './news_model.dart';
import './mockData.dart' as news;

class CommunityBackground extends StatefulWidget {
  const CommunityBackground({Key key}) : super(key: key);

  @override
  _CommunityBackgroundState createState() => _CommunityBackgroundState();
}

class _CommunityBackgroundState extends State<CommunityBackground> {
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
                  globals.Userprofile.get();
                });
              },
              child: Text(
                " All News ",
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
              child: Text(" Saved News", style: TextStyle(color: Colors.black)),
              style: ButtonStyle(
                  backgroundColor: screen == 1
                      ? MaterialStateProperty.all(Colors.lightBlue[100])
                      : MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.grey))))),
          // TextButton(
          //     onPressed: () {
          //       setState(() {
          //         screen = 2;
          //       });
          //     },
          //     child:
          //     Text("    Saved    ", style: TextStyle(color: Colors.black)),
          //     style: ButtonStyle(
          //         backgroundColor: screen == 2
          //             ? MaterialStateProperty.all(Colors.lightBlue[100])
          //             : MaterialStateProperty.all(Colors.white),
          //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //             RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(18.0),
          //                 side: BorderSide(color: Colors.grey))))),
        ]),
      ),
      SizedBox(
        height: size.height * 0.01,
      ),
      (screen == 0) ? AllNewsScreen() : SavedNewsScreen(),
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

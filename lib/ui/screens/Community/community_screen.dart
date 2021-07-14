// import 'package:flutter/material.dart';
//
// class CommunityBackground extends StatefulWidget {
//   const CommunityBackground({Key key}) : super(key: key);
//
//   @override
//   _CommunityBackgroundState createState() => _CommunityBackgroundState();
// }
//
// class _CommunityBackgroundState extends State<CommunityBackground> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(child: Text("To be completed by 1st August"));
//   }
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import './news_model.dart';
import './mockData.dart' as news;

class CommunityBackground extends StatefulWidget {
  const CommunityBackground({Key key}) : super(key: key);

  @override
  _CommunityBackgroundState createState() => _CommunityBackgroundState();
}

class _CommunityBackgroundState extends State<CommunityBackground> {
  final ScrollController _scrollController = ScrollController();
  var result;
  List<String> resList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<News> newsList = [];
    for (Map<String, Object> news in news.data) {
      newsList.add(News(
        news['author'],
        news['title'],
        news['description'],
        news['url'],
        news['urlToImage'],
      ));
    }

    return Column(children: <Widget>[
      TextButton(
          onPressed: () {
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(16.0),
                    content: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new TextField(
                            autofocus: true,
                            decoration: new InputDecoration(
                                labelText: 'Keywords to filter',
                                hintText: 'eg. Diet'),
                          ),
                          // SOMEWHERE HERE I NEED TO SAVE THE RESULTS KEYED IN BY USER
                          // BTW NEED TO REMIND USERS TO SEAPRATE THEIR KEYOWRDS BY COMMAS
                          // SO result = RESULT
                          // resList = result.split('.');
                          // then somehow need to re-add all the news into the list while filtering, change the list of news
                          // MAYBE JUST RUN THIS FOR LOOP AGAIN. but idk how to reload the page..
                          // for (Map<String, Object> news in news.data) {
                          //     newsList.add(News(
                          //     news['author'],
                          //     news['title'],
                          //     news['description'],
                          //     news['url'],
                          //     news['urlToImage'],
                          //   ));
                          // }
                        )
                      ],
                    ),
                    actions: <Widget>[
                      new FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: new Text('CANCEL'),
                      ),
                      new FlatButton(
                        onPressed: () {
                          Form.of(context).save();
                          Navigator.pop(context, result);
                        },
                        child: new Text('SEND'),
                      ),
                    ],
                  );
                });
          },
          child: new Text("Filter")),
      Expanded(
        child: Scrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.all(8),
            children: generateNewsListings(newsList, size),
          ),
        ),
      ),
    ]);
    // );
  }

  List<Container> generateNewsListings(List<News> newsList, Size size) {
    List<Container> newsBoxList = [];
    for (News news in newsList) {
      newsBoxList.add(makeNewsBox(news, size));
    }
    return newsBoxList;
  }

  Container makeNewsBox(News news, Size size) {
    return Container(
      child: Column(children: [
        Container(
          width: size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.lightBlue[50],
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

                // Title of news
                Container(
                  width: size.width * 0.7,
                  child: Text(
                    news.title != null ? news.title : '',
                    style: TextStyle(
                        decoration: TextDecoration.underline, fontSize: 16),
                  ),
                ),
                SizedBox(height: 1),

                Container(
                  width: size.width * 0.7,
                  child: news.imageLink != null
                      ? Image.network(news.imageLink.toString())
                      : Image.network(
                          'https://winmr.com/wp-content/uploads/2019/04/health-wellness.jpg'),
                ),
                SizedBox(height: 1),

                // Description of news
                Container(
                  width: size.width * 0.7,
                  child: Text(
                    news.description != null ? news.description : '',
                    style: TextStyle(fontSize: 13),
                  ),
                ),

                TextButton(
                    child:
                        Text('Click here to read this article in your browser'),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () async {
                      await canLaunch(news.link)
                          ? await launch(news.link)
                          : throw 'could not launch url';
                    }),

                SizedBox(height: 15),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ]),
        ),
        SizedBox(height: 25),
      ]),
    );
  }
}

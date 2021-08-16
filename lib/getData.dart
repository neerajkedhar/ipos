import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dio/dio.dart';

class CategoryServices {
  FirebaseFirestore? _instance;

  var liveIPOlist;
  Future getFromLiveIPOFireStore() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection("ipos");
    DocumentSnapshot snapshot = await categories.doc("current-ipos").get();
    var data = snapshot.data() as Map;
    var ipos = data.values.toList();
    liveIPOlist = new List.from(ipos.reversed);

    for (var i = 0; i < liveIPOlist.length; i++) {}

    getFromUpcomingIPOFireStore();
    return liveIPOlist;
  }

  var upcomingIPOList;
  Future getFromUpcomingIPOFireStore() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection("ipos");
    DocumentSnapshot snapshot = await categories.doc("upcoming-ipo").get();
    var data = snapshot.data() as Map;
    var ipos = data.values.toList();
    upcomingIPOList = new List.from(ipos.reversed);

    return liveIPOlist;
  }

  var listedIPOList;
  Future getFromListedIPOFireStore() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection("ipos");
    DocumentSnapshot snapshot = await categories.doc("listed-ipos").get();
    var data = snapshot.data() as Map;
    var ipos = data.values.toList();
    listedIPOList = new List.from(ipos.reversed);
    // GetNews().getHttp();
    return listedIPOList;
  }
}

//https://newsapi.org/v2/everything?q=moneycontrol%20ipos&apiKey=746a076d37f241f2acf59c8d6920ed75

class GetNews {
  var newsList;
  Future getHttp() async {
    try {
      var moneyresponse = await Dio().get(
          'https://newsapi.org/v2/everything?q=ipos%20news%20in%20india&from=2021-07-03&sortBy=publishedAt&apiKey=746a076d37f241f2acf59c8d6920ed75');
      var mcnewsData = moneyresponse.data['articles'];
      newsList = mcnewsData;
      print(newsList);
    } catch (e) {
      print(e);
    }
    // getFromListedIPOFireStore();
  }

  var iposNewsList;

  FirebaseFirestore? _instance;
  Future getFromIPONewsFireStore() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection("ipos");
    DocumentSnapshot snapshot = await categories.doc("ipos-news").get();
    var data = snapshot.data() as Map;
    iposNewsList = data.values.toList();

    print(data);
    return data;
  }
}

class SetNews {
  CollectionReference users = FirebaseFirestore.instance.collection('ipos');

  Future addUser(
      var index, source, title, description, urlimage, url, date) async {
    print("$index");
    return users
        .doc("ipos-news")
        .update({
          "$index": {
            "source": source,
            "title": title,
            "description": description,
            "urlToImage": urlimage,
            "url": url,
          },
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ipos/test/boardApp.dart';
import 'package:ipos/getData.dart';
// import 'package:ipos/test/some.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage(this.index, {Key? key}) : super(key: key);
  int index;
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  // late List<charts.Series> sriesList;

  // barChart() {
  //   return charts.BarChart(sriesList, animate: true, vertical: true);
  // }

  late TabController _controller;
  late TabController _controller1;
  @override
  void initState() {
    super.initState();
    //  sriesList = _createRandomData();
    _controller = TabController(length: 3, vsync: this);
    _controller1 = TabController(length: 3, vsync: this);
  }

  CategoryServices cats = new CategoryServices();
  @override
  Widget build(BuildContext context) {
    print(cats.listt);
    return Scaffold(
        appBar: AppBar(
          title: Text("app"),
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Container(
                height: 100,
                color: Colors.grey,
              ),
              Container(
                  child: Column(children: [
                TabBar(controller: _controller1, tabs: [
                  Tab(
                    text: "gggg",
                  ),
                  Tab(
                    text: "gggg",
                  ),
                  Tab(
                    text: "gggg",
                  )
                ]),
                SizedBox(
                  height: 300,
                  child: TabBarView(controller: _controller1, children: [
                    Container(
                      height: 300,
                      width: 300,
                      color: Colors.pink,
                    ),
                    Container(
                      height: 300,
                      width: 300,
                      color: Colors.green,
                    ),
                    Container(
                      height: 300,
                      width: 300,
                      color: Colors.blue,
                    ),
                  ]),
                )
              ])),
              Container(
                  child: Column(children: [
                TabBar(controller: _controller, tabs: [
                  Tab(
                    text: "gggg",
                  ),
                  Tab(
                    text: "gggg",
                  ),
                  Tab(
                    text: "gggg",
                  )
                ]),
                SizedBox(
                  height: 300,
                  child: TabBarView(controller: _controller, children: [
                    Container(
                      height: 300,
                      width: 300,
                      color: Colors.pink,
                    ),
                    Container(
                      height: 300,
                      width: 300,
                      color: Colors.green,
                    ),
                    Container(
                      height: 300,
                      width: 300,
                      color: Colors.blue,
                    ),
                  ]),
                )
              ])),
            ]),
          ),
        ]));
  }
}

import 'package:flutter/material.dart';

class ListedIPODetailsPage extends StatefulWidget {
  ListedIPODetailsPage(this.listt, {Key? key}) : super(key: key);
  var listt;

  @override
  _ListedIPODetailsPageState createState() => _ListedIPODetailsPageState();
}

class _ListedIPODetailsPageState extends State<ListedIPODetailsPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.listt);
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.listt['ipo-details']['ipo-name']}"),
      ),
    );
  }
}

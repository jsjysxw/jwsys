import 'package:flutter/material.dart';

class TabDetailPage extends StatefulWidget {
  // final String title = "";
  // TabDetailPage(this.title, {Key key}) : super(key: key);

  @override
  _TabDetailPageState createState() => _TabDetailPageState();
}

class _TabDetailPageState extends State<TabDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("美食")),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(children: <Widget>[])));
  }
}
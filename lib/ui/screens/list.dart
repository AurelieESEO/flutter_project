import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:
      Center(
        child: Text("vue liste"),
      ),
    );
  }
}
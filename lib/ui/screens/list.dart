import 'package:flutter/material.dart';
import 'package:flutter_project/models/parking.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key, required List<Parking> parkings}) : super(key: key);

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
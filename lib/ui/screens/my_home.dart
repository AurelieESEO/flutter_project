import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/blocks/parking_cubit.dart';
import 'package:flutter_project/models/parking.dart';
import 'package:flutter_project/ui/screens/home.dart';
import 'package:flutter_project/ui/screens/list.dart';
import 'package:flutter_project/ui/screens/map.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHome> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Park me Angers"),
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<ParkingCubit, List<Parking>>(
        builder: (context, parkings) {
          if (parkings.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return IndexedStack(
              index: _currentIndex,
              children: [
                MapPage(
                    parkings: parkings,
                    parkingCubit: context.read<ParkingCubit>()),
                HomePage(parkings: parkings),
                ListPage(parkings: parkings),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.cyan,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Carte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Liste des parkings',
          ),
        ],
      ),
    );
  }
}

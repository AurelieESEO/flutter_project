import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_project/blocks/parking_cubit.dart';
import 'package:flutter_project/models/parking.dart';
import 'package:flutter_project/ui/screens/parking_description.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  final List<Parking> parkings;
  final ParkingCubit parkingCubit;

  const MapPage({Key? key, required this.parkings, required this.parkingCubit})
      : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool isLoading = false;
  bool isInfoVisible = false;
  bool isRefreshComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(47.473611, -0.554722),
              zoom: 14.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(
                markers: _buildMarkers(),
              ),
            ],
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  isInfoVisible = !isInfoVisible;
                });
              },
              child: const Icon(Icons.info),
            ),
          ),
          if (isInfoVisible)
            Positioned(
              bottom: 80.0,
              right: 16.0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Text(
                  "Les disponibilités sont actualisées automatiquement toutes les 10 secondes."
                  "\nVous pouvez également actualiser manuellement en cliquant sur le bouton en bas de l'écran."
                  "\nCliquez sur un parking pour afficher plus d'informations sur celui-ci.",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          if (isRefreshComplete)
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 80.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: isRefreshComplete ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    if (isRefreshComplete)
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                  ],
                ),
                child: const Text(
                  "Actualisation terminée",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _refreshDisponibilities();
        },
        child: isLoading
            ? const SizedBox(
                width: 15.0,
                height: 15.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : const Icon(
                Icons.refresh,
                size: 24.0,
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  List<Marker> _buildMarkers() {
    List<Marker> markers = widget.parkings.map((parking) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: parking.coordinates ?? LatLng(0, 0),
        builder: (ctx) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ParkingDescriptionPage(parking: parking),
              ),
            );
          },
          child: Column(
            children: [
              const Icon(
                Icons.pin_drop,
                color: Colors.lightBlue,
                size: 40.0,
              ),
              Text(
                parking.nbAvailableSpaces.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
    return markers;
  }

  void _refreshDisponibilities() async {
    setState(() {
      isLoading = true;
      isRefreshComplete = false;
    });

    await widget.parkingCubit.refreshDisponibilities();

    setState(() {
      isLoading = false;
      isRefreshComplete = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isRefreshComplete = false;
      });
    });
  }
}

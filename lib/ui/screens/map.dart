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
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  bool isLoading = false;
  bool isInfoVisible = false;
  bool isRefreshComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map centered on Angers
          FlutterMap(
            options: MapOptions(
              center: LatLng(47.473611, -0.554722), // Angers coordinates
              zoom: 14.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              // Markers for each parking with the number of available spaces
              // under them
              MarkerLayerOptions(
                markers: _buildMarkers(),
              ),
            ],
          ),
          // Button to update the disponibilities manually
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
            // Container to explain how to use the map page
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
                // Text to explain how to use the map page
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
            // Container to display a message when the disponibilities are updated
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
      // Method called by the button to update the disponibilities manually
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _refreshDisponibilities();
        },
        // Display a circular progress indicator when the disponibilities are
        // updating
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

  // Method to build the markers for each parking with the number of available
  // spaces under them
  List<Marker> _buildMarkers() {
    List<Marker> markers = widget.parkings.map((parking) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: parking.coordinates,
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

  // Method to update the disponibilities manually
  void _refreshDisponibilities() async {
    // Set the loading indicator to true while the disponibilities are updating
    setState(() {
      isLoading = true;
      isRefreshComplete = false;
    });

    // Update the disponibilities for each parking with the API call to the
    // in the ParkingCubit
    await widget.parkingCubit.refreshDisponibilities();

    // Set refresh complete to display the success message
    setState(() {
      isLoading = false;
      isRefreshComplete = true;
    });

    // Display the success message for 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isRefreshComplete = false;
      });
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_project/models/parking.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatelessWidget {
  final List<Parking> parkings;

  const MapPage({Key? key, required this.parkings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(47.473611, -0.554722), // Coordonnées d'Angers
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: _buildMarkers(),
          ),
        ],
      ),
    );
  }

  List<Marker> _buildMarkers() {
    List<Marker> markers = parkings
        .map((parking) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: parking.coordinates ?? LatLng(0, 0),
        builder: (ctx) => Column(
          children: [
            Icon(
              Icons.pin_drop,
              color: Colors.red,
              size: 40.0,
            ),
            Text(
              parking.nbAvailableSpaces.toString(),
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      );
    })
        .toList();
    return markers;
  }
}

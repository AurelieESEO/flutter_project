import 'dart:convert';
import 'package:flutter_project/models/parking.dart';
import 'package:http/http.dart' as http;

class ParkingDisponibilitiesService {
  final String endpointAllParkings = 'https://data.angers.fr/api/explore/v2.1/catalog/'
      'datasets/parking-angers/records?limit=20';

  ParkingDisponibilitiesService();

  Future<Map<String, dynamic>> getAllParkingsDisponibilities() async {
    final response = await http.get(Uri.parse(endpointAllParkings));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load air quality data');
    }
  }


  Future<Map<String, dynamic>> getSpecificParkingDisponibilities(String parkingName) async {
    parkingName.replaceAll(" ", "%20");
    String endpoint = 'https://data.angers.fr/api/explore/v2.1/catalog/'
        'datasets/parking-angers/records?'
        'where=nom%20like%20%22$parkingName%22&limit=20';

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load air quality data');
    }
  }
}
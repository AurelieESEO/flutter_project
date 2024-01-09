import 'dart:convert';

import 'package:flutter_project/services/parking_disponibilities_service.dart';
import 'package:http/http.dart' as http;

import '../models/parking.dart';

class ParkingDescriptionService {
  final String endpointAllParkings =
      'https://data.angers.fr/api/explore/v2.1/catalog/'
      'datasets/angers_stationnement/records?limit=20';

  ParkingDescriptionService();

  Future<List<Parking>> getAllParkingsDescription() async {
    final response = await http.get(Uri.parse(endpointAllParkings));
    if (response.statusCode == 200) {
      final List<Parking> parkings = [];

      // Transformation du JSON (String) en Map<String, dynamic>
      final Map<String, dynamic> json = jsonDecode(response.body);
      if (json.containsKey("results")) {
        // Récupération des "results"
        final List<dynamic> results = json['results'];
        // Transformation de chaque "feature" en objet de type "Address"
        for (Map<String, dynamic> result in results) {
          int? nbAvailablePlaces = await ParkingDisponibilitiesService()
              .getSpecificParkingDisponibilities(result['id_parking']);
          final Parking parking = Parking.fromApiJson(result);
          parking.nbAvailableSpaces = nbAvailablePlaces;
          parkings.add(parking);
        }
      }
      return parkings;
    } else {
      throw Exception('Failed to load parkings description data');
    }
  }

  Future<Map<String, dynamic>> getSpecificParkingDescription(
      String parkingId) async {
    String endpoint = 'https://data.angers.fr/api/explore/v2.1/catalog/'
        'datasets/angers_stationnement/records?'
        'where=nom%20like%20%22$parkingId%22&limit=20';

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load air quality data');
    }
  }
}

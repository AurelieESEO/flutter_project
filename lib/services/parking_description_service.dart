import 'dart:convert';

import 'package:flutter_project/services/parking_disponibilities_service.dart';
import 'package:http/http.dart' as http;

import '../models/parking.dart';

class ParkingDescriptionService {
  // API Key to get parkings description data
  final String apiKey = 'a1686bc00d990b65e56a2063d13aced481df200a6b7c2cfefc9f2cad';

  // Constructor of the class ParkingDescriptionService
  ParkingDescriptionService();

  // Method to get parkings description data
  Future<List<Parking>> getAllParkingsDescription() async {
    // API url to get parkings description data
    final String endpointAllParkings =
        'https://data.angers.fr/api/explore/v2.1/catalog/'
        'datasets/angers_stationnement/records?apikey=$apiKey&limit=20';
    final response = await http.get(Uri.parse(endpointAllParkings));
    if (response.statusCode == 200) {
      final List<Parking> parkings = [];

      // Transformation of the JSON (String) into Map<String, dynamic>
      final Map<String, dynamic> json = jsonDecode(response.body);
      if (json.containsKey("results")) {
        // Get the "results"
        final List<dynamic> results = json['results'];
        // Transformation of each "feature" into an object of type "Address"
        for (Map<String, dynamic> result in results) {
          // Get the number of available places for the parking from
          // the associated API
          int? nbAvailablePlaces = await ParkingDisponibilitiesService()
              .getSpecificParkingDisponibilities(result['id_parking']);
          // Convert the JSON into an object of type "Parking"
          final Parking parking = Parking.fromApiJson(result);
          parking.nbAvailableSpaces = nbAvailablePlaces;
          // Add the parking to the list of parkings
          parkings.add(parking);
        }
      }
      return parkings;
    } else {
      throw Exception('Failed to load parkings description data');
    }
  }

  // Method to get a specific parking description data
  Future<Map<String, dynamic>> getSpecificParkingDescription(
      String parkingId) async {
    // API url to get a specific parking description data
    String endpoint = 'https://data.angers.fr/api/explore/v2.1/catalog/'
        'datasets/angers_stationnement/records?'
        'where=nom%20like%20%22$parkingId%22&'
        'apikey=a1686bc00d990b65e56a2063d13aced481df200a6b7c2cfefc9f2cad&limit=20';

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load air quality data');
    }
  }
}

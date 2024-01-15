import 'dart:convert';

import 'package:http/http.dart' as http;

class ParkingDisponibilitiesService {
  final String endpointAllParkings =
      'https://data.angers.fr/api/explore/v2.1/catalog/'
      'datasets/parking-angers/records?'
      'apikey=a1686bc00d990b65e56a2063d13aced481df200a6b7c2cfefc9f2cad&limit=20';

  ParkingDisponibilitiesService();

  Future<Map<String, dynamic>> getAllParkingsDisponibilities() async {
    final response = await http.get(Uri.parse(endpointAllParkings));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load air quality data');
    }
  }

  Future<int?> getSpecificParkingDisponibilities(String parkingName) async {
    parkingName.replaceAll(" ", "%20");
    String endpoint = 'https://data.angers.fr/api/explore/v2.1/catalog/'
        'datasets/parking-angers/records?'
        'where=nom%20like%20%22$parkingName%22&limit=20';

    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      if (json.containsKey("results")) {
        final List<dynamic> results = json['results'];
        for (Map<String, dynamic> result in results) {
          if (result['nom'] == parkingName) {
            return result['disponible'] as int;
          }
        }
      }
    } else {
      throw Exception('Failed to load air quality data');
    }
    return null;
  }
}

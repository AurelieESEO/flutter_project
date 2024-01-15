import 'dart:convert';

import 'package:http/http.dart' as http;

class AirQualityService {
  final String endpoint = 'https://data.angers.fr/api/explore/v2.1/catalog/'
      'datasets/dataairplqualiteairangers/records?apikey=a1686bc00d990b65e56a2063d13aced481df200a6b7c2cfefc9f2cad'
      '&select=sous_indice_2_polluant&where=commune_nom%20like%20%22Angers%22'
      '&order_by=sous_indice_2_polluant%20desc&limit=20';

  AirQualityService();

  Future<Map<String, dynamic>> getAirQuality() async {
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load air quality data');
    }
  }
}

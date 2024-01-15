import 'dart:convert';

import 'package:http/http.dart' as http;

class AirQualityService {
  final String endpoint =
      'https://api.openweathermap.org/data/2.5/air_pollution'
      '?lat=47.4784&lon=-0.5632&appid=3d495a7ceaa23b7fd0d91b4d0140bd4d';

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

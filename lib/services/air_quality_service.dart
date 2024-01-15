import 'dart:convert';

import 'package:http/http.dart' as http;

class AirQualityService {
  // API key to get air quality data
  final String apiKey = '3d495a7ceaa23b7fd0d91b4d0140bd4d';

  // Constructor of the class AirQualityService
  AirQualityService();

  // Method to get air quality data
  Future<Map<String, dynamic>> getAirQuality() async {
    // API url to get air quality data
    final String endpoint =
        'https://api.openweathermap.org/data/2.5/air_pollution'
        '?lat=47.4784&lon=-0.5632&appid=$apiKey';
    final response = await http.get(Uri.parse(endpoint));

    // If the request is successful, the response body is decoded and returned
    // as a Map<String, dynamic> else an exception is thrown
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load air quality data');
    }
  }
}

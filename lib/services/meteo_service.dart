import 'dart:convert';

import 'package:http/http.dart' as http;

class MeteoService {
  // API key to get meteo data
  final String apiKey = '3d495a7ceaa23b7fd0d91b4d0140bd4d';

  // Constructor of the class MeteoService
  MeteoService();

  // Method to get meteo data
  Future<Map<String, dynamic>> getMeteo() async {
    // API url to get meteo data
    final String endpoint = 'https://api.openweathermap.org/data/2.5/weather?q='
        'Angers&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(endpoint));

    // If the request is successful, the response body is decoded and returned
    // as a Map<String, dynamic> else an exception is thrown
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load meteo');
    }
  }
}

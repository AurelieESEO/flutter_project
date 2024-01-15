import 'dart:convert';

import 'package:http/http.dart' as http;

class MeteoService {
  final String endpoint = 'https://api.openweathermap.org/data/2.5/weather?q='
      'Angers&appid=3d495a7ceaa23b7fd0d91b4d0140bd4d&units=metric';

  MeteoService();

  Future<Map<String, dynamic>> getMeteo() async {
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load meteo');
    }
  }
}

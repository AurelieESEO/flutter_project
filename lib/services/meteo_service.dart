import 'dart:convert';
import 'package:http/http.dart' as http;

class MeteoService {
  final String endpoint = 'http://api.weatherstack.com/current'
      '?access_key=8d8127332c6e82e8583db36840ab8f78'
      '&query=Angers';

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

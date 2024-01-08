import 'dart:convert';

import 'package:flutter_project/models/parking.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {
  Future<void> saveCompanies(List<Parking> parkings) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> listJson = [];
    for (final Parking parking in parkings) {
      listJson.add(jsonEncode(parking.toJson()));
    }
    prefs.setStringList('parkings', listJson);
  }

  Future<List<Parking>> loadCompanies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Parking> parkings = [];

    final listJson = prefs.getStringList('companies') ?? [];
    for (final String json in listJson) {
      parkings.add(Parking.fromJson(jsonDecode(json)));
    }

    return parkings;
  }
}
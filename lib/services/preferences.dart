import 'dart:convert';

import 'package:flutter_project/models/parking.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Class to manage the shared preferences
class PreferencesRepository {
  // Method to save the parkings in the shared preferences
  Future<void> saveParkings(List<Parking> parkings) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> listJson = [];
    // Convert each parking into a JSON (String) and add it to the list
    for (final Parking parking in parkings) {
      listJson.add(jsonEncode(parking.toJson()));
    }
    prefs.setStringList('parkings', listJson);
  }

  // Method to load the parkings from the shared preferences
  Future<List<Parking>> loadParkings() async {
    // Get the shared preferences instance
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Parking> parkings = [];

    // Get the list of parkings from the shared preferences and decode each
    // JSON (String) into an object of type "Parking"
    final listJson = prefs.getStringList('parkings') ?? [];
    for (final String json in listJson) {
      parkings.add(Parking.fromJson(jsonDecode(json)));
    }

    return parkings;
  }
}

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/models/parking.dart';
import 'package:flutter_project/services/parking_description_service.dart';
import 'package:flutter_project/services/parking_disponibilities_service.dart';

import '../services/preferences.dart';

/// Declaration of a Cubit to store the list of parkings
class ParkingCubit extends Cubit<List<Parking>> {
  /// Initialise the list of parkings and load them from the API
  /// or from the shared preferences
  ParkingCubit(this.preferencesRepository) : super([]) {
    loadParkings();
    // Launch the periodic refresh of the parkings
    refreshDisponibilitiesPeriodic();
  }

  /// Method to refresh the availability of the parkings every 10 seconds
  void refreshDisponibilitiesPeriodic() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      refreshDisponibilities();
    });
  }

  /// Method to refresh the availability of the parkings
  Future<List<Parking>> refreshDisponibilities() async {
    Map<String, dynamic> json =
        await ParkingDisponibilitiesService().getAllParkingsDisponibilities();
    if (json.containsKey("results")) {
      // Get the "results"
      final List<dynamic> results = json['results'];
      for (Map<String, dynamic> result in results) {
        for (final parking in state) {
          if (result['nom'] == parking.name &&
              result['disponible'] != parking.nbAvailableSpaces) {
            parking.nbAvailableSpaces = result['disponible'];
          }
        }
      }
    }
    // Emit the new state and save it in the shared preferences
    emit([...state]);
    preferencesRepository.saveParkings(state);
    return state;
  }

  final PreferencesRepository preferencesRepository;

  // Method to load the parkings from the shared preferences or from the API
  // if the shared preferences are empty
  Future<void> loadParkings() async {
    List<Parking> parkings = await preferencesRepository.loadParkings();
    if (parkings.isEmpty) {
      parkings = await ParkingDescriptionService().getAllParkingsDescription();
      preferencesRepository.saveParkings(state);
    } else {
      refreshDisponibilities();
    }
    emit([...parkings]);
  }
}

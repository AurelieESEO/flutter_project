import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/models/parking.dart';
import 'package:flutter_project/services/parking_description_service.dart';
import 'package:flutter_project/services/parking_disponibilities_service.dart';

import '../services/preferences.dart';

/// Déclaration d'un "Cubit" pour stocker la liste de parkings
class ParkingCubit extends Cubit<List<Parking>> {
  /// Constructeur + initialisation du Cubit avec un tableau vide de parkings
  ParkingCubit(this.preferencesRepository) : super([]) {
    loadParkings();
    refreshDisponibilitiesPeriodic();
  }

  /// Méthode pour rafraichir les disponibilités des parkings
  void refreshDisponibilitiesPeriodic() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      refreshDisponibilities();
    });
  }

  Future<List<Parking>> refreshDisponibilities() async {
    Map<String, dynamic> json =
        await ParkingDisponibilitiesService().getAllParkingsDisponibilities();
    if (json.containsKey("results")) {
      // Récupération des "results"
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
    emit([...state]);
    preferencesRepository.saveParkings(state);
    return state;
  }

  final PreferencesRepository preferencesRepository;

  Future<void> loadParkings() async {
    List<Parking> parkings = await preferencesRepository.loadParkings();
    if (parkings.isEmpty) {
      //Si la liste est vide, on charge les parkings depuis l'API
      parkings = await ParkingDescriptionService().getAllParkingsDescription();
      preferencesRepository.saveParkings(state);
    } else {
      refreshDisponibilities();
    }
    emit([...parkings]);
  }

  /// Méthode pour ajouter un parking
  void addParking(Parking parking) {
    emit([...state, parking]);
    preferencesRepository.saveParkings(state);
  }
}

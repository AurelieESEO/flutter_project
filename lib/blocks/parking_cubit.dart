import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/models/parking.dart';

import '../services/preferences.dart';

/// Déclaration d'un "Cubit" pour stocker la liste de parkings
class ParkingCubit extends Cubit<List<Parking>> {
  /// Constructeur + initialisation du Cubit avec un tableau vide de parkings
  ParkingCubit(this.preferencesRepository) : super([]);

  final PreferencesRepository preferencesRepository;

  /// Méthode pour charger la liste de parkings
  Future<void> loadParkings() async {
    final parkings = await preferencesRepository.loadCompanies();
    emit([...parkings]);
  }

  /// Méthode pour ajouter un parking
  void addParking(Parking parking) {
    emit([...state, parking]);
    preferencesRepository.saveCompanies(state);
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/models/parking.dart';
import 'package:flutter_project/services/parking_description_service.dart';

import '../services/preferences.dart';

/// Déclaration d'un "Cubit" pour stocker la liste de parkings
class ParkingCubit extends Cubit<List<Parking>> {
  /// Constructeur + initialisation du Cubit avec un tableau vide de parkings
  ParkingCubit(this.preferencesRepository) : super([]);

  final PreferencesRepository preferencesRepository;

  /// Méthode pour charger la liste de parkings
  Future<void> loadParkings() async {
    final parkings = await preferencesRepository.loadParkings();
    if (parkings.isEmpty) {
      // Si la liste est vide, on charge les parkings depuis l'API
      final List<Parking> parkings = await ParkingDescriptionService()
          .getAllParkingsDescription();
      // print parkings list
      emit([...parkings]);
      preferencesRepository.saveParkings(state);
    }
    print("parkings trouvés: " + parkings.toString());
  }

  /// Méthode pour ajouter un parking
  void addParking(Parking parking) {
    emit([...state, parking]);
    preferencesRepository.saveParkings(state);
  }
}
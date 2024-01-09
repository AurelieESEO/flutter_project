import 'package:flutter_project/models/tariffs.dart';
import 'package:latlong2/latlong.dart';

class Parking {
  String id;
  String completeName;
  String name;
  String address;
  String postCode;
  String url;
  String usersType;
  bool isFree;
  String maxHeight;
  LatLng coordinates;
  int nbSpaces;
  int? nbAvailableSpaces;
  int? nbPmrSpaces;
  int? nbElectricCarsSpaces;
  int? nbBikeSpaces;
  int? nbMotoScootersSpaces;
  int? nb2WheelsElectricSpaces;
  int? nbSharingCarsSpaces;
  int? nbCarpoolSpaces;
  Tariffs tariffs;
  String accessibilityHours;
  String accessWay;

  Parking(
      this.id,
      this.completeName,
      this.name,
      this.address,
      this.postCode,
      this.url,
      this.usersType,
      this.isFree,
      this.maxHeight,
      this.coordinates,
      this.nbSpaces,
      this.tariffs,
      this.accessibilityHours,
      this.accessWay,
      {this.nbAvailableSpaces,
      this.nbPmrSpaces,
      this.nbElectricCarsSpaces,
      this.nbBikeSpaces,
      this.nbMotoScootersSpaces,
      this.nb2WheelsElectricSpaces,
      this.nbSharingCarsSpaces,
      this.nbCarpoolSpaces});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'completeName': completeName,
      'name': name,
      'address': address,
      'postCode': postCode,
      'url': url,
      'usersType': usersType,
      'isFree': isFree,
      'maxHeight': maxHeight,
      'latitude': coordinates.latitude,
      'longitude': coordinates.longitude,
      'nbSpaces': nbSpaces,
      'nbAvailableSpaces': nbAvailableSpaces,
      'nbPmrSpaces': nbPmrSpaces,
      'nbElectricCarsSpaces': nbElectricCarsSpaces,
      'nbBikeSpaces': nbBikeSpaces,
      'nbMotoScootersSpaces': nbMotoScootersSpaces,
      'nb2WheelsElectricSpaces': nb2WheelsElectricSpaces,
      'nbSharingCarsSpaces': nbSharingCarsSpaces,
      'nbCarpoolSpaces': nbCarpoolSpaces,
      'tariffs': tariffs,
      'accessibilityHours': accessibilityHours,
      'accessWay': accessWay
    };
  }

  factory Parking.fromJson(Map<String, dynamic> json) {
    // check if json['tariffs'] is null or not
    final tariffs = json['tariffs'] != null
        ? Tariffs.fromJson(json['tariffs'])
        : Tariffs(0, 0, 0, 0, 0);

    LatLng coordinates = LatLng(json['latitude'], json['longitude']);

    return Parking(
        json['id'],
        json['completeName'],
        json['name'],
        json['address'],
        json['postCode'],
        json['url'],
        json['usersType'],
        json['isFree'],
        json['maxHeight'],
        coordinates,
        json['nbSpaces'],
        tariffs,
        json['accessibilityHours'],
        json['accessWay'],
        nbAvailableSpaces: json['nbAvailableSpaces'],
        nbPmrSpaces: json['nbPmrSpaces'],
        nbElectricCarsSpaces: json['nbElectricCarsSpaces'],
        nbBikeSpaces: json['nbBikeSpaces'],
        nbMotoScootersSpaces: json['nbMotoScootersSpaces'],
        nb2WheelsElectricSpaces: json['nb2WheelsElectricSpaces'],
        nbSharingCarsSpaces: json['nbSharingCarsSpaces'],
        nbCarpoolSpaces: json['nbCarpoolSpaces']);
  }

  factory Parking.fromApiJson(Map<String, dynamic> json) {
    Tariffs tariffs = Tariffs(json['tarif_1h'], json['tarif_2h'],
        json['tarif_3h'], json['tarif_4h'], json['tarif_24h'],
        tariffPmr: json['tarif_pmr'],
        tariffResident: json['abo_resident'],
        tariffNonResident: json['abo_non_resident']);

    bool isFree = json['gratuit'] == 'VRAI' ? true : false;

    return Parking(
        json['id'],
        json['nom'],
        json['id_parking'],
        json['adresse'],
        json['insee'],
        json['url'],
        json['type_usagers'],
        isFree,
        json['hauteur_max'],
        LatLng(double.parse(json['ylat']), double.parse(json['xlong'])),
        json['nb_places'],
        tariffs,
        json['accessibilite'],
        json['moyens_acces'],
        nbPmrSpaces: json['nb_pmr'],
        nbElectricCarsSpaces: json['nb_voitures_electriques'],
        nbBikeSpaces: json['nb_velo'],
        nbMotoScootersSpaces: json['nb_2_rm'],
        nb2WheelsElectricSpaces: json['nb_2r_el'],
        nbSharingCarsSpaces: json['nb_autopartage'],
        nbCarpoolSpaces: json['nb_covoit']);
  }
}

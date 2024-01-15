import 'package:flutter_project/models/tariffs.dart';
import 'package:latlong2/latlong.dart';

// Parking is a class that represents a parking with the following attributes:
// - id: the id of the parking
// - completeName: the complete name of the parking (with "Parking" at the start)
// - name: the name of the parking (without "Parking" at the start)
// - address: the address of the parking
// - postCode: the post code of the parking
// - url: the url of the parking for more information
// - usersType: the type of users that can use the parking
// - isFree: a boolean to know if the parking is free or not
// - maxHeight: the max height for a vehicle to enter the parking
// - coordinates: the coordinates of the parking (latitude and longitude)
// - nbSpaces: the total number of spaces in the parking
// - nbAvailableSpaces: the number of available spaces in the parking (all types)
// - nbPmrSpaces: the number of available spaces for PMR (person with reduce mobility)
// - nbElectricCarsSpaces: the number of available spaces for electric cars
// - nbBikeSpaces: the number of available spaces for bikes
// - nbMotoScootersSpaces: the number of available spaces for moto scooters
// - nb2WheelsElectricSpaces: the number of available spaces for 2 wheels electric vehicles
// - nbSharingCarsSpaces: the number of available spaces for sharing cars
// - nbCarpoolSpaces: the number of available spaces for carpool
// - tariffs: the tariffs of the parking : 1h, 2h, 3h, 4h, 24h, PMR, Resident, Non Resident
// - accessibilityHours: the accessibility hours of the parking
// - accessWay: the access way of the parking
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

  // Constructor of the class Parking
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

  // Method to convert the Parking object to a JSON object
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

  // Method to convert a JSON object from the shared preferences to a Parking object
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

  // Method to convert a JSON object from the API to a Parking object
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

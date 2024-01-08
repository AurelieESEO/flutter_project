import 'package:flutter/material.dart';
import 'package:flutter_project/models/address.dart';
import 'package:flutter_project/models/tariffs.dart';
import 'package:latlong2/latlong.dart';

class Parking {
  String id;
  String completeName;
  String name;
  Address address;
  String url;
  String usersType;
  bool isFree;
  String maxHeight;
  LatLng coordinates;
  int nbSpaces;
  int? nbAvailableSpaces;
  int nbPmrSpaces;
  int nbElectricCarsSpaces;
  int nbBikeSpaces;
  int nbMotoScootersSpaces;
  int nb2WheelsElectricSpaces;
  int nbSharingCarsSpaces;
  int nbCarpoolSpaces;
  Tariffs tariffs;
  String accessibilityHours;
  String accessWay;

  Parking(
    this.id,
    this.completeName,
    this.name,
    this.address,
    this.url,
    this.usersType,
    this.isFree,
    this.maxHeight,
    this.coordinates,
    this.nbSpaces,
    this.nbPmrSpaces,
    this.nbElectricCarsSpaces,
    this.nbBikeSpaces,
    this.nbMotoScootersSpaces,
    this.nb2WheelsElectricSpaces,
    this.nbSharingCarsSpaces,
    this.nbCarpoolSpaces,
    this.tariffs,
    this.accessibilityHours,
    this.accessWay,
    {this.nbAvailableSpaces}
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'completeName': completeName,
      'name': name,
      'address': address,
      'url': url,
      'usersType': usersType,
      'isFree': isFree,
      'maxHeight': maxHeight,
      'coordinates': coordinates,
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
    return Parking(
      json['id'],
      json['completeName'],
      json['name'],
      json['address'],
      json['url'],
      json['usersType'],
      json['isFree'],
      json['maxHeight'],
      json['coordinates'],
      json['nbSpaces'],
      nbAvailableSpaces: json['nbAvailableSpaces'],
      json['nbPmrSpaces'],
      json['nbElectricCarsSpaces'],
      json['nbBikeSpaces'],
      json['nbMotoScootersSpaces'],
      json['nb2WheelsElectricSpaces'],
      json['nbSharingCarsSpaces'],
      json['nbCarpoolSpaces'],
      json['tariffs'],
      json['accessibilityHours'],
      json['accessWay']
    );
  }

  factory Parking.fromApiJson(Map<String, dynamic> json) {

    Tariffs tariffs = Tariffs(json['tarif_pmr'], json['tarif_1h'],
        json['tarif_2h'], json['tarif_3h'], json['tarif_4h'],
        json['tarif_24h'], json['abo_resident'], json['abo_non_resident']);

    return Parking(
        json['id'],
        json['nom'],
        json['id_parking'],
        json['adresse'],
        json['url'],
        json['type_usagers'],
        json['gratuit'],
        json['hauteur_max'],
        LatLng(json['ylat'], json['xlong']),
        json['nb_places'],
        json['nb_pmr'],
        json['nb_voitures_electriques'],
        json['nb_velo'],
        json['nb_2_rm'],
        json['nb_2r_el'],
        json['nb_autopartage'],
        json['nb_covoit'],
        tariffs,
        json['accessibilite'],
        json['moyens_acces']
    );
  }

  void add(Parking parking) {

  }
}

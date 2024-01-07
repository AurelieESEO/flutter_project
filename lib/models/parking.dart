import 'package:flutter/material.dart';
import 'package:flutter_project/models/address.dart';
import 'package:flutter_project/models/tariffs.dart';
import 'package:latlong2/latlong.dart';

class Parking {
  String id;
  String name;
  Address address;
  String url;
  String usersType;
  bool isFree;
  String maxHeight;
  LatLng coordinates;
  int nbSpaces;
  int nbAvailableSpaces;
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
    this.name,
    this.address,
    this.url,
    this.usersType,
    this.isFree,
    this.maxHeight,
    this.coordinates,
    this.nbSpaces,
    this.nbAvailableSpaces,
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
  );
}

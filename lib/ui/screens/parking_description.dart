import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/parking.dart';

class ParkingDescriptionPage extends StatelessWidget {
  final Parking parking;

  const ParkingDescriptionPage({Key? key, required this.parking})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        title: Text(parking.completeName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSpanText(
                'Adresse : ', '${parking.address} ${parking.postCode}'),
            _buildSpanText('Hauteur maximale : ', '${parking.maxHeight} cm'),
            _buildSpanText('Moyens d\'accès : ', parking.accessWay),
            _buildSpanText(
                'Horaires d\'accessibilité : ', parking.accessibilityHours),
            const Text(
              'Les tarifs :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPriceCard('1H', parking.tariffs.tariff1H),
                _buildPriceCard('2H', parking.tariffs.tariff2H),
                _buildPriceCard('3H', parking.tariffs.tariff3H),
                _buildPriceCard('4H', parking.tariffs.tariff4H),
                _buildPriceCard('24h', parking.tariffs.tariff24H)
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Abonnements :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSubscriptionCard(
                    'Résidents', parking.tariffs.tariffResident),
                _buildSubscriptionCard(
                    'Non Résidents', parking.tariffs.tariffNonResident),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Nombre de places :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSpacesCard('Total', parking.nbSpaces),
                  _buildSpacesCard(
                      'Personnes à\nmobilité réduite', parking.nbPmrSpaces),
                  _buildSpacesCard(
                      'Motos\nScooters', parking.nbMotoScootersSpaces),
                  _buildSpacesCard('Vélos', parking.nbBikeSpaces),
                  _buildSpacesCard(
                      'Voitures\nélectriques', parking.nbElectricCarsSpaces),
                  _buildSpacesCard(
                      '2 roues\nélectriques', parking.nb2WheelsElectricSpaces),
                  _buildSpacesCard('Autopartage', parking.nbSharingCarsSpaces),
                  _buildSpacesCard('Covoiturage', parking.nbCarpoolSpaces),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAvailabilityCard(
                    'Nombre de places acutellement disponibres\n (Attention nous ne connaissons par leur type)',
                    parking.nbAvailableSpaces),
              ],
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Lien pour plus d'informations : ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: parking.completeName,
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                      fontSize: 16.0,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(Uri.parse(parking.url));
                      },
                  ),
                ],
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpanText(String boldText, String normalText) {
    return Column(children: [
      RichText(
        text: TextSpan(
            text: boldText,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: normalText,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              )
            ]),
      ),
      const SizedBox(height: 8),
    ]);
  }

  Widget _buildPriceCard(String label, double price) {
    return Card(
      color: Colors.blue[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('$price€'),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(String label, int? price) {
    return Card(
      color: Colors.red[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(price != null ? '$price€' : 'Non disponible'),
          ],
        ),
      ),
    );
  }

  Widget _buildSpacesCard(String label, int? value) {
    return Container(
      height: 100, // Définir une hauteur fixe pour toutes les boîtes
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              Text(value != null ? '$value' : 'Non disponible'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvailabilityCard(String label, int? value) {
    return Container(
      height: 100,
      child: Card(
        color: Colors.green[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              Text(value != null ? '$value' : 'Information non disponible'),
            ],
          ),
        ),
      ),
    );
  }
}

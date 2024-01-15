import 'package:flutter/material.dart';

import '../../models/parking.dart';

class ParkingDescriptionPage extends StatelessWidget {
  final Parking parking;

  const ParkingDescriptionPage({Key? key, required this.parking})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(parking.completeName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Adresse: ${parking.address}, ${parking.postCode}',
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            // ),
            RichText(
              text: TextSpan(
                  text: 'Adresse : ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${parking.address} ${parking.postCode}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
                    )
                  ]),
            ),
            const SizedBox(height: 16),
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
          ],
        ),
      ),
    );
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
}

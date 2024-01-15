import 'package:flutter/material.dart';
import 'package:flutter_project/models/parking.dart';
import 'package:flutter_project/ui/screens/parking_description.dart';

class ListPage extends StatelessWidget {
  final List<Parking> parkings;

  const ListPage({Key? key, required this.parkings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Parkings'),
      ),
      body: ListView.separated(
        itemCount: parkings.length,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.grey,
          height: 1,
        ),
        itemBuilder: (context, index) {
          Parking parking = parkings[index];
          bool isEvenIndex = index.isEven;

          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(parking.completeName,
                    style: const TextStyle(fontSize: 18)),
                Text('${parking.nbAvailableSpaces}',
                    style: const TextStyle(fontSize: 18)),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ParkingDescriptionPage(parking: parking),
                ),
              );
            },
            tileColor: isEvenIndex ? Colors.grey[200] : null,
          );
        },
      ),
    );
  }
}

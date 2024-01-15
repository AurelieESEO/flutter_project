import 'package:flutter/material.dart';
import 'package:flutter_project/models/parking.dart';
import 'package:flutter_project/ui/screens/parking_description.dart';

class ListPage extends StatelessWidget {
  final List<Parking> parkings;

  const ListPage({Key? key, required this.parkings}) : super(key: key);

  // Method to build the list of parkings with the number of available places
  // for each parking
  // Displays them with a different background color if the index is even
  // or odd.
  // Displays the parking description page when the user clicks on a parking
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

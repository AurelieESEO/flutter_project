import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/parking.dart';
import 'package:flutter_project/ui/screens/parking_description.dart';
import 'package:geolocator/geolocator.dart';

import '../../blocks/parking_cubit.dart';
import '../../services/air_quality_service.dart';
import '../../services/meteo_service.dart';

// Class to display the home page of the application (with the air quality,
// the weather and the nearest parkings)
class HomePage extends StatefulWidget {
  final List<Parking> parkings;
  final ParkingCubit parkingCubit;

  const HomePage({Key? key, required this.parkings, required this.parkingCubit})
      : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Position? _currentPosition;

  // Init the widget and store the current position of the user
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Method to get the current position of the user and store it in the
  // "_currentPosition" variable
  Future<void> _getCurrentLocation() async {
    try {
      // Get the current position of the user (latitude and longitude) with
      // high accuracy
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Store the current position of the user in the "_currentPosition" attribute
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Method to get the nearest parkings from the current position of the user
  List<Parking> getNearestParkings(List<Parking> parkings, int count) {
    // If the current position of the user is not available, return an empty list
    if (_currentPosition == null) {
      return [];
    }

    // Sort the parkings by distance from the current position of the user
    parkings.sort((parking1, parking2) {
      double distance1 = Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        parking1.coordinates.latitude,
        parking1.coordinates.longitude,
      );

      double distance2 = Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        parking2.coordinates.latitude,
        parking2.coordinates.longitude,
      );

      return distance1.compareTo(distance2);
    });
    // Return the "count" first parkings
    return parkings.take(count).toList();
  }

  final String apiAirQualityKey = 'YOUR_API_KEY';

  @override
  Widget build(BuildContext context) {
    // Get the 5 nearest parkings from the current position of the user
    List<Parking> nearestParkings = getNearestParkings(widget.parkings, 5);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Display the title of the application
              Container(
                width: double.infinity,
                color: Colors.white38,
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'Bienvenue sur\nPark me Angers ! 🅿️🏰',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                      color: Colors.cyan),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 1,
                indent: 20,
                endIndent: 20,
                color: Colors.cyan,
              ),
              const SizedBox(height: 10),
              // Display the air quality section
              Column(
                children: [
                  const Text(
                    ' Qualité de l\'air 🌬️ ',
                    style: TextStyle(
                        backgroundColor: Colors.cyan,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  FutureBuilder(
                    future: AirQualityService().getAirQuality(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: getAirQualityColor(
                                    snapshot.data!['list'][0]['main']['aqi']),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              getAirQuality(
                                  snapshot.data!['list'][0]['main']['aqi']),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 50),
              // Display the weather section
              const Column(
                children: [
                  Text(
                    ' Météo 🌤️ ',
                    style: TextStyle(
                        backgroundColor: Colors.cyan,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: MeteoService().getMeteo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      snapshot.data!['main']['temp'].toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      '°C',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Text(
                                      snapshot.data!['main']['feels_like']
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w100,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      '°C',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w100,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Text(
                              getWeatherImage(
                                  snapshot.data!['weather'][0]['main']),
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      snapshot.data!['wind']['speed']
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'km/h',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Text(
                                      getWindDirection(
                                          snapshot.data!['wind']['deg']),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w100,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const SizedBox(height: 50),
              // Display the nearest parkings section
              const Column(
                children: [
                  Text(
                    ' Places les plus proches 🚗 ',
                    style: TextStyle(
                      backgroundColor: Colors.cyan,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              if (_currentPosition != null)
                SingleChildScrollView(
                    child: Column(
                  children: [
                    ...nearestParkings.asMap().entries.map((entry) {
                      int index = entry.key;
                      Parking parking = entry.value;
                      bool isGrayBackground = index.isOdd;

                      return Container(
                        color:
                            isGrayBackground ? Colors.grey[200] : Colors.white,
                        child: ListTile(
                          // When tapping on a parking, display the parking
                          // description page
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ParkingDescriptionPage(parking: parking),
                              ),
                            );
                          },
                          title: Text(parking.completeName,
                              style: const TextStyle(fontSize: 18)),
                          trailing: Text('${parking.nbAvailableSpaces ?? 0}',
                              style: const TextStyle(fontSize: 18)),
                        ),
                      );
                    }),
                  ],
                )),
            ],
          ),
        ),
      ),
    );
  }

  // Method to get the color associated to the air quality index
  Color getAirQualityColor(int aqi) {
    if (aqi <= 1) {
      return Colors.green;
    } else if (aqi <= 2) {
      return Colors.yellow;
    } else if (aqi <= 3) {
      return Colors.orange;
    } else if (aqi <= 4) {
      return Colors.red;
    } else if (aqi <= 5) {
      return Colors.purple;
    } else {
      return Colors.brown;
    }
  }

  // Method to get the air quality text associated to the air quality index
  String getAirQuality(int aqi) {
    if (aqi <= 1) {
      return 'Bon 🍃';
    } else if (aqi <= 2) {
      return 'Moyen 😐';
    } else if (aqi <= 3) {
      return 'Mauvais pour les sensibles 🫁';
    } else if (aqi <= 4) {
      return 'Mauvais 😷';
    } else if (aqi <= 5) {
      return 'Très mauvais 🤮';
    } else {
      return 'Dangereux ☣️';
    }
  }

  // Method to get the wind direction associated to the wind degree
  String getWindDirection(int deg) {
    if (deg <= 22.5) {
      return '⬇️ Nord';
    } else if (deg <= 67.5) {
      return '↙️ Nord-Est';
    } else if (deg <= 112.5) {
      return '⬅️ Est';
    } else if (deg <= 157.5) {
      return '↖️ Sud-Est';
    } else if (deg <= 202.5) {
      return '⬆️ Sud';
    } else if (deg <= 247.5) {
      return '↗️ Sud-Ouest';
    } else if (deg <= 292.5) {
      return '➡️ Ouest';
    } else if (deg <= 337.5) {
      return '↘️ Nord-Ouest';
    } else {
      return '⬇️ Nord';
    }
  }

  // Method to get the weather image associated to the weather
  String getWeatherImage(String weather) {
    switch (weather) {
      case 'Clear':
        return '☀️';
      case 'Clouds':
        return '☁️';
      case 'Rain':
        return '🌧️';
      case 'Snow':
        return '❄️';
      case 'Thunderstorm':
        return '⛈️';
      case 'Drizzle':
        return '🌧️';
      case 'Mist':
        return '🌫️';
      case 'Smoke':
        return '🌫️';
      case 'Haze':
        return '🌫️';
      case 'Dust':
        return '🌫️';
      case 'Fog':
        return '🌫️';
      case 'Sand':
        return '🌫️';
      case 'Ash':
        return '🌫️';
      case 'Squall':
        return '🌫️';
      case 'Tornado':
        return '🌪️';
      default:
        return '☀️';
    }
  }
}

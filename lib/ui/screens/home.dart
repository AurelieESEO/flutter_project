import 'package:flutter/material.dart';
import 'package:flutter_project/models/parking.dart';

import '../../services/air_quality_service.dart';
import '../../services/meteo_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required List<Parking> parkings}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final String apiAirQualityKey = 'YOUR_API_KEY';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Colors.white38,
              padding: const EdgeInsets.all(20),
              child: const Text(
                'Bienvenue sur\nPark me Angers ! 🅿️🏰',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  color: Colors.cyan
                ),
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
            Column(
              children: [
                const Text(
                  ' Qualité de l\'air 🌬️ ',
                  style: TextStyle(
                    backgroundColor: Colors.cyan,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.white
                  ),
                ),
                const SizedBox(height: 15),
                FutureBuilder(
                  future: AirQualityService().getAirQuality(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            snapshot.data!['results'][0]['sous_indice_2_polluant'].toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: getAirQualityColor(int.parse(snapshot.data!['results'][0]['sous_indice_2_polluant'])),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            getAirQuality(int.parse(snapshot.data!['results'][0]['sous_indice_2_polluant'])),
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
            const Column(
              children: [
                Text(
                  ' Météo 🌤️ ',
                  style: TextStyle(
                    backgroundColor: Colors.cyan,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.white
                  ),
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
                                    snapshot.data!['main']['feels_like'].toString(),
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
                            getWeatherImage(snapshot.data!['weather'][0]['main']),
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
                                  snapshot.data!['wind']['speed'].toString(),
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
                                  getWindDirection(snapshot.data!['wind']['deg']),
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
          ],
        ),
      ),
    );
  }

  Color getAirQualityColor(int index) {
    if (index <= 50) {
      return Colors.green;
    } else if (index <= 100) {
      return Colors.yellow;
    } else if (index <= 150) {
      return Colors.orange;
    } else if (index <= 200) {
      return Colors.red;
    } else if (index <= 300) {
      return Colors.purple;
    } else {
      return Colors.brown;
    }
  }

  String getAirQuality(int index) {
    if (index <= 50) {
      return 'Bon';
    } else if (index <= 100) {
      return 'Moyen';
    } else if (index <= 150) {
      return 'Mauvais pour les sensibles';
    } else if (index <= 200) {
      return 'Mauvais';
    } else if (index <= 300) {
      return 'Très mauvais';
    } else {
      return 'Dangereux';
    }
  }

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
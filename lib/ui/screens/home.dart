import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              'Bienvenue sur\nPark me Angers',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
                color: Colors.cyan
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Text(
                  'Qualité de l\'air',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w200,
                    color: Colors.cyan
                  ),
                ),
                // display local air quality

              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Text(
                  'Météo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w200,
                    color: Colors.cyan
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Text(
                  'Parkings les plus proches',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w200,
                    color: Colors.cyan
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
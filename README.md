# Park Me Angers - Flutter

## Getting started

This project enables you to find out how many spaces are available in the various car parks in Angers and to obtain the information associated with them.
You can also find out about the city's air quality and the weather.

### List of all packages used:
- cupertino_icons for Cupertino-style icons
- http to make HTTP requests
- flutter_map to integrate interactive maps
- latlong2 for manipulating geographic coordinates
- flutter_bloc for managing reports in Flutter applications using the BLoC (Business Logic Component) design model (simplifies the management of complex reports)
- shared_preferences to store data persistently on the user's device.
- url_launcher provides a simple way of launching external URLs
- geolocator makes it easier to locate the device.

### Install the project

First clone the project:

```bash
git clone https://172.24.7.8/chamouau/flutter_project
cd flutter_project
```

Then install the dependencies:

```
flutter pub get
```

### Api keys

You can enter your own api keys in the following files:

First api key for the api https://openweathermap.org/api
- lib/services/air_quality_service.dart
- lib/services/meteo_service.dart

Second api key for the api https://data.angers.fr/pages/home/
- lib/services/parking_description_service.dart
- lib/services/parking_disponbilities_service.dart

### Possible problem:
The application uses geolocation. It should therefore ask for your permission to access this data when you first open it.
If the application does not ask for this information and therefore does not have access to it, the section at the bottom of the home page concerning the nearest car parks will not be displayed.
The rest, however, should work

### Run the project
```bash
flutter run
```

### How the application works
- Home page:
The home page displays the air quality and weather information for the city of Angers.
When clicking on a parking at the bottom of this page, the user is redirected to the page of the selected parking with all its information.
- Map page:
The map page displays the location of the various car parks in Angers.
When clicking on a parking, the user is redirected to the page of the selected parking with all its information.
- List page:
The list page displays the list of all car parks in Angers in a list.
When clicking on a parking, the user is redirected to the page of the selected parking with all its information.

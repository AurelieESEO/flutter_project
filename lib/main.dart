import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/blocks/parking_cubit.dart';
import 'package:flutter_project/services/preferences.dart';
import 'package:flutter_project/ui/screens/my_home.dart';

Future<void> main() async {
  // To use the SharePreferences before the runApp() method
  WidgetsFlutterBinding.ensureInitialized();

  // Instanciation du Cubit
  final ParkingCubit parkingCubit = ParkingCubit(PreferencesRepository());

  // // Chargement des entreprises
  // await parkingCubit.loadParkings();

  runApp(BlocProvider<ParkingCubit>(
    create: (_) => parkingCubit,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Park me Angers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const MyHome(),
    );
  }
}

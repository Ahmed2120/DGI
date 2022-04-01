import 'package:dgi/Services/ServerService.dart';
import 'package:dgi/model/country.dart';
import 'package:dgi/screens/administrator_screen.dart';
import 'package:dgi/screens/assets_capture_screen.dart';
import 'package:dgi/screens/assets_counter_screen.dart';
import 'package:dgi/screens/assets_custodian.dart';
import 'package:dgi/screens/assets_verification_screen.dart';
import 'package:dgi/screens/auth_screen.dart';
import 'package:dgi/screens/home_page.dart';
import 'package:dgi/screens/item_capture_screen.dart';
import 'package:dgi/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/assets_check.dart';
import 'screens/assets_details.dart';

Future<void> main() async {
  final serverService = ServerService();
  List<Country> countries = await serverService.getAllCountries();
  print(countries[0].id.toString() + countries[0].name);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'SAGECO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF0F6671)
        ),
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat'
      ),
      home: const SplashScreen(),
    );
  }
}

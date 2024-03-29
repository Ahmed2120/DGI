import 'package:dgi/Services/SettingService.dart';
import 'package:dgi/model/settings.dart';
import 'package:dgi/screens/assets_capture_screen.dart';
import 'package:dgi/screens/assets_check.dart';
import 'package:dgi/screens/auth_screen.dart';
import 'package:dgi/screens/home_page.dart';
import 'package:dgi/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'db/cash_helper.dart';
import 'model/assetLocation.dart';
import 'screens/check_item/scan_item.dart';
import 'screens/item_verification_newPage.dart';
import 'screens/light_events_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  final settingService = SettingService();
  List<Setting> settings = await settingService.retrieve();
  String pdaNo="";
  print('pda: ${settings.length}');
  if(settings.isNotEmpty){
    pdaNo = settings[0].pdaNo;
  }
  runApp(MyApp(pdaNo: pdaNo,));
}

class MyApp extends StatelessWidget {
  String pdaNo;
  MyApp({Key? key,required this.pdaNo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    print('PdaNo: $pdaNo');
    return MaterialApp(
      title: 'SAGECO',
      initialRoute: '/',
      routes: {
        '/login': (context) => AuthScreen(pdaNo: pdaNo),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF0F6671)
        ),
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat'
      ),
      home: SplashScreen(pdaNo: pdaNo,),
      // home: ScanItemScreen(),
    );
  }
}

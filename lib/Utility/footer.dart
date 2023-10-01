import 'package:dgi/authentication.dart';
import 'package:flutter/material.dart';

import '../Services/SettingService.dart';
import '../language.dart';
import '../model/settings.dart';

class Footer extends StatefulWidget {
  Footer({Key? key}) : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  final lang = Language();

  String pdaNo = '';

  @override
  void initState() {
    super.initState();
    getPda().then((value) => pdaNo = value);
  }

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    // print('hhh ${dSize.height * 0.01}');
    // print('hhh ${dSize.width * 0.04}');
    return Directionality(
      textDirection: Language.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Container(
          width: double.infinity,
          height: Language.isEn ? dSize.height * 0.04 : dSize.height * 0.03,
          padding:
          EdgeInsets.symmetric(vertical: dSize.height * 0.002, horizontal: 20),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF26BB9B),
                    Color(0xFF00B0BD),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0, 1])),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${lang.getTxt('user_name')} : ${Authentication.userName}',
                style: TextStyle(
                    color: Colors.white, fontSize: dSize.width <= 551 ? dSize.width * 0.03 : 15.36),
              ),
              Text(
                '${lang.getTxt('pda')} : $pdaNo',
                style: TextStyle(
                    color: Colors.white, fontSize: dSize.width <= 551 ? dSize.width * 0.03 : 15.36),
              ),
            ],
          )),
    );
  }

  Future<String> getPda() async{
    final settingService = SettingService();
    List<Setting> settings = await settingService.retrieve();
    String pdaNo="";
    print('pda: ${settings.length}');
    if(settings.isNotEmpty){
      pdaNo = settings[0].pdaNo;
      return pdaNo;
    }
    return '';
  }
}

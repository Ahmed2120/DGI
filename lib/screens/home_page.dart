import 'package:dgi/screens/about.dart';
import 'package:dgi/screens/assets_capture_screen.dart';
import 'package:dgi/screens/assets_verification_screen.dart';
import 'package:dgi/screens/item_capture_screen.dart';
import 'package:dgi/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'assets_counter_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dsize = MediaQuery.of(context).size;
    print('hhhi ${dsize.height * 0.0042}');
    print('hhh ${dsize.width * 0.009}');
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xFF26BB9B),
                      Color(0xFF00B0BD),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0, 1])),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical:dsize.height * 0.041, horizontal: 30),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'HOME',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: dsize.height * 0.015, bottom: dsize.height * 0.013),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xFFFFA227),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icons/0-22.png',
                          width: dsize.width * 0.5,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: dsize.height * 0.008),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'FIXED ASSET RACKING Software v 1.0.0',
                            style: TextStyle(
                              fontSize: dsize.width * 0.039,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(dsize.height * 0.0152),
                    height: dsize.height * 0.647,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(40)),
                    child: GridView.count(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding:
                          EdgeInsets.symmetric(vertical: dsize.height * 0.0092, horizontal: dsize.width * 0.04),
                      children: [
                        InkWell(
                          child: buildColumn('ITEM CAPTURE', dsize, '1-15'),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ItemCapture())),
                        ),
                        InkWell(
                          child:
                              buildColumn('ASSET VERIFICATION', dsize, '1-12'),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AssetsVerification())),
                        ),
                        InkWell(
                          child: buildColumn('ASSET COUNTER', dsize, '1-13'),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AssetsCounter())),
                        ),
                        InkWell(
                          child: buildColumn('ABOUT US', dsize, '0-19'),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const AboutUs())),
                        ),
                        InkWell(
                          child: buildColumn('SETTINGS', dsize, '0-20'),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Settings())),
                        ),
                      ],
                      crossAxisCount: 2,
                        childAspectRatio: (dsize.width * 0.009) / (dsize.height * 0.00455),
                        crossAxisSpacing: dsize.width * 0.009,
                        mainAxisSpacing: dsize.height * 0.0227,
                      // ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: dsize.height * 0.0029),
                    child: Text('SAGECO Dashboard',
                        style: TextStyle(
                            color: Color(0xFF0F6671),
                            fontSize: dsize.width * 0.042,
                            fontFamily: 'Montserrat')),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildColumn(String title, dsize, String img) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF).withOpacity(0.3),
              borderRadius: BorderRadius.circular(20)),
          child: Image.asset('assets/icons/$img.png', height: dsize.height * 0.122,),
        ),
        SizedBox(height: dsize.height * 0.0044,),//2
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: dsize.height * 0.01780),
        ),
      ],
    );
  }
}

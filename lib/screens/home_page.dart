import 'package:dgi/screens/assets_capture_screen.dart';
import 'package:dgi/screens/assets_verification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'assets_counter_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dsize = MediaQuery.of(context).size;
    // print('hhh ${dsize.height * 0.0042}');
    // print('hhh ${dsize.width * 0.092}');
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
            padding: EdgeInsets.all(dsize.height * 0.0412),
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
                    margin: EdgeInsets.only(top: 10, bottom: 20),
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
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            'FIXED ASSET RACKING Software v 1.0.0',
                            style: TextStyle(
                              fontSize: 15,
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
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(40)),
                    child: GridView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding:
                          EdgeInsets.symmetric(vertical: dsize.height * 0.0092, horizontal: 25),
                      children: [
                        InkWell(
                          child: buildColumn('Assets Capture', dsize, '1-15'),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AssetsCapture())),
                        ),
                        InkWell(
                          child:
                              buildColumn('Asset Verification', dsize, '1-12'),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AssetsVerification())),
                        ),
                        InkWell(
                          child: buildColumn('Asset Counter', dsize, '1-13'),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AssetsCounter())),
                        ),
                        InkWell(
                          child: buildColumn('ABOUT us', dsize, '0-19'),
                          // onTap: () => Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //         builder: (context) => AssetsCapture())),
                        ),
                        InkWell(
                          child: buildColumn('SETTINGS', dsize, '0-20'),
                          // onTap: () => Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //         builder: (context) => AssetsCapture())),
                        ),
                      ],
                      gridDelegate:
                          SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 130,
                        childAspectRatio: (dsize.height * 0.00331) / (dsize.height * 0.0033),
                        crossAxisSpacing: dsize.width * 0.094,
                        mainAxisSpacing: dsize.height * 0.03515,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(dsize.height * 0.0029),
                    child: Text('FATS Dashboard',
                        style: TextStyle(
                            color: Color(0xFF0F6671),
                            fontSize: 15,
                            fontFamily: 'Montserrat')),
                  )
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: double.infinity,
          height: dsize.height * 0.1,
          decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF).withOpacity(0.3),
              borderRadius: BorderRadius.circular(20)),
          child: Image.asset('assets/icons/$img.png'),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: dsize.height * 0.01786),
        ),
      ],
    );
  }
}

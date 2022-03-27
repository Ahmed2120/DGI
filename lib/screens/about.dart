import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utility/CustomWidgetBuilder.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    print('hhh ${dSize.height * 0.01}');
    print('hhh ${dSize.width * 0.04}');
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: dSize.height * 0.35,
              padding: EdgeInsets.symmetric(vertical: dSize.height * 0.02),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFF26BB9B),
                        Color(0xFF00B0BD),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0, 1])),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Text(
                      'ABOUT US',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF0F6671),
                          fontSize: dSize.width * 0.039, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: dSize.height * 0.035,
                  ),
                  Image.asset('assets/icons/0-18.png')
                ],
              ),
            ),
            Text(
              'SAGECO SYSTEM',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF0F6671), fontSize: dSize.width * 0.039, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomWidgetBuilder.buildArrow(
                      context,
                      dSize,
                      Icon(Icons.arrow_back_ios_rounded),
                          () => Navigator.of(context).pop()),
                ],
              ),
            ),
            Container(
                width: double.infinity,
                height: dSize.height * 0.05,
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF26BB9B),
                          Color(0xFF00B0BD),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0, 1])),
                child: Text(
                  'SAGECO SYSTEM',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF0F6671), fontSize: dSize.width * 0.039, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}

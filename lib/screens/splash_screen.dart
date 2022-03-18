import 'dart:async';

import 'package:dgi/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 3600), ()=>
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage()))
    );
  }

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    print('hhh ${dSize.height * 0.0412}');
    print('hhh ${dSize.width * 0.315}');
    return Scaffold(
      backgroundColor: Color(0xFFFFA227),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/0-18.png',
                    ),
                    LinearPercentIndicator(
                      width: 200,
                      alignment: MainAxisAlignment.center,
                      barRadius: Radius.circular(12),
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 1500,
                      percent: 1,
                      // linearStrokeCap: LinearStrokeCap.roundAll,
                      linearGradient: const LinearGradient(
                          colors: [
                            Color(0xFF26BB9B),
                            Color(0xFF00B0BD),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0, 1]),
                    ),
                  ],
                ),
              ),
              const Text(
                'Internal Version',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 18,
                ),
              ),
              const Text(
                'V 1.0.0',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

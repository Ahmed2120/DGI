import 'dart:async';
import 'package:dgi/screens/administrator_screen.dart';
import 'package:dgi/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SplashScreen extends StatefulWidget {
  String pdaNo;
  SplashScreen({Key? key,required this.pdaNo}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 3000), () {
      if(widget.pdaNo != ""){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AuthScreen(pdaNo: widget.pdaNo,)));
      }else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Administrator()));
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utility/CustomWidgetBuilder.dart';
import 'auth_screen.dart';

class Administrator extends StatefulWidget {
  const Administrator({Key? key}) : super(key: key);

  @override
  State<Administrator> createState() => _AdministratorState();
}

class _AdministratorState extends State<Administrator> {
  final GlobalKey<FormState> _formKey = GlobalKey();

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
                  Image.asset('assets/icons/0-18.png', width: dSize.height * 0.2,),
                  SizedBox(
                    height: dSize.height * 0.06,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Text(
                      'ADMINISTRATOR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF0F6671),
                          fontSize: dSize.height * 0.025, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Container(
                      // alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(bottom: 5),

                      child: CustomWidgetBuilder.buildText('PLEASE ENTER', dSize)
                    ),
                    SizedBox(
                      height: dSize.height * 0.035,
                    ),
                    Row(
                      children: [
                        CustomWidgetBuilder.buildText('PDA NO', dSize),
                        Spacer(),
                        Container(
                          width: dSize.width * 0.4,
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xFF00B0BD), width: 2)),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              constraints: BoxConstraints(maxHeight: 20),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: dSize.height * 0.035,
                    ),
                    Row(
                      children: [
                        CustomWidgetBuilder.buildText('PDA NAME', dSize),
                        Spacer(),
                        Container(
                          width: dSize.width * 0.4,
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xFF00B0BD), width: 2)),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              constraints: BoxConstraints(maxHeight: 20),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: dSize.height * 0.035,
                    ),
                    ElevatedButton(
                      child: Text('DONE', style: TextStyle(fontSize: dSize.height <= 500 ? dSize.height * 0.027 : 13.75),),
                      onPressed: ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> AuthScreen())),
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFFFA227),
                          textStyle: const TextStyle(fontSize: 20),
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          minimumSize: Size(dSize.width * 0.4, 34)),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
                width: double.infinity,
                height: dSize.height * 0.12,
                padding:
                EdgeInsets.symmetric(vertical: dSize.height * 0.007, horizontal: 20),
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
                    Text(
                      'ASSET TRACKING',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontSize: dSize.height <= 455 ? 9.5 : 13),
                    ),
                    Text(
                      'Internal Version',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontSize: dSize.height <= 455 ? 9.5 : 13),
                    ),
                    Text(
                      'v 1.0.0',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontSize: dSize.height <= 455 ? 9.5 : 13),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Text buildText(String title, dSize) {
    return Text(
      title,
      style:
      TextStyle(fontSize: dSize.width * 0.04, color: Color(0xFF0F6671), fontWeight: FontWeight.bold),
    );
  }
}

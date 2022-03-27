import 'package:dgi/Services/CategoryService.dart';
import 'package:dgi/Utility/DropDownMenu.dart';
import 'package:dgi/Utility/footer.dart';
import 'package:dgi/model/category.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utility/CustomWidgetBuilder.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  CategoryService categoryService = CategoryService();
  List<String> categories = [];

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
  }


  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    print('hhh ${dSize.height * 0.004}');
    print('hhh ${dSize.width * 0.04}');
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: dSize.height - 24,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: dSize.height * 0.15,
                    padding: EdgeInsets.symmetric(vertical: dSize.height * 0.015),
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
                        const Text(
                          'DGI ASSETS TRACKING',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: 'Montserrat'),
                        ),
                        SizedBox(
                          height: dSize.height * 0.035,
                        ),
                        Row(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 25),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFA227),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(12)),
                                ),
                                child: Text.rich(
                                  TextSpan(
                                      style: TextStyle(
                                          fontSize: dSize.height * 0.028,
                                          color: Colors.white,
                                          fontFamily: 'Montserrat'),
                                      children: const <InlineSpan>[
                                        TextSpan(
                                          text: 'ASSETS ',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: 'SETTINGS',
                                        ),
                                      ]),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: SizedBox(
                      height: dSize.height * 0.58,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                buildText('USER NAME:', dSize),
                                const Spacer(),
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
                            SizedBox(height: dSize.height * 0.01,),
                            Row(
                              children: [
                                buildText('PDA NO', dSize),
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
                            SizedBox(height: dSize.height * 0.01,),
                            Row(
                              children: [
                                buildText('SYNC NO', dSize),
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
                            SizedBox(height: dSize.height * 0.01,),
                            Row(
                              children: [
                                buildText('ITEM CAPTURE', dSize),
                                Spacer(),
                                Container(
                                  width: dSize.width * 0.19,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF00B0BD), width: 2.0),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      constraints: BoxConstraints(maxHeight: dSize.height * 0.045),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(width: dSize.width * 0.02,),
                                Container(
                                  width: dSize.width * 0.19,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF00B0BD), width: 2.0),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      constraints: BoxConstraints(maxHeight: dSize.height * 0.045),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: dSize.height * 0.01,),
                            Row(
                              children: [
                                buildText('ASSETS VERIFICATION', dSize),
                                Spacer(),
                                Container(
                                  width: dSize.width * 0.19,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF00B0BD), width: 2.0),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      constraints: BoxConstraints(maxHeight: dSize.height * 0.045),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(width: dSize.width * 0.02,),
                                Container(
                                  width: dSize.width * 0.19,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF00B0BD), width: 2.0),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      constraints: BoxConstraints(maxHeight: dSize.height * 0.045),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: dSize.height * 0.01,),
                            Row(
                              children: [
                                buildText('ASSETS POSITION', dSize),
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
                            SizedBox(height: dSize.height * 0.01,),
                            Row(
                              children: [
                                buildText('ASSETS COUNTER', dSize),
                                Spacer(),
                                Container(
                                  width: dSize.width * 0.19,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF00B0BD), width: 2.0),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      constraints: BoxConstraints(maxHeight: dSize.height * 0.045),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(width: dSize.width * 0.02,),
                                Container(
                                  width: dSize.width * 0.19,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF00B0BD), width: 2.0),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      constraints: BoxConstraints(maxHeight: dSize.height * 0.045),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: dSize.height * 0.01,),
                            DropDownMenu(title: 'LANGUAGE', values: ['EN', 'AR']),


                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                  const Footer()
                ],
              ),
            ),
          ),
        ));
  }

  Text buildText(String title, dSize) {
    return Text(
      title,
      style:
      TextStyle(fontSize: dSize.width * 0.04, color: Color(0xFF0F6671), fontWeight: FontWeight.bold),
    );
  }

}

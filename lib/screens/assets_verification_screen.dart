import 'package:dgi/screens/assets_details.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utility/CustomWidgetBuilder.dart';
import '../Utility/footer.dart';
import '../Utility/header.dart';

class AssetsVerification extends StatefulWidget {
  const AssetsVerification({Key? key}) : super(key: key);

  @override
  State<AssetsVerification> createState() => _AssetsVerificationState();
}

class _AssetsVerificationState extends State<AssetsVerification> {
  String? value;
  String? location;

  final GlobalKey<FormState> _formKey = GlobalKey();
  List<String> locations = ['STORE', 'BUILDING', 'OFFICE'];

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    print('hhh ${dSize.height * 0.01}');
    print('hhh ${dSize.width * 0.04}');
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: dSize.height - 24,
              child: Column(
                children: [
                  const Header(title: 'ASSETS', subTitle: 'VERIFICATION',),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: SizedBox(
                      height: dSize.height * 0.58,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(bottom: 5),
                              child: const Text('ASSET LOCATION INFORMATION', style:
                              TextStyle(fontSize: 13, color: Color(0xFF0F6671), fontWeight: FontWeight.bold),),
                            ),
                            Row(
                              children: [
                                buildText('CATEGORY', dSize),
                                const Spacer(),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xFF00B0BD), width: 2))),
                                  width: dSize.width * 0.4,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: value,
                                      iconSize: 30,
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Color(0xFF00B0BD),
                                      ),
                                      isDense: true,
                                      isExpanded: true,
                                      items:
                                      <String>['A', 'B', 'C', 'D'].map((String item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                                color: Color(0xFF0F6671), fontSize: 20),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          value = val;
                                        });
                                        print(val);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: dSize.height * 0.01,),
                            Row(
                              children: [
                                buildText('CITY', dSize),
                                Spacer(),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xFF00B0BD), width: 2))),
                                  width: dSize.width * 0.4,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: value,
                                      iconSize: 30,
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Color(0xFF00B0BD),
                                      ),
                                      isDense: true,
                                      isExpanded: true,
                                      items:
                                      <String>['A', 'B', 'C', 'D'].map((String item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                                color: Color(0xFF0F6671), fontSize: 20),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          value = val;
                                        });
                                        print(val);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: dSize.height * 0.01,),
                            Row(
                              children: [
                                buildText('AREA', dSize),
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
                                buildText('LOCATION TYPE', dSize),
                                Spacer(),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xFF00B0BD), width: 2))),
                                  width: dSize.width * 0.4,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: location,
                                      iconSize: 30,
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Color(0xFF00B0BD),
                                      ),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                      selectedItemBuilder: (BuildContext context) {
                                        return locations.map((String value) {
                                          return Text(
                                            value,
                                            style: const TextStyle(color: Color(0xFF0F6671)),
                                          );
                                        }).toList();
                                      },
                                      dropdownColor: Color(0xFF00B0BD),
                                      isDense: true,
                                      isExpanded: true,
                                      items:
                                      locations.map((String item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            // style: const TextStyle(
                                            //     color: Color(0xFF0F6671), fontSize: 20),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          location = val;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: dSize.height * 0.015,),
                            if(location == 'OFFICE' || location == 'BUILDING')
                              Row(
                                children: [
                                  buildText('FLOOR NO', dSize),
                                  Spacer(),
                                  Container(
                                    width: dSize.width * 0.4,
                                    decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xFF00B0BD), width: 2)),
                                    ),
                                    child: const TextField(
                                      decoration: InputDecoration(
                                        constraints: BoxConstraints(maxHeight: 20),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(height: dSize.height * 0.01,),
                            if(location == 'OFFICE' || location == 'BUILDING')
                              Row(
                                children: [
                                  buildText('SECTION NO', dSize),
                                  Spacer(),
                                  Container(
                                    width: dSize.width * 0.4,
                                    decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xFF00B0BD), width: 2)),
                                    ),
                                    child: const TextField(
                                      decoration: InputDecoration(
                                        constraints: BoxConstraints(maxHeight: 20),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(height: dSize.height * 0.01,),
                            if(location == 'OFFICE' || location == 'STORE')
                              Row(
                                children: [
                                  buildText('DEPARTMENT', dSize),
                                  const Spacer(),
                                  Container(
                                    width: dSize.width * 0.4,
                                    decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xFF00B0BD), width: 2)),
                                    ),
                                    child: const TextField(
                                      decoration: InputDecoration(
                                        constraints: BoxConstraints(maxHeight: 20),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(height: dSize.height * 0.01,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomWidgetBuilder.buildArrow(context, Icon(Icons.arrow_back_ios_rounded), ()=>Navigator.of(context).pop()),
                        CustomWidgetBuilder.buildArrow(context, Icon(Icons.arrow_forward_ios), ()=> Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => AssetsDetails()))),
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

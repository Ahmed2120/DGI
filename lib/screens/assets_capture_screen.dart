import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssetsCapture extends StatefulWidget {
  const AssetsCapture({Key? key}) : super(key: key);

  @override
  State<AssetsCapture> createState() => _AssetsCaptureState();
}

class _AssetsCaptureState extends State<AssetsCapture> {

  String? selectedValue;
  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: dSize.height * 0.15,
            padding: EdgeInsets.symmetric(vertical: 12),
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
                  'DGI ASSETS TRCKING',
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
                                  text: 'CAPTURE',
                                ),
                              ]),
                        )),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('CATEGORY'),
                      Spacer(),
                      CustomDropdownButton2(
                        hint: 'Select Category',
                        dropdownItems: items,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                    ],
                  ),Row(
                    children: const [
                      Text('ITEM DESC'),
                      // TextField(
                      //   cursorWidth: 2,
                      // )
                    ],
                  ),Row(
                    children: const [
                      Text('QANTITY'),

                    ],
                  ),Row(
                    children: const [
                      Text('PHOTO'),

                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

import 'package:dgi/Utility/footer.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utility/CustomWidgetBuilder.dart';

class AssetsCheck extends StatefulWidget {
  const AssetsCheck({Key? key}) : super(key: key);

  @override
  State<AssetsCheck> createState() => _AssetsCheckState();
}

class _AssetsCheckState extends State<AssetsCheck> {
  String? value;

  final GlobalKey<FormState> _formKey = GlobalKey();

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
              Container(
                width: double.infinity,
                height: dSize.height * 0.20,
                padding: EdgeInsets.symmetric(vertical: dSize.height * 0.007),
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
                                  ),
                                  children: const <InlineSpan>[
                                    TextSpan(
                                      text: 'ASSETS ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: 'Counter',
                                    ),
                                  ]),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: dSize.height * 0.018,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'ASSETS TOTAL : 1000235',
                            style: TextStyle(
                                color: Color(0xFF0F6671),
                                fontSize: dSize.width * 0.031),
                          ),
                          Text(
                            'REMAIN : 1000235',
                            style: TextStyle(
                                color: Color(0xFF0F6671),
                                fontSize: dSize.width * 0.031),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: SizedBox(
                  height: dSize.height * 0.635,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            buildText('BARCODE', dSize),
                            const Spacer(),
                            Container(
                              padding: EdgeInsets.all(10),
                              width: dSize.width * 0.4,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xFF00B0BD), width: 2.0),
                              ),
                              child: Text('barcode'),
                            ),
                            SizedBox(
                              width: dSize.width * 0.03,
                            ),
                            Column(
                              children: [
                                checkContainer(dSize, Icon(Icons.close),
                                    Color(0xFFFFA227)),
                                SizedBox(
                                  height: dSize.height * 0.01,
                                ),
                                checkContainer(dSize, Icon(Icons.check),
                                    Color(0xFF00B0BD)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: dSize.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                // alignment: Alignment.centerRight,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFF00B0BD), width: 2.0),
                                ),
                                height: 100,
                                child: Image.asset(
                                  'assets/icons/img.png',
                                  fit: BoxFit.cover,
                                  width: dSize.width * 0.477,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: dSize.height * 0.01,
                        ),
                        Row(
                          children: [
                            buildText('ASSET DESC', dSize),
                            const Spacer(),
                            Container(
                              width: dSize.width * 0.488,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xFF00B0BD), width: 2.0),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  constraints: BoxConstraints(
                                      maxHeight: dSize.height * 0.045),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: dSize.height * 0.01,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                height: dSize.height * 0.25,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: ListView(
                                    reverse: true,
                                    children: [
                                      Table(
                                        border: TableBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        children: [
                                          buildRow(
                                              ['NO', 'ASSETS', 'DESC', 'CHECK'],
                                              isHeader: true),
                                          buildRow([
                                            'NO',
                                            'ASSETS',
                                            'DESC',
                                            'PHOTO'
                                          ]),
                                          buildRow([
                                            'NO',
                                            'ASSETS',
                                            'DESC',
                                            'PHOTO'
                                          ]),
                                          buildRow([
                                            'NO',
                                            'ASSETS',
                                            'DESC',
                                            'PHOTO'
                                          ]),
                                          buildRow([
                                            'NO',
                                            'ASSETS',
                                            'DESC',
                                            'PHOTO'
                                          ]),
                                          buildRow([
                                            'NO',
                                            'ASSETS',
                                            'DESC',
                                            'PHOTO'
                                          ]),
                                          buildRow([
                                            'NO',
                                            'ASSETS',
                                            'DESC',
                                            'PHOTO'
                                          ]),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('CLICK THE ASSETS FOR MORE DETAILS', style: TextStyle(color: Color(0xFF00B0BD), fontSize: dSize.width * 0.03),),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      buildText('100236', dSize),
                                      buildText('TOTAL ASSETS', dSize),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      buildText('100184', dSize),
                                      checkContainer(dSize, Icon(Icons.check),
                                          Color(0xFF00B0BD)),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      buildText('50', dSize),
                                      checkContainer(dSize, Icon(Icons.close),
                                          Color(0xFFFFA227)),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomWidgetBuilder.buildArrow(context, Icon(Icons.arrow_back_ios), ()=>Navigator.of(context).pop()),
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

  Container checkContainer(Size dSize, Icon icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: dSize.height * 0.0001, horizontal: dSize.width * 0.009),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Icon(
        icon.icon,
        color: Colors.white,
        size: 15,
      ),
    );
  }

  Text buildText(String title, dSize) {
    return Text(
      title,
      style: TextStyle(
          fontSize: dSize.width * 0.03,
          color: Color(0xFF0F6671),
          fontWeight: FontWeight.bold),
    );
  }

  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
        decoration: BoxDecoration(
            color: isHeader ? Color(0xFFFFA227) : Colors.grey[200],
            borderRadius: isHeader
                ? BorderRadius.circular(10)
                : BorderRadius.circular(0)),
        children: cells
            .map((cell) => Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    cell,
                    style: TextStyle(
                        color: isHeader ? Colors.white : Color(0xFF0F6671),
                        fontWeight:
                            isHeader ? FontWeight.bold : FontWeight.normal),
                  ),
                ))
            .toList(),
      );
}

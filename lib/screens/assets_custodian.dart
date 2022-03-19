import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssetsCustodian extends StatefulWidget {
  const AssetsCustodian({Key? key}) : super(key: key);

  @override
  State<AssetsCustodian> createState() => _AssetsCustodianState();
}

class _AssetsCustodianState extends State<AssetsCustodian> {
  String? value;

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    print('hhh ${dSize.height * 0.03}');
    print('hhh ${dSize.width * 0.03}');
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
                              color: Colors.white,),
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
                                          text: 'CUSTODIAN',
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
                          decoration: BoxDecoration(
                              color: Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('ASSETS TOTAL : 1000235', style:
                              TextStyle(color: Color(0xFF0F6671), fontSize: dSize.width * 0.031),),
                              Text('REMAIN : 1000235', style:
                              TextStyle(color: Color(0xFF0F6671), fontSize: dSize.width * 0.031),),
                            ],
                          ),
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
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: dSize.height * 0.03),
                              child: Row(
                                children: [
                                  buildText('EMP ID', dSize),
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
                                  SizedBox(width: dSize.width * 0.03,),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: dSize.height * 0.002, horizontal: dSize.width * 0.04),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF00B0BD),

                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Icon(Icons.check, color: Colors.white,),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  height: dSize.height * 0.38,
                                  child: ListView(
                                    children: [
                                      Table(
                                        border: TableBorder(borderRadius: BorderRadius.circular(10)),
                                        children: [
                                          buildRow(['NO', 'ASSETS', 'DESC', 'PHOTO'], isHeader: true),
                                          buildRow(['NO', 'ASSETS', 'DESC', 'PHOTO']),
                                          buildRow(['NO', 'ASSETS', 'DESC', 'PHOTO']),
                                          buildRow(['NO', 'ASSETS', 'DESC', 'PHOTO']),
                                          buildRow(['NO', 'ASSETS', 'DESC', 'PHOTO']),
                                          buildRow(['NO', 'ASSETS', 'DESC', 'PHOTO']),
                                          buildRow(['NO', 'ASSETS', 'DESC', 'PHOTO']),
                                          buildRow(['NO', 'ASSETS', 'DESC', 'PHOTO']),
                                          buildRow(['NO', 'ASSETS', 'DESC', 'PHOTO']),
                                          buildRow(['NO', 'ASSETS', 'DESC', 'PHOTO']),
                                          buildRow(['NO', 'ASSETS', 'DESC', 'PHOTO']),
                                          buildRow(['NO', 'ASSETS', 'DESC', 'PHOTO']),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('CLICK THE ASSETS FOR MORE DETAILS', style: TextStyle(color: Color(0xFF00B0BD), fontSize: dSize.width * 0.03),),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 15, top: 15),
                                  child: Text('ITEM TOTAL     000', style: TextStyle(color: Color(0xFF0F6671), fontWeight: FontWeight.bold),), alignment: Alignment.centerLeft,),
                              ],
                            ),),
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
                        Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xFF00B0BD),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Icon(Icons.arrow_back_ios, color: Colors.white,),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      height: dSize.height * 0.05,
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color(0xFF26BB9B),
                                Color(0xFF00B0BD),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0, 1])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'USER NAME : MO GAMAL',
                            style: TextStyle(color: Colors.white, fontSize: dSize.width * 0.037),
                          ),
                          Text(
                            'PDA NO : 1023088',
                            style: TextStyle(color: Colors.white, fontSize: dSize.width * 0.037),
                          ),
                        ],
                      ))
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

  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
    decoration: BoxDecoration(
        color: isHeader ? Color(0xFFFFA227) : Colors.grey[200],
        borderRadius: isHeader ? BorderRadius.circular(10) : BorderRadius.circular(0)
    ),
    children: cells.map((cell)=> Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(cell, style: TextStyle(color: isHeader ? Colors.white : Color(0xFF0F6671), fontWeight: isHeader ? FontWeight.bold : FontWeight.normal),),
    )).toList(),
  );
}

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssetsCapture extends StatefulWidget {
  const AssetsCapture({Key? key}) : super(key: key);

  @override
  State<AssetsCapture> createState() => _AssetsCaptureState();
}

class _AssetsCaptureState extends State<AssetsCapture> {
  String? value;

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: dSize.height - 24,
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
                    const Text(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'CATEGORY',
                            style:
                                TextStyle(fontSize: 16, color: Color(0xFF0F6671)),
                          ),
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
                      Row(
                        children: [
                          const Text('ITEM DESC'),
                          Spacer(),
                          Container(
                            width: dSize.width * 0.4,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFF00B0BD), width: 2.0),
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('QUANTITY'),
                          Spacer(),
                          SizedBox(
                            width: dSize.width * 0.4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Color(0xFFFFA227),
                                  foregroundColor: Colors.white,
                                  radius: 12,
                                  child: Icon(Icons.add),
                                ),
                                const SizedBox(width: 10,),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 25),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF00B0BD), width: 2.0),
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: const Text('1', style: TextStyle(
                                      color: Color(0xFF0F6671), fontSize: 17, fontWeight: FontWeight.bold),),
                                ),
                                const SizedBox(width: 10,),
                                const CircleAvatar(
                                  backgroundColor: Color(0xFF00B0BD),
                                  foregroundColor: Colors.white,
                                  radius: 12,
                                  child: Icon(Icons.add),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text('PHOTO'),
                          Spacer(),
                          SizedBox(
                            width: dSize.width * 0.4,
                            child: Image.asset('assets/icons/0-16.jpg', height: 40, alignment: Alignment.centerLeft,),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('ADD ', style:
                          const TextStyle(fontSize: 13, color: Color(0xFF0F6671), fontWeight: FontWeight.bold),),
                          Icon(Icons.add, size: 17, color: Color(0xFF00B0BD),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: dSize.height * 0.33,
                    child: ListView(
                      children: [
                        Table(
                          border: TableBorder(borderRadius: BorderRadius.circular(10)),
                          children: [
                            buildRow(['NO', 'TYPE', 'DESC', 'QTY', 'PHOTO'], isHeader: true),
                            buildRow(['NO', 'TYPE', 'DESC', 'QTY', 'PHOTO']),
                            buildRow(['NO', 'TYPE', 'DESC', 'QTY', 'PHOTO']),
                            buildRow(['NO', 'TYPE', 'DESC', 'QTY', 'PHOTO']),
                            buildRow(['NO', 'TYPE', 'DESC', 'QTY', 'PHOTO']),
                            buildRow(['NO', 'TYPE', 'DESC', 'QTY', 'PHOTO']),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Text('ITEM TOTAL     000', style: TextStyle(color: Color(0xFF0F6671), fontWeight: FontWeight.bold),), alignment: Alignment.centerLeft,),
                ],
              ),),
              Container(
                  width: double.infinity,
                  height: dSize.height * 0.07,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                      Text('USER NAME : MO GAMAL', style: TextStyle(color: Colors.white),),
                      Text('PDA NO : 1023088', style: TextStyle(color: Colors.white),),
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    ));
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

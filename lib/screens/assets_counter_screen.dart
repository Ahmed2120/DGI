import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssetsCounter extends StatefulWidget {
  const AssetsCounter({Key? key}) : super(key: key);

  @override
  State<AssetsCounter> createState() => _AssetsCounterState();
}

class _AssetsCounterState extends State<AssetsCounter> {
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
                    height: dSize.height * 0.20,
                    padding: EdgeInsets.only(top: 12),
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
                          decoration: BoxDecoration(
                              color: Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('DATE : 14-03-2022', style:
                              const TextStyle(color: Color(0xFF0F6671)),),
                              Text('TIME : 24,00', style:
                              const TextStyle(color: Color(0xFF0F6671)),),
                              Text('NO. : 01223997', style:
                              const TextStyle(color: Color(0xFF0F6671)),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Flexible(
                      child: Container(
                        height: dSize.height * 0.58,
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
                                buildText('CATEGORY'),
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
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                buildText('CITY'),
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
                            const SizedBox(height: 15,),
                            Row(
                              children: [
                                buildText('AREA'),
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
                            const SizedBox(height: 15,),
                            Row(
                              children: [
                                buildText('DEPARTMENT'),
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
                            const SizedBox(height: 15,),
                            Row(
                              children: [
                                buildText('BUSINESS UNIT'),
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
                            const SizedBox(height: 15,),
                            Row(
                              children: [
                                buildText('NAME'),
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
                            const SizedBox(height: 15,),
                            Row(
                              children: [
                                buildText('BLDG NAME'),
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
                            const SizedBox(height: 15,),
                            Row(
                              children: [
                                buildText('BLDG ADDRESS'),
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
                            const SizedBox(height: 15,),
                            Row(
                              children: [
                                buildText('BUILDING NO'),
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
                                      constraints: BoxConstraints(maxHeight: 15),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            Row(
                              children: [
                                buildText('FLOOR NO'),
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
                        Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xFF00B0BD),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Icon(Icons.arrow_forward_ios, color: Colors.white,),
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
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'PDA NO : 1023088',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ));
  }

  Text buildText(String title) {
    return Text(
      title,
      style:
      const TextStyle(fontSize: 13, color: Color(0xFF0F6671), fontWeight: FontWeight.bold),
    );
  }
}

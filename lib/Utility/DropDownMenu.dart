import 'package:dgi/model/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget{
  List<String> values;
  String title;
  DropDownMenu({Key? key,required this.title,required this.values}) : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {

  String? value;
  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    return Row(
      children: [
        Text(
          widget.title,
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
              widget.values.map((String item) {
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
              },
            ),
          ),
        ),
      ],
    );
  }
}
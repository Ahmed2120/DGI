import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustomWidgetBuilder.dart';

class DropDownMenuRow extends StatelessWidget {
  List<String> values;
  final String title;
  final String? value;
  final Size dSize;
  Function onChange;

  DropDownMenuRow(
      {Key? key,
      required this.title,
      required this.dSize,
      required this.values,
      required this.onChange,
        this.value})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    return Row(
      children: [
        CustomWidgetBuilder.buildText(title, dSize),
        Spacer(),
        Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xFF00B0BD), width: 2))),
          width: dSize.width * 0.5,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                value: value,
                iconSize: 20,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xFF00B0BD),
                ),
                isDense: true,
                isExpanded: true,
                items: values.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                          color: Color(0xFF0F6671), fontSize: 15),
                    ),
                  );
                }).toList(),
                onChanged: (val) => {onChange(val)}),
          ),
        ),
      ],
    );
  }
}

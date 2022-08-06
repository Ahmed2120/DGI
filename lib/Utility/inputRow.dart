import 'package:flutter/material.dart';

import '../language.dart';
import 'CustomWidgetBuilder.dart';

class InputRow extends StatelessWidget {
  const InputRow({
    Key? key,
    required this.title,
    required this.dSize,
    required this.controller,
    this.textType,
    this.hintText,
  }) : super(key: key);

  final String title;
  final Size dSize;
  final TextEditingController controller;
  final TextInputType? textType;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomWidgetBuilder.buildText(title, dSize),
        Spacer(),
        Container(
          width: dSize.width * 0.5,
          child: TextFormField(
            keyboardType: textType,
            controller: controller,
            style: TextStyle(fontSize: dSize.height <= 500 ? 10 : dSize.height * 0.02),
            decoration: InputDecoration(
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xFF00B0BD), width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xFF00B0BD), width: 2)),
              contentPadding: EdgeInsets.all(
                  dSize.height <= 600
                      ? dSize.height * 0.015
                      : 6),
              isDense: true,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
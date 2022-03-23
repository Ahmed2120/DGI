import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomWidgetBuilder{
 static Container buildArrow(BuildContext context, Icon icon, Function function) {
    return Container(
      padding: EdgeInsets.all(5),
      // alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xFF00B0BD),
          borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        onTap: () => function(),
        child: Container(
          alignment: Alignment.center,
          child: Icon(
            icon.icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
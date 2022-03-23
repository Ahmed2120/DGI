import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomWidgetBuilder{

  static buildTextFormField(Size dSize,String title,String text){
    return Row(
      children: [
        buildText(title, dSize),
        const Spacer(),
        Container(
          width: dSize.width * 0.4,
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Color(0xFF00B0BD), width: 2)),
          ),
          child: TextFormField(
            controller:TextEditingController(text: text) ,
            enabled: false,
            decoration: const InputDecoration(
              constraints: BoxConstraints(maxHeight: 20),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
  static Text buildText(String title, dSize) {
    return Text(
      title,
      style:
      TextStyle(fontSize: dSize.width * 0.04, color: Color(0xFF0F6671), fontWeight: FontWeight.bold),
    );
  }

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
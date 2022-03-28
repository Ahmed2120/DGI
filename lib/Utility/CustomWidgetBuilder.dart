import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomWidgetBuilder{

  static buildTextFormField(Size dSize,String title,String text){
    return Row(
      children: [
        buildText(title, dSize),
        const Spacer(),
        Container(
          width: dSize.width * 0.5,
          child: TextFormField(
            controller: TextEditingController(text: text),
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Color(0xFF00B0BD), width: 2)),
              enabledBorder: OutlineInputBorder( borderSide: BorderSide(color: Color(0xFF00B0BD), width: 2)),
              contentPadding: EdgeInsets.all(8),
              isDense: true,
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
      TextStyle(fontSize: dSize.width * 0.03, color: Color(0xFF0F6671), fontWeight: FontWeight.bold),
    );
  }

 static Container buildArrow(BuildContext context, Size dSize, Icon icon, Function function) {
    return Container(
      padding: EdgeInsets.all(dSize.width * 0.006),
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
            size: dSize.width * 0.07,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  static TableRow buildRow(List<dynamic> cells, {bool isHeader = false}) => TableRow(
    decoration: BoxDecoration(
        color: isHeader
            ? Color(0xFFFFA227)
            : cells[0] % 2 == 0
            ? Colors.grey[200]
            : Colors.grey[300],
        borderRadius: isHeader
            ? BorderRadius.circular(10)
            : BorderRadius.circular(0)),
    children: cells
        .map((cell) => Padding(
      padding: EdgeInsets.all(8.0),
      child: cell.runtimeType == String || cell.runtimeType == int
          ? Text(
        '$cell',
        style: TextStyle(
            fontSize: 11,
            color:
            isHeader ? Colors.white : Color(0xFF0F6671),
            fontWeight: isHeader
                ? FontWeight.bold
                : FontWeight.normal),
      )
          : cell,
    ))
        .toList(),
  );
}
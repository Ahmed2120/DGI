import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomWidgetBuilder{

  static buildTextFormField(Size dSize,String title,String text,bool enabled){
    return Row(
      children: [
        buildText(title, dSize),
        const Spacer(),
        Container(
          width: dSize.width * 0.5,
          child: TextFormField(
            controller: TextEditingController(text: text),
            decoration: InputDecoration(
              enabled: enabled,
              focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Color(0xFF00B0BD), width: 2)),
              enabledBorder: OutlineInputBorder( borderSide: BorderSide(color: Color(0xFF00B0BD), width: 2)),
              disabledBorder: OutlineInputBorder( borderSide: BorderSide(color: Color(0xFF00B0BD), width: 2)) ,
              contentPadding: EdgeInsets.all(dSize.width <= 400 ? dSize.height * 0.009 : 12),
              isDense: true,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
  static void showMessageDialog(BuildContext context,String message,bool dismissible,
      {String title = 'An error Occurred'}) {
    showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (ctx) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }

  static Text buildText(String title, dSize) {
    return Text(
      title,
      style:
      TextStyle(fontSize: dSize.height <= 500 ? 10 : dSize.height * 0.02, color: Color(0xFF0F6671), fontWeight: FontWeight.bold),
    );
  }

 static Container buildArrow(BuildContext context, Size dSize, Icon icon, Function function) {
    return Container(
      padding: EdgeInsets.all(dSize.height <= 500 ? dSize.height * 0.006 : 3.312),
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
            size: dSize.height <= 500 ? dSize.height * 0.04 : 25,
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
            fontSize: 10,
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

  static buildSpanner(){
    return Container(
      color: const Color(0xFFFFA227),
      child: const SpinKitFadingCube(
        color: Colors.white,
        size: 70.0,
      ),
    );
  }
}
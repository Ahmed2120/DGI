import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../language.dart';
import '../screens/home_page.dart';

class CustomWidgetBuilder{

  static buildTextFormField(Size dSize,String title,String ?text,bool enabled){
    return Row(
      children: [
        buildText(title, dSize),
        const Spacer(),
        Container(
          width: dSize.width * 0.5,
          child: TextFormField(
            controller: TextEditingController(text: text),
            style: TextStyle(fontSize: dSize.height <= 500 ? 10 : dSize.height * 0.02),
            decoration: InputDecoration(
              enabled: enabled,
              focusedBorder: const OutlineInputBorder( borderSide: BorderSide(color: Color(0xFF00B0BD), width: 2)),
              enabledBorder: const OutlineInputBorder( borderSide: BorderSide(color: Color(0xFF00B0BD), width: 2)),
              disabledBorder: const OutlineInputBorder( borderSide: BorderSide(color: Color(0xFF00B0BD), width: 2)) ,
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
  static void showMessageDialog(BuildContext context,String message,bool dismissible,
      {String title = 'An error Occurred'}) {
    final lang = Language();
    showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (ctx) => Directionality(
          textDirection: Language.isEn ? TextDirection.ltr : TextDirection.rtl,
          child: AlertDialog(
            title: Text(lang.getTxt('error_occurred'),),
            content: Text(message),
            actions: [
              TextButton(
                child: Text(lang.getTxt('ok'),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ));
  }

  static Text buildText(String title, dSize) {
    return Text(
      title,
      style:
      TextStyle(fontSize: dSize.height <= 500 ? 10 : dSize.height * 0.02, color: const Color(0xFF0F6671), fontWeight: FontWeight.bold),
    );
  }

 static Container buildArrow(BuildContext context, Size dSize, Icon icon, Function? function) {
    return Container(
      padding: EdgeInsets.all(dSize.height <= 500 ? dSize.height * 0.006 : 3.312),
      // alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color(0xFF00B0BD),
          borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        onTap: function != null ? () => function() : null,
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
            ? const Color(0xFFFFA227)
            : cells[0] % 2 == 0
            ? Colors.grey[200]
            : Colors.grey[300],
        borderRadius: isHeader
            ? BorderRadius.circular(10)
            : BorderRadius.circular(0)),
    children: cells
        .map((cell) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: cell.runtimeType == String || cell.runtimeType == int
          ? Text(
        '$cell',
        style: TextStyle(
            fontSize: 10,
            color:
            isHeader ? Colors.white : const Color(0xFF0F6671),
            fontWeight: isHeader
                ? FontWeight.bold
                : FontWeight.normal),
      )
          : cell,
    ))
        .toList(),
  );

  static TableRow lightVerificationTable(List<dynamic> cells, {bool isHeader = false}) => TableRow(
    decoration: BoxDecoration(
        color: isHeader
            ? const Color(0xFFFFA227)
            : Colors.grey[300],
        borderRadius: isHeader
            ? BorderRadius.circular(10)
            : BorderRadius.circular(0)),
    children: cells
        .map((cell) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: cell.runtimeType == String || cell.runtimeType == int
          ? Text(
        '$cell',
        style: TextStyle(
            fontSize: 15,
            color:
            isHeader ? Colors.white : const Color(0xFF0F6671),
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

  static Row nextAndBack( {required String next, required String back, required Function nextFunction, required Function backFunction,} ) {
    return Row(
      children: [
        TextButton(
          onPressed: ()=> backFunction(),
          child: Text(back, style: const TextStyle(fontSize: 13),),
          style: TextButton.styleFrom(
              padding: const EdgeInsets.all(5),
              tapTargetSize:
              MaterialTapTargetSize.shrinkWrap,
              minimumSize: const Size(5, 2)),
        ),
        TextButton(
          onPressed: ()=> nextFunction(),
          child: Text(next, style: const TextStyle(fontSize: 13),),
          style: TextButton.styleFrom(
              tapTargetSize:
              MaterialTapTargetSize.shrinkWrap,
              minimumSize: const Size(5, 2)),
        ),
      ],
    );
  }

  static Align floatingActionButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const HomePage()));
        },
        backgroundColor: Colors.orangeAccent,
        child: const Icon(
          Icons.home,
          color: Colors.white,
        ),
      ),
    );
  }

  static Widget buildAddButton(Function function){
    return InkWell(
      onTap: ()=> function(),
      child: Container(
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Color(0xFF0F6671),
          borderRadius: BorderRadius.circular(10)
        ),
          child: const Icon(Icons.add, color: Colors.white,)),
    );
  }

}
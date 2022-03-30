import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    // print('hhh ${dSize.height * 0.01}');
    // print('hhh ${dSize.width * 0.04}');
    return Container(
        width: double.infinity,
        height: dSize.height * 0.04,
        padding:
        EdgeInsets.symmetric(vertical: dSize.height * 0.002, horizontal: 20),
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
              style: TextStyle(
                  color: Colors.white, fontSize: dSize.width <= 551 ? dSize.width * 0.03 : 15.36),
            ),
            Text(
              'PDA NO : 1023088',
              style: TextStyle(
                  color: Colors.white, fontSize: dSize.width <= 551 ? dSize.width * 0.03 : 15.36),
            ),
          ],
        ));
  }
}

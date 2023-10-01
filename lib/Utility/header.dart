import 'package:flutter/material.dart';

import '../language.dart';

class Header extends StatelessWidget {
  Header({Key? key, required this.title, required this.subTitle}) : super(key: key);
  final String title, subTitle;

  final lang = Language();

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    print('head ${dSize.height * 0.004}');
    print('hffhh ${dSize.width * 0.03}');

    final date = DateTime.now();
    return Directionality(
      textDirection: Language.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Container(
        width: double.infinity,
        height: dSize.height * 0.172,
        padding: EdgeInsets.symmetric(vertical: dSize.height * 0.007),
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
            Text(
              'DGI ASSETS TRACKING',
              style: TextStyle(
                  fontSize: dSize.height * 0.027,
                  color: Colors.white,),
            ),
            SizedBox(
              height: Language.isEn ? dSize.height * 0.03 : dSize.height * 0.017,
            ),
            Row(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(
                        vertical: dSize.height * 0.004, horizontal: 25),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFA227),
                      borderRadius: Language.isEn ? const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12)) : const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12)),
                    ),
                    child: Text.rich(
                      TextSpan(
                          style: TextStyle(
                              fontSize: dSize.height * 0.028,
                              color: Colors.white,),
                          children: <InlineSpan>[
                            TextSpan(
                              text: title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: subTitle,
                            ),
                          ]),
                    )),
              ],
            ),
            SizedBox(
              height: dSize.height * 0.011,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: dSize.height * 0.007),
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FittedBox(
                    child: Text(
                      '${lang.getTxt('date')} : ${date.day}-${date.month}-${date.year}',
                      style: TextStyle(
                          color: Color(0xFF0F6671),
                          fontSize: Language.isEn ? dSize.height * 0.02 : dSize.height * 0.015),
                    ),
                  ),
                  Text(
                    '${lang.getTxt('time')} : ${date.hour},${date.minute}',
                    style: TextStyle(
                        color: Color(0xFF0F6671),
                        fontSize: Language.isEn ? dSize.height * 0.02 : dSize.height * 0.015),
                  ),
                  Text(
                    'NO. : 01223997',
                    style: TextStyle(
                        color: Color(0xFF0F6671),
                        fontSize: dSize.height * 0.02),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

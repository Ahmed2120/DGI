import 'package:flutter/material.dart';

import '../language.dart';

class NextPageHeader extends StatelessWidget {
  const NextPageHeader({
    Key? key,
    required this.dSize,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final Size dSize;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: dSize.height * 0.132,
      padding:
      EdgeInsets.symmetric(vertical: dSize.height * 0.007),
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
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: Language.isEn
                ? dSize.height * 0.03
                : dSize.height * 0.012,
          ),
          Row(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(
                      vertical: dSize.height * 0.004,
                      horizontal: 25),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFA227),
                    borderRadius: Language.isEn
                        ? const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12))
                        : const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                  ),
                  child: Text.rich(
                    TextSpan(
                        style: TextStyle(
                          fontSize: dSize.height * 0.028,
                          color: Colors.white,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                              text: subTitle),
                        ]),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
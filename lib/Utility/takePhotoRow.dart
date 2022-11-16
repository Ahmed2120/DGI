import 'dart:io';

import 'package:flutter/material.dart';

import '../language.dart';
import 'CustomWidgetBuilder.dart';

class TakePhotoRow extends StatelessWidget {
  const TakePhotoRow({
    Key? key,
    required this.title,
    required this.dSize,
    required this.imagePath,
    required this.function,
  }) : super(key: key);

  final String title;
  final Size dSize;
  final String? imagePath;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomWidgetBuilder.buildText(title, dSize),
        const Spacer(),
        SizedBox(
          width: dSize.width * 0.5,
          child: Row(
            children: [
              InkWell(
                onTap: () => function(),
                child: imagePath == null
                    ? Image.asset(
                  'assets/icons/0-16.jpg',
                  height: dSize.height * 0.055,
                  alignment: Alignment.centerLeft,
                )
                    : Image.file(
                  File(imagePath!),
                  height: dSize.height * 0.055,
                  alignment: Alignment.bottomLeft,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
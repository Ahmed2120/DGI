import 'package:flutter/material.dart';

import '../language.dart';
import 'CustomWidgetBuilder.dart';

class QuantityRow extends StatelessWidget {
  const QuantityRow({
    Key? key,
    required this.title,
    required this.dSize,
    required this.quantity,
    required this.increaseMethod,
    required this.decreaseMethod,
  }) : super(key: key);

  final String title;
  final Size dSize;
  final int quantity;
  final Function increaseMethod;
  final Function decreaseMethod;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomWidgetBuilder.buildText(title, dSize),
        Spacer(),
        SizedBox(
          width: dSize.width * 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => decreaseMethod(),
                child: const CircleAvatar(
                  backgroundColor: Color(0xFFFFA227),
                  foregroundColor: Colors.white,
                  radius: 10,
                  child: Icon(
                    Icons.remove,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(
                width: dSize.width * 0.0159,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: dSize.height * 0.001, horizontal: 22.919),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color(0xFF00B0BD),
                        width: dSize.height >= 430 ? 1.5 : 0.5),
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  quantity.toString(),
                  style: const TextStyle(
                      color: Color(0xFF0F6671),
                      fontSize: 15.28,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: dSize.width * 0.0159,
              ),
              InkWell(
                onTap: () => increaseMethod(),
                child: const CircleAvatar(
                  backgroundColor: Color(0xFF00B0BD),
                  foregroundColor: Colors.white,
                  radius: 10,
                  child: Icon(Icons.add, size: 20),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
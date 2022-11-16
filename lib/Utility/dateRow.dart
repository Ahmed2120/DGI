import 'package:flutter/material.dart';

import 'CustomWidgetBuilder.dart';

class DateRow extends StatelessWidget {
  const DateRow({
    Key? key,
    required this.title,
    required this.dSize,
    required this.date,
    required this.function,
  }) : super(key: key);

  final String title;
  final Size dSize;
  final DateTime date;
  final Function function;

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
              IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () => function(),
                  icon: const Icon(
                    Icons.date_range,
                    color: Color(0xFF00B0BD),
                  )),
              CustomWidgetBuilder.buildText(
                  '${date.year} / ${date.month} / ${date.day}',
                  dSize),
            ],
          ),
        )
      ],
    );
  }
}
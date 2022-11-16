import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'CustomWidgetBuilder.dart';

class TakeFileRow extends StatelessWidget {
  const TakeFileRow({
    Key? key,
    required this.title,
    required this.dSize,
    required this.selectedFile,
    required this.function,
  }) : super(key: key);

  final String title;
  final Size dSize;
  final PlatformFile? selectedFile;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomWidgetBuilder.buildText(title, dSize),
        Spacer(),
        Container(
          width: dSize.width * 0.5,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Color(0xFF00B0BD)),
          ),
          child: InkWell(
            onTap: () => function(),
            child: Row(
              children: [
                Container(
                  child: Icon(Icons.cloud_upload_outlined),
                  width: dSize.width * 0.15,
                  color: Colors.blue,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      selectedFile == null ? 'file_name' : selectedFile!.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../language.dart';
import 'CustomWidgetBuilder.dart';

class QuantityRow extends StatefulWidget {
  QuantityRow({
    Key? key,
    required this.title,
    required this.dSize,
    required this.quantity,
    required this.increaseMethod,
    required this.decreaseMethod,
    required TextEditingController controller
  }) : _controller = controller;

  final TextEditingController _controller;

  final String title;
  final Size dSize;
  final int quantity;
  final Function increaseMethod;
  final Function decreaseMethod;

  @override
  State<QuantityRow> createState() => _QuantityRowState();
}

class _QuantityRowState extends State<QuantityRow> {
  final FocusNode _quantityFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomWidgetBuilder.buildText(widget.title, widget.dSize),
        Spacer(),
        SizedBox(
          width: widget.dSize.width * 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => widget.decreaseMethod(),
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
                width: widget.dSize.width * 0.0159,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                     horizontal: 22.919),
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color(0xFF00B0BD),
                        width: widget.dSize.height >= 430 ? 1.5 : 0.5),
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: widget._controller,
                  focusNode: _quantityFocusNode,
                  key: const ValueKey('10'),
                  style: TextStyle(
    color: Color(0xFF0F6671),
    fontSize: 15.28,
    fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  enabled: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[0-9.]'),
                    ),
                  ],
                  onChanged: (valueee){
                    setState(() {

                    });
                  },
                  onEditingComplete: (){
                    if(widget._controller.text.isEmpty){
                        widget._controller.text = '1';}
                    FocusScope.of(context).unfocus();
                  },

                ),
              ),
              SizedBox(
                width: widget.dSize.width * 0.0159,
              ),
              InkWell(
                onTap: () => widget.increaseMethod(),
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
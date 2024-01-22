import 'package:flutter/material.dart';
import 'package:flutter_application_1/utility/my_constant.dart';

class TextFieldContainer extends StatefulWidget {
  const TextFieldContainer({
    Key? key,
    required this.hightContainer,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  final double hightContainer;
  final TextEditingController controller;
  final String hintText;

  @override
  _TextFieldContainerState createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      width: double.infinity,
      height: widget.hightContainer,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: backgroundActiveButton,
        ),
      ),
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        controller: widget.controller,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          hintStyle: kfontH4InterBlackColorHalfOpacity(),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

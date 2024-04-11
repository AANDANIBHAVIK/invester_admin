import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.text, {
    Key? key,
    this.color = textColor,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 16.0,
    this.textAlign = TextAlign.center,
    this.decoration = TextDecoration.none,
    this.maxLine,
    this.textOverflow,
  }) : super(key: key);
  final Color color;
  final String text;
  final FontWeight fontWeight;
  final double fontSize;

  final TextOverflow? textOverflow;
  final TextAlign textAlign;
  final int? maxLine;
  final TextDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      // overflow: TextOverflow.ellipsis,
      // softWrap: true,
      maxLines: maxLine,
      style: TextStyle(
        decoration: decoration,
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}

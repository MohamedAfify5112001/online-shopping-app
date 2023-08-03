import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final TextAlign? textAlign;

  const ReusableText(
      {Key? key,
      required this.text,
      required this.textStyle,
      this.textOverflow,
      this.maxLines,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    Key? key,
    required this.text,
    required this.textColor,
    this.fontSize = 14.0,
    this.maxLine = 50,
    this.fontWeight = FontWeight.w500,
    this.textAlign = TextAlign.start,
    this.textDecoration = TextDecoration.none
  }) : super(key: key);
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final int maxLine;
  final TextAlign textAlign;

  final TextDecoration textDecoration;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines:maxLine ,
      textScaleFactor: 1.0,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.quicksand(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        decoration: textDecoration
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../helper/constants.dart';
import 'custom_text_widget.dart';
class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget(
      {Key? key,
      required this.text,
      required this.onClick,
      this.width = double.infinity,
      this.height = 50.0,
      this.fontSize = 16.0,
      this.textColor = Colors.white,
      this.btnColor = kAppColor,
      this.radius = 8.0})
      : super(key: key);
  final String text;
  final double width;
  final double height;
  final double fontSize;
  final Color textColor;
  final Color btnColor;
  final double radius;
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        elevation: 2,
          backgroundColor: btnColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          minimumSize: Size(width, height)),
      child: CustomTextWidget(
        text: text,
        textColor: textColor,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

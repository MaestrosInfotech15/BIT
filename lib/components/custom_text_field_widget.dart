import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final IconData? prefixIcon;
  final bool isEnable;
  final int maxLength;
  final FocusNode? focus;

  const CustomTextFieldWidget(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.inputType,
      required this.inputAction,
      this.focus,
      this.prefixIcon,
      this.maxLength = 100,
      this.isEnable = true})
      : super(key: key);

  //TextStyle(
  //             color: kHintColor,
  //             fontFamily: 'Nunito',
  //             fontWeight: FontWeight.w600),

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
              color: Colors.white,
              blurRadius: 5.0,
              offset: -Offset(10.0, 10.0),
              inset: true),
          BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 5.0,
              offset: Offset(10.0, 10),
              inset: true),
        ],
      ),
      child: TextFormField(
        focusNode: focus,
        style: GoogleFonts.quicksand(
            color: Theme.of(context).hintColor,
            fontWeight: FontWeight.w600,
            fontSize: 14),
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength),
        ],
        cursorColor: Theme.of(context).primaryColor,
        keyboardType: inputType,
        textInputAction: inputAction,
        controller: controller,
        decoration: InputDecoration(
          enabled: isEnable,
          prefixIcon: Icon(
            prefixIcon,
            color: Theme.of(context).hintColor,
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.quicksand(
              color: Theme.of(context).hintColor,
              fontWeight: FontWeight.w600,
              fontSize: 14),
          // filled: true,
          // fillColor: Colors.grey.shade200,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.inputType,
      required this.inputAction,
      required this.prefixIcon,
      this.isEnable = true,
      this.isPassword = false})
      : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;

  final IconData prefixIcon;
  final bool isEnable;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
              color:Colors.grey.shade200,
              blurRadius: 5.0,
              offset: -Offset(10.0, 10.0),
              inset: true),
          BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 5.0,
              offset: Offset(10.0, 10),
              inset: true),
        ],
      ),
      child: TextFormField(
        style: GoogleFonts.quicksand(
          color: Theme.of(context).hintColor,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 5,
        obscureText: isPassword,
        cursorColor: Theme.of(context).primaryColor,
        keyboardType: inputType,
        textInputAction: inputAction,
        controller: controller,
        decoration: InputDecoration(
          enabled: isEnable,
          hintText: hintText,
          hintStyle: GoogleFonts.nunito(
            color: Theme.of(context).hintColor,
            fontWeight: FontWeight.w500,
          ),
          // filled: true,
          // fillColor: Colors.grey.shade100,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

class DemoTextField extends StatefulWidget {
  const DemoTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.inputType,
      required this.inputAction,
      required this.prefixIcon,
      this.isEnable = true});

  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final IconData prefixIcon;
  final bool isEnable;

  @override
  State<DemoTextField> createState() => _DemoTextFieldState();
}

class _DemoTextFieldState extends State<DemoTextField> {
  bool isMale = true;
  bool isFemale = false;
  bool isPressed = false;
  final backgroundColor = Colors.grey[200];

  @override
  Widget build(BuildContext context) {
    Offset distanceMale = isMale ? const Offset(10, 10) : const Offset(15, 15);
    double blurMale = isMale ? 5 : 30;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            blurRadius: blurMale,
            offset: -distanceMale,
            color: Colors.white,
            inset: isMale,
          ),
          BoxShadow(
            blurRadius: blurMale,
            offset: distanceMale,
            color: const Color(0xFFA7A9AF),
            inset: isMale,
          ),
        ],
      ),
      child: TextFormField(
        style: GoogleFonts.quicksand(
          color: Theme.of(context).hintColor,
          fontWeight: FontWeight.w600,
        ),
        cursorColor: Theme.of(context).primaryColor,
        keyboardType: widget.inputType,
        textInputAction: widget.inputAction,
        controller: widget.controller,
        decoration: InputDecoration(
          enabled: widget.isEnable,
          prefixIcon: Icon(
            widget.prefixIcon,
            color: Theme.of(context).hintColor,
          ),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.quicksand(
            color: Theme.of(context).hintColor,
            fontWeight: FontWeight.w600,
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

class CustomSocialTextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final String image;
  final bool isEnable;
  final int maxLength;

  const CustomSocialTextFieldWidget(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.inputType,
      required this.inputAction,
      required this.image,
      this.maxLength = 100,
      this.isEnable = true})
      : super(key: key);

  //TextStyle(
  //             color: kHintColor,
  //             fontFamily: 'Nunito',
  //             fontWeight: FontWeight.w600),

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
              color: Colors.white,
              blurRadius: 5.0,
              offset: -Offset(10.0, 10.0),
              inset: true),
          BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 5.0,
              offset: Offset(10.0, 10),
              inset: true),
        ],
      ),
      child: TextFormField(
        style: GoogleFonts.quicksand(
            color: Theme.of(context).hintColor,
            fontWeight: FontWeight.w600,
            fontSize: 14),
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength),
        ],
        cursorColor: Theme.of(context).primaryColor,
        keyboardType: inputType,
        textInputAction: inputAction,
        controller: controller,
        decoration: InputDecoration(
          enabled: isEnable,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              image,
              height: 15,
              width: 15,
            ),
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.quicksand(
              color: Theme.of(context).hintColor,
              fontWeight: FontWeight.w600,
              fontSize: 14),
          // filled: true,
          // fillColor: Colors.grey.shade200,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

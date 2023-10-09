import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPForm extends StatefulWidget {
  final TextEditingController firstController;
  final TextEditingController secondController;
  final TextEditingController thirdController;
  final TextEditingController fourthController;
  final TextEditingController fivethController;
  final TextEditingController sixthController;

  const OTPForm({
    Key? key,
    required this.firstController,
    required this.secondController,
    required this.thirdController,
    required this.fourthController,
    required this.fivethController,
    required this.sixthController,
  }) : super(key: key);

  @override
  State<OTPForm> createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  FocusNode? pin2FocusNode = FocusNode();
  FocusNode? pin3FocusNode = FocusNode();
  FocusNode? pin4FocusNode = FocusNode();
  FocusNode? pin5FocusNode = FocusNode();
  FocusNode? pin6FocusNode = FocusNode();

  String deviceId = '';

  @override
  void initState() {
    super.initState();
    // pin2FocusNode = FocusNode();
    // pin3FocusNode = FocusNode();
    // pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    } else {
      FocusScope.of(context).previousFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 45,
            height: 45,
            child: InnerNeumorphismWidget(
              child: TextFormField(
                controller: widget.firstController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                ],
                //const TextStyle(fontSize: 18, fontFamily: 'Overpass')
                autofocus: true,
                obscureText: false,
                style: GoogleFonts.nunito(fontSize: 18),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onChanged: (value) {
                  nextField(value, pin2FocusNode);
                },
              ),
            ),
          ),
          const SizedBox(width: 5.0),
          InnerNeumorphismWidget(
            child: SizedBox(
              width: 45,
              height: 45,
              child: TextFormField(
                controller: widget.secondController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                ],
                focusNode: pin2FocusNode,
                autofocus: true,
                obscureText: false,
                style: GoogleFonts.nunito(fontSize: 18),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onChanged: (value) {
                  nextField(value, pin3FocusNode);
                },
                onEditingComplete: () {
                  FocusScope.of(context).previousFocus();
                },
              ),
            ),
          ),
          const SizedBox(width: 5.0),
          InnerNeumorphismWidget(
            child: SizedBox(
              width: 45,
              height: 45,
              child: TextFormField(
                controller: widget.thirdController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                ],
                focusNode: pin3FocusNode,
                autofocus: true,
                obscureText: false,
                style: GoogleFonts.nunito(fontSize: 18),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onChanged: (value) {
                  nextField(value, pin4FocusNode);
                },
                onEditingComplete: () {
                  FocusScope.of(context).previousFocus();
                },
              ),
            ),
          ),
          const SizedBox(
            width: 5.0,
          ),
          InnerNeumorphismWidget(
            child: SizedBox(
              width: 45,
              height: 45,
              child: TextFormField(
                controller: widget.fourthController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                ],
                focusNode: pin4FocusNode,
                autofocus: true,
                obscureText: false,
                style: GoogleFonts.nunito(fontSize: 18),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onEditingComplete: () {
                  FocusScope.of(context).previousFocus();
                },
                onChanged: (value) {
                  nextField(value, pin5FocusNode);
                  // if (value.length == 1) {
                  //   pin4FocusNode!.unfocus();
                  //   // Navigator.pushNamed(context, SignUpScreen.id);
                  // }
                },
              ),
            ),
          ),
          const SizedBox(
            width: 5.0,
          ),
          InnerNeumorphismWidget(
            child: SizedBox(
              width: 45,
              height: 45,
              child: TextFormField(
                controller: widget.fivethController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                ],
                focusNode: pin5FocusNode,
                autofocus: true,
                obscureText: false,
                style: GoogleFonts.nunito(fontSize: 18),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onEditingComplete: () {
                  FocusScope.of(context).previousFocus();
                },
                onChanged: (value) {
                  nextField(value, pin6FocusNode);
                  // if (value.length == 1) {
                  //   pin5FocusNode!.unfocus();
                  //   // Navigator.pushNamed(context, SignUpScreen.id);
                  // }
                },
              ),
            ),
          ),
          const SizedBox(
            width: 5.0,
          ),
          InnerNeumorphismWidget(
            child: SizedBox(
              width: 45,
              height: 45,
              child: TextFormField(
                controller: widget.sixthController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                ],
                focusNode: pin6FocusNode,
                autofocus: true,
                obscureText: false,
                style: GoogleFonts.nunito(fontSize: 18),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onChanged: (value) {
                  nextField(value, pin6FocusNode);
                  // if (value.length == 1) {
                  //   nextField(value, pin6FocusNode);
                  // }
                },
                onEditingComplete: () {
                  FocusScope.of(context).previousFocus();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//TextField(
//             autofocus: true,
//             keyboardType: TextInputType.number,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 20,fontFamily: 'Overpass'),
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                   borderSide: const BorderSide(
//                     color: Colors.white,
//                   ),
//                   borderRadius: BorderRadius.circular(8.0)),
//               focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(
//                     color: Colors.white,
//                   ),
//                   borderRadius: BorderRadius.circular(8.0)),
//               hintText: '0',
//               hintStyle: const TextStyle(
//                 fontFamily: 'Overpass',
//                 fontSize: 20,
//                 color: Colors.grey,
//               ),
//               enabled: true,
//             ),
//           ),

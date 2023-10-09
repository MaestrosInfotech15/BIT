import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_field_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/components/new_user_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/helper/size_config.dart';
import 'package:book_indian_talents_app/screens/otp_screen.dart';
import 'package:book_indian_talents_app/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;

import '../network/api_helper.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool islogin = false;

  TextEditingController mobilecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NeumorphismWidget(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: Column(
                    children: [
                      SizedBox(height: 25.0),
                      Image.asset(
                        '$kLogoPath/transparent_logo.png',
                        height: SizeConfig.height() / 4.8,
                        width: SizeConfig.width() / 2.0,
                      ),
                      const SizedBox(height: 25.0),
                      CustomTextWidget(
                          text: 'Login',
                          fontWeight: FontWeight.w700,
                          fontSize: 22.0,
                          textColor: Theme.of(context).primaryColorLight),
                      const SizedBox(height: 10.0),
                      CustomTextWidget(
                          text: 'Please enter your mobile and Login.',
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          textColor: Theme.of(context).hintColor),
                      const SizedBox(height: 25.0),
                      CustomTextFieldWidget(
                          hintText: 'Enter Mobile Number',
                          controller: mobilecontroller,
                          inputType: TextInputType.number,
                          inputAction: TextInputAction.done,
                          maxLength: 10,
                          prefixIcon: Icons.phone_android_rounded),
                      const SizedBox(height: 10.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomTextWidget(
                          text: 'We will sent OTP for verification',
                          textColor: Theme.of(context).primaryColorLight,
                          fontSize: 12.0,
                        ),
                      ),
                      const SizedBox(height: 45.0),
                      islogin
                          ? const CustomLoaderWidget()
                          : CustomButtonWidget(
                              text: 'Login',
                              onClick: () {
                                check();
                              },
                            ),
                      const SizedBox(height: 35.0),
                      NewUserWidget(
                          onClick: () {
                            Navigator.pushNamed(context, RegisterScreen.id);
                          },
                          firstTitle: "Don't have an Account? ",
                          secondTitle: 'Sign up'),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  void check() {
    String number = mobilecontroller.text.trim();
    if (number.isEmpty) {
      Helper.showSnackBar(context, 'Enter Mobile number', Colors.red);
      return;
    }
    setState(() {
      islogin = true;
    });
    Map<String, dynamic> body = {"contact": number};
    ApiHelper.registrationCheck(number).then((value) {
      if (value.apiStatus == 'false') {
        //sendotp();
        Map<String, dynamic> body = {
          'verification_id': '1235456',
          "contact_number": number,
        };

        Navigator.pushNamed(context, OTPScreen.id, arguments: body);
      } else {
        setState(() {
          islogin = false;
        });
        Helper.showSnackBar(context,
            'Phone number is not registered. Please SignUp.', Colors.red);
      }
    });
  }

  void sendotp() async {
    String mobile = mobilecontroller.text;

    if (mobile.isEmpty) {
      Helper.showToastMessage('Enter Mobile Number', Colors.red);
      return;
    }

    //  Helper.showLoaderDialog(context, message: 'please Wait..');
    String phone = ' +91$mobile';

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        codeSent: (verificationId, resendToken) {
          //  Navigator.pop(context);
          setState(() {
            islogin = false;
          });

          Map<String, dynamic> body = {
            'verification_id': verificationId,
            "contact_number": mobile,
          };

          Navigator.pushNamed(context, OTPScreen.id, arguments: body);
        },
        verificationCompleted: (credential) {
          // Navigator.pop(context);
        },
        verificationFailed: (ex) {
          //  Navigator.pop(context);
          setState(() {
            islogin = false;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) {
          //  Navigator.pop(context);
          setState(() {
            islogin = false;
          });
        },
        timeout: const Duration(seconds: 30));
  }
}

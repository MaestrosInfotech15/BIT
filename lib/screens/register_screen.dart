import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_radio_button.dart';
import 'package:book_indian_talents_app/components/custom_text_field_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/components/new_user_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/helper/size_config.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/provider/api_controller.dart';
import 'package:book_indian_talents_app/screens/login_screen.dart';
import 'package:book_indian_talents_app/widgets/register_steps_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isSignup = false;

  TextEditingController controllernumber = TextEditingController();

  bool isTerm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NeumorphismWidget(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      '$kLogoPath/transparent_logo.png',
                      height: SizeConfig.height() / 4.8,
                      width: SizeConfig.width() / 2.0,
                    ),
                    const SizedBox(height: 25.0),
                    CustomTextWidget(
                        text: 'Sign Up',
                        fontWeight: FontWeight.w700,
                        fontSize: 22.0,
                        textColor: Theme.of(context).primaryColorLight),
                    const SizedBox(height: 10.0),
                    CustomTextWidget(
                        text: 'Create New Account',
                        fontWeight: FontWeight.w500,
                        textColor: Theme.of(context).primaryColor),
                    const SizedBox(height: 25.0),
                    CustomTextFieldWidget(
                        hintText: 'Enter Mobile Number',
                        controller: controllernumber,
                        inputType: TextInputType.number,
                        inputAction: TextInputAction.done,
                        maxLength: 10,
                        prefixIcon: Icons.phone_android_rounded),
                    const SizedBox(height: 15.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomRadioButton(
                          label: 'Accept Terms & Conditions',
                          value: isTerm,
                          onChanged: (isCheck) {
                            setState(() {
                              isTerm = !isTerm;
                            });
                          }),
                    ),
                    const SizedBox(height: 15.0),
                    isSignup
                        ? const CustomLoaderWidget()
                        : CustomButtonWidget(
                            text: 'Sign Up',
                            onClick: signup,
                          ),
                    const SizedBox(height: 15.0),
                    CustomTextWidget(
                      text: 'Or',
                      textColor: Theme.of(context).hintColor,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: NeumorphismWidget(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              '$kLogoPath/facebook.png',
                              height: 25.0,
                              width: 25.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15.0),
                        InkWell(
                          onTap: googleLogin,
                          child: NeumorphismWidget(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              '$kLogoPath/google.png',
                              height: 25.0,
                              width: 25.0,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 25.0),
                    NewUserWidget(
                        onClick: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                          // Navigator.pop(context);
                        },
                        firstTitle: "If you have an Account? ",
                        secondTitle: 'Login Now'),
                    const SizedBox(height: 25.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signup() {
    String number = controllernumber.text.trim();
    if (number.isEmpty) {
      Helper.showSnackBar(context, 'Enter Mobile number', Colors.red);
      return;
    }

    if (isTerm == false) {
      Helper.showSnackBar(context, 'Accept terms & condition', Colors.red);
      return;
    }
    setState(() {
      isSignup = true;
    });
    Map<String, dynamic> body = {"contact": number};
    ApiHelper.registrationCheck(number).then((value) {
      setState(() {
        isSignup = false;
      });
      if (value.apiStatus == 'true') {
        Map<String, dynamic> signupBody = {
          'contact_number': number,
          'name': '',
          'email': '',
          'sign_with': 'phone'
        };
        gotoRegister(signupBody);
      } else {
        Helper.showSnackBar(
            context, value.result ?? 'Something Want wrong', Colors.red);
      }
    });
  }

  void googleLogin() {
    Helper.showLoaderDialog(context, message: 'Please wait...');

    ApiHelper.googleSignIn().then((value) {
      Navigator.pop(context);
      if (value.status == true) {
        Map<String, dynamic> signupBody = {
          'contact_number': '',
          'name': value.username!,
          'email': value.userId!,
          'sign_with': 'email'
        };
        gotoRegister(signupBody);
      } else {
        Helper.showSnackBar(context, value.message!, Colors.red);
      }
    });
  }

  void gotoRegister(Map<String, dynamic> body) {
    final apiData = Provider.of<ApiController>(context, listen: false);
    apiData.setSignUpBody(body);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const ChooseModeDialogWidget(),
    );
  }
}

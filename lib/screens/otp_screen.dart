import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_dialog_widget.dart';
import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/components/otp_form.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/helper/size_config.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/provider/app_controller.dart';
import 'package:book_indian_talents_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import '../helper/helper.dart';

class OTPScreen extends StatefulWidget {
  static const String id = 'otp_screen';
  final Map<String, dynamic> body;

  const OTPScreen({super.key, required this.body});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int seconds = 30;
  bool isVerify = false;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  TextEditingController otpcontroller = TextEditingController();

  bool islogin = false;
  String verificationId = "";
  String phoneNumber = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verificationId = widget.body['verification_id'];
    phoneNumber = widget.body['contact_number'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NeumorphismWidget(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Column(
                  children: [
                    Image.asset(
                      '$kLogoPath/transparent_logo.png',
                      height: SizeConfig.height() / 4.8,
                      width: SizeConfig.width() / 2.0,
                    ),
                    const SizedBox(height: 25.0),
                    CustomTextWidget(
                        text: 'Enter the verification code',
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                        textColor: Theme.of(context).primaryColorLight),
                    const SizedBox(height: 10.0),
                    CustomTextWidget(
                        text:
                            'Enter the 6 digit number that we send to (+91)${widget.body['contact_number']}',
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                        textAlign: TextAlign.center,
                        textColor: Theme.of(context).hintColor),
                    const SizedBox(height: 25.0),
                    /* OTPForm(
                        firstController: controller1,
                        secondController: controller2,
                        thirdController: controller3,
                        fourthController: controller4,
                        fivethController: controller5,
                        sixthController: controller6),*/
                    PinCodeTextField(
                      autofocus: true,
                      controller: otpcontroller,
                      hideCharacter: false,
                      highlight: true,
                      maxLength: 6,
                      onTextChanged: (text) {
                        setState(() {});
                      },
                      onDone: (text) {},
                      pinBoxWidth: 40,
                      pinBoxHeight: 45,
                      hasUnderline: false,
                      wrapAlignment: WrapAlignment.spaceAround,
                      pinTextStyle: TextStyle(fontSize: 20.0),
                      pinTextAnimatedSwitcherTransition:
                          ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
                      pinTextAnimatedSwitcherDuration:
                          Duration(milliseconds: 300),
//                    highlightAnimation: true,
                      pinBoxDecoration: pinBoxDecorationBuilder,
                      highlightAnimationBeginColor: Colors.white,
                      highlightAnimationEndColor: Colors.white12,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 45.0),
                    islogin
                        ? const CustomLoaderWidget()
                        : CustomButtonWidget(
                            text: 'Verify',
                            onClick: () {
                             // verifyOTP();\
                              login();
                            },
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TweenAnimationBuilder(
                          tween: Tween(begin: seconds, end: 0.0),
                          duration: Duration(seconds: seconds),
                          builder: (_, dynamic value, child) {
                            if (value.toInt() == 0) {
                              return TextButton(
                                  onPressed: () {
                                   //
                                    // resendOTP();
                                  },
                                  child: const Text(
                                    "Resend OTP",
                                    style: TextStyle(
                                        color: kAppColor,
                                        fontFamily: 'Overpass'),
                                  ));
                            }

                            return Text(
                              "Resend OTP in 00:${value.toInt()}",
                              style: const TextStyle(
                                  color: kAppColor, fontFamily: 'Overpass'),
                            );
                          }),
                    ),
                    const SizedBox(height: 35.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration pinBoxDecorationBuilder(Color borderColor, Color pinBoxColor,
      {double borderWidth = 2.0, double radius = 10.0}) {
    return BoxDecoration(
      color: Colors.grey[200],
      border: Border.all(color: Colors.black),
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      /* boxShadow: [
        BoxShadow(
          color: Colors.grey.shade400,
          blurRadius: 10.0,
          offset: const Offset(4.0, 4.0),
        ),
        const BoxShadow(
          color: Colors.white,
          blurRadius: 10.0,
          offset: Offset(-4.0, -4.0),
        ),
      ],*/
    );
  }

  void verifyOTP() async {

    if (otpcontroller.text.length != 6) {
      Helper.showSnackBar(context, 'Enter Otp', Colors.red);
      return;
    }

    // Helper.showLoaderDialog(context, message: 'Verify Otp....');
    setState(() {
      islogin = true;
    });
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpcontroller.text);

    try {
      // UserCredential userCredential =
      // await FirebaseAuth.instance.signInWithCredential(credential);
      FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        if (value.user != null) {
          SessionManager.setChatId(value.user!.uid);
          login();
        } else {
          setState(() {
            islogin = false;
          });
        }
      }).onError((error, stackTrace) {
        setState(() {
          islogin = false;
        });
        Helper.showSnackBar(
            context, ' The verification code is invalid', Colors.red);
      });
    } on FirebaseAuthException catch (ex) {
      //  Navigator.pop(context);
      setState(() {
        islogin = false;
      });
      Helper.showSnackBar(context, ex.message!, Colors.red);
    }
  }

  void login() {
    String phone = widget.body['contact_number'];

    print(phone);

    Map<String, String> body = {
      "contact": phone,
      'token': SessionManager.getToken()
    };
    print(body);

    ApiHelper.login(body).then((value) {
      setState(() {
        islogin = false;
      });

      if (value.apiStatus!.toLowerCase() == 'true') {
        SessionManager.setUserLoggedIn(true);
        SessionManager.setUserID(value.id??''.toString());
        SessionManager.setUserName(value.name??'');
        SessionManager.setUserEmail(value.email??'');
        SessionManager.setLoginWith(value.userType??'');
        SessionManager.setMobile(value.contact??'');
        SessionManager.setProfileUpdate(value.profileStatus??'');

        if(value.img!=null){
          SessionManager.setProfileImage(value.path!+value.img!);
        }


        final data = Provider.of<AppController>(context, listen: false);


        if (value.userType!.toLowerCase() == 'artist') {
          //  SessionManager.setArtistMode(true);
          data.setArtistMode(true);
        } else {
          // SessionManager.setArtistMode(false);
          data.setArtistMode(false);
        }

        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.id, (route) => false);
      } else {
        Helper.showSnackBar(
            context, value.result ?? 'Something went wrong', Colors.red);
      }
    });
  }
  void resendOTP() async {
    otpcontroller.clear();

    String mobile = ' +91$phoneNumber';

    Helper.showLoaderDialog(context, message: 'Resend....');

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: mobile,
        codeSent: (verification, resendToken) {
          Navigator.pop(context);
          setState(() {
            verificationId = verification;
            print(verificationId);
            seconds = 30;
          });
        },
        verificationCompleted: (credential) {
          //Navigator.pop(context);
        },
        verificationFailed: (ex) {
          //Navigator.pop(context);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          // Navigator.pop(context);
        },
        timeout: const Duration(seconds: 30));
  }
}

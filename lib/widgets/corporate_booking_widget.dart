import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_dialog_widget.dart';
import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_radio_button.dart';
import 'package:book_indian_talents_app/components/custom_text_field_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/components/otp_form.dart';
import 'package:book_indian_talents_app/firebase/firebase_helper.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/helper/size_config.dart';
import 'package:book_indian_talents_app/model/user_chat.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/provider/api_controller.dart';
import 'package:book_indian_talents_app/screens/home_screen.dart';
import 'package:book_indian_talents_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

import '../helper/session_manager.dart';
import '../provider/app_controller.dart';

class HireTalentDialogWidget extends StatefulWidget {
  const HireTalentDialogWidget({super.key});

  @override
  State<HireTalentDialogWidget> createState() => _HireTalentDialogWidgetState();
}

class _HireTalentDialogWidgetState extends State<HireTalentDialogWidget> {
  bool isRegister = false;

  @override
  Widget build(BuildContext context) {
    final apiData = Provider.of<ApiController>(context);

    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey.shade200),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15.0),
            Image.asset(
              '$kLogoPath/transparent_logo.png',
              height: 75.0,
            ),
            const SizedBox(height: 15.0),
            CustomTextWidget(
              text: 'Hire a Talent',
              textColor: Theme.of(context).primaryColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 15.0),
            Row(
              children: [
                Expanded(
                    child: NeumorphismWidget(
                        padding: EdgeInsets.zero,
                        child: CustomRadioButton(
                            radius: 50,
                            label: 'Corporate Booking',
                            value: apiData.bookingType == 'Corporate',
                            onChanged: (isCheck) {
                              apiData.setPersonalBookingType('Corporate');
                            }))),
                const SizedBox(width: 15.0),
                Expanded(
                    child: NeumorphismWidget(
                        padding: EdgeInsets.zero,
                        child: CustomRadioButton(
                            radius: 50,
                            label: 'Personal Booking',
                            value: apiData.bookingType == 'Personal',
                            onChanged: (isCheck) {
                              apiData.setPersonalBookingType('Personal');
                            })))
              ],
            ),
            const SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: isRegister
                  ? const CustomLoaderWidget()
                  : CustomButtonWidget(
                      text: 'OK',
                      onClick: () {
                        if (apiData.bookingType.isEmpty) {
                          Helper.showToastMessage(
                              'Select booking type', Colors.red);
                          return;
                        }

                        apiData.signUpBody['talent'] = apiData.bookingType;

                        apiData.setSignUpBody(apiData.signUpBody);

                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) =>
                                const CorporateBookingDialogWidget());

                        /*if (apiData.bookingType == 'Corporate') {
                          Navigator.pop(context);

                          showDialog(
                              context: context,
                              builder: (context) =>
                                  const CorporateBookingDialogWidget());
                        } else {
                          sendOtp();
                        }*/
                      },
                    ),
            ),
            const SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }

  void sendOtp() async {
    final apiData = Provider.of<ApiController>(context, listen: false);

    Helper.showLoaderDialog(context, message: 'please Wait..');
    String mobile = ' +91${apiData.signUpBody['contact_number']}';

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: mobile,
        codeSent: (verificationId, resendToken) {
          Map<String, dynamic> body = {
            "verification_id": verificationId,
            "talent": "Personal",
            "company_name": '',
            "person_name": apiData.signUpBody['name'],
            "contact_number": apiData.signUpBody['contact_number'],
            "website": "",
            "email": apiData.signUpBody['email']
          };

          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) => CorporateOTPWidget(body: body));
        },
        verificationCompleted: (credential) {
          // Navigator.pop(context);
        },
        verificationFailed: (ex) {
          //  Navigator.pop(context);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          //  Navigator.pop(context);
        },
        timeout: const Duration(seconds: 30));
  }

  void register() {
    final apiData = Provider.of<ApiController>(context, listen: false);

    setState(() {
      isRegister = true;
    });

    apiData.signUpBody.remove('mode2');
    apiData.signUpBody.remove('mode1');
    apiData.signUpBody.remove('sign_with');
    apiData.signUpBody['mode'] = '1';

    ApiHelper.register(apiData.signUpBody).then((value) {
      setState(() {
        isRegister = false;
      });
      if (value.apiStatus!.toLowerCase() == 'true') {
        Navigator.pop(context);
        apiData.signUpBody['sign_with'] = 'phone';
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const CorporateOTPWidget(
                  body: {},
                ));
      } else {
        Helper.showToastMessage('Something went wrong', Colors.red);
      }
    });
  }
}

//todo:----------------------------------------------------------------

class CorporateBookingDialogWidget extends StatefulWidget {
  const CorporateBookingDialogWidget({super.key});

  @override
  State<CorporateBookingDialogWidget> createState() =>
      _CorporateBookingDialogWidgetState();
}

class _CorporateBookingDialogWidgetState
    extends State<CorporateBookingDialogWidget> {
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _webController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  bool isRegister = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('object');
    final apiData = Provider.of<ApiController>(context, listen: false);
    _nameController.text = apiData.signUpBody['name'];
    _emailController.text = apiData.signUpBody['email'];
    _phoneController.text = apiData.signUpBody['contact_number'];
  }

  @override
  Widget build(BuildContext context) {
    final apiData = Provider.of<ApiController>(context);

    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey.shade200),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: SizeConfig.width(),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                decoration: BoxDecoration(color: kAppColor.withOpacity(0.2)),
                child: CustomTextWidget(
                  text: '${apiData.bookingType} Booking',
                  textAlign: TextAlign.center,
                  textColor: Theme.of(context).primaryColorLight,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: apiData.bookingType == 'Corporate',
                      child: CustomTextFieldWidget(
                        hintText: 'Enter company name',
                        controller: _companyController,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        prefixIcon: Icons.location_city_rounded,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    CustomTextFieldWidget(
                      hintText: 'Enter contact person name',
                      controller: _nameController,
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      prefixIcon: Icons.person_2_outlined,
                    ),
                    const SizedBox(height: 15.0),
                    CustomTextFieldWidget(
                      hintText: 'Enter contact number',
                      isEnable: false,
                      controller: _phoneController,
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.next,
                      prefixIcon: Icons.phone_android_rounded,
                    ),
                    const SizedBox(height: 15.0),
                    Visibility(
                      visible: apiData.bookingType == 'Corporate',
                      child: CustomTextFieldWidget(
                        hintText: 'Enter website link',
                        controller: _webController,
                        inputType: TextInputType.url,
                        inputAction: TextInputAction.next,
                        prefixIcon: Icons.link,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    CustomTextFieldWidget(
                      hintText: 'Enter Email',
                      controller: _emailController,
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      prefixIcon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 15.0),
                    CustomTextFieldWidget(
                      hintText: 'Enter Referral Code (optional)',
                      controller: _codeController,
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.done,
                      prefixIcon: Icons.local_offer_outlined,
                    ),
                    const SizedBox(height: 25.0),
                    isRegister
                        ? const CustomLoaderWidget()
                        : CustomButtonWidget(
                            text: 'Submit',
                            onClick: () {
                              sendOtp();
                            },
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
            ],
          ),
        ),
      ),
    );
  }

  void sendOtp() async {
    final apiData = Provider.of<ApiController>(context, listen: false);

    String name = _nameController.text.trim();
    String company = _companyController.text.trim();
    String phone = _phoneController.text.trim();
    String web = _webController.text.trim();
    String email = _emailController.text.trim();
    String code = _codeController.text.trim();

    if (apiData.bookingType == 'Corporate') {
      if (company.isEmpty) {
        Helper.showToastMessage('Enter company name', Colors.red);
        return;
      }
    }

    if (name.isEmpty) {
      Helper.showToastMessage('Enter your name', Colors.red);
    }

    if (phone.isEmpty) {
      Helper.showToastMessage('Enter phone number', Colors.red);
      return;
    }

    if (apiData.bookingType == 'Corporate') {
      if (web.isEmpty) {
        Helper.showToastMessage('Enter website', Colors.red);
        return;
      }
    }

    if (!Helper.isEmailValid(email)) {
      Helper.showToastMessage('Enter your Valid email',Colors.red);
      return;
    }

    if (code.isEmpty) {
      code = " ";
    }
    Map<String, dynamic> body = {
      "verification_id": '1112',
      "type": apiData.bookingType.toUpperCase(),
      "corporate_name": _companyController.text,
      "name": _nameController.text,
      "contact": _phoneController.text,
      "website": web,
      "email": email,
      'code': code,
      'token': SessionManager.getToken()
    };

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CorporateOTPWidget(body: body));

    /*
    Helper.showLoaderDialog(context, message: 'please Wait..');
    String mobile = ' +91$phone';

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: mobile,
        codeSent: (verificationId, resendToken) {
          Navigator.pop(context);

          Map<String, dynamic> body = {
            "verification_id": verificationId,
            "type": apiData.bookingType.toUpperCase(),
            "corporate_name": _companyController.text,
            "name": _nameController.text,
            "contact": _phoneController.text,
            "website": web,
            "email": email,
            'code': code,
            'token': SessionManager.getToken()
          };

          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => CorporateOTPWidget(body: body));
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
    */
  }
}

//todo:----------------------------------------------------------------

class CorporateOTPWidget extends StatefulWidget {
  const CorporateOTPWidget({super.key, required this.body});
  final Map<String, dynamic> body;
  @override
  State<CorporateOTPWidget> createState() => _CorporateOTPWidgetState();
}
class _CorporateOTPWidgetState extends State<CorporateOTPWidget> {
  bool isVerify = false;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  TextEditingController otpcontroller = TextEditingController();

  String verificationId = "";
  String phoneNumber = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verificationId = widget.body['verification_id'];
    phoneNumber = widget.body['contact'];
  }
  int seconds = 30;
  @override
  Widget build(BuildContext context) {
    final apiData = Provider.of<ApiController>(context);
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey.shade200),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: SizeConfig.width(),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                decoration: BoxDecoration(color: kAppColor.withOpacity(0.2)),
                child: CustomTextWidget(
                  text: 'Phone Verification'.toUpperCase(),
                  textAlign: TextAlign.center,
                  textColor: Theme.of(context).primaryColorLight,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  children: [
                    CustomTextWidget(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      text: 'Enter the verification code',
                      textColor: Theme.of(context).primaryColorLight,
                    ),
                    SizedBox(height: 15.0),
                    CustomTextWidget(
                      text:
                          'Enter the 6-Digit number that we send on your Phone number',
                      textColor: Theme.of(context).hintColor,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25.0),
                    // OTPForm(
                    //   firstController: controller1,
                    //   secondController: controller2,
                    //   thirdController: controller3,
                    //   fourthController: controller4,
                    //   fivethController: controller5,
                    //   sixthController: controller6,
                    // ),
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
                      pinTextStyle: TextStyle(fontSize: 22.0),
                      pinTextAnimatedSwitcherTransition:
                          ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
                      pinTextAnimatedSwitcherDuration:
                          const Duration(milliseconds: 300),
//                    highlightAnimation: true,
                      pinBoxDecoration: pinBoxDecorationBuilder,
                      highlightAnimationBeginColor: Colors.white,
                      highlightAnimationEndColor: Colors.white12,
                      keyboardType: TextInputType.number,
                    ),

                    const SizedBox(height: 25.0),
                    isVerify
                        ? const CustomLoaderWidget()
                        : CustomButtonWidget(
                            text: 'Verify',
                            onClick: () {
                              //verifyOTP();
                              register('123456');
                            },
                          ),
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.center,
                      child: TweenAnimationBuilder(
                          tween: Tween(begin: 30.0, end: 0.0),
                          duration: Duration(seconds: seconds),
                          builder: (_, dynamic value, child) {
                            if (value.toInt() == 0) {
                              return TextButton(
                                  onPressed: () {
                                    resendOTP();
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
                                  color: kAppColor,
                                  fontFamily: 'Overpass'),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
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
      borderRadius: BorderRadius.all(Radius.circular(5)),
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
    // String first = controller1.text;
    // String second = controller2.text;
    // String third = controller3.text;
    // String fourth = controller4.text;
    // String fifth = controller5.text;
    // String sixth = controller6.text;
    //
    // if (first.isEmpty &&
    //     second.isEmpty &&
    //     third.isEmpty &&
    //     fourth.isEmpty &&
    //     fifth.isEmpty &&
    //     sixth.isEmpty) {
    //   Helper.showSnackBar(context, 'Enter Otp', Colors.red);
    //   return;
    // }
    // String otp = first + second + third + fourth + fifth + sixth;
    if (otpcontroller.text.length != 6) {
      Helper.showSnackBar(context, 'Enter Otp', Colors.red);
      return;
    }
    Helper.showLoaderDialog(context, message: 'Verify Otp....');
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpcontroller.text);
    try {
      FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        if (value.user != null) {
          Navigator.pop(context);
          register(value.user!.uid);
        }
      }).onError((error, stackTrace) {
        Navigator.pop(context);
        Helper.showToastMessage(
            ' The verification code is invalid', Colors.red);
      });
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);
      Helper.showSnackBar(context, ex.message!, Colors.red);
    }
  }
  void register(String uid) {
    Helper.showLoaderDialog(context, message: 'Please wait...');
    ApiHelper.register(widget.body).then((value) {
      Navigator.pop(context);
      if (value.apiStatus!.toLowerCase() == 'true') {
        SessionManager.setUserLoggedIn(true);
        SessionManager.setUserID(value.id??''.toString());
        SessionManager.setUserName(value.name??'');
        SessionManager.setUserEmail(value.email??'');
        SessionManager.setLoginWith('USER');
        SessionManager.setMobile(value.contact??'');
      //  SessionManager.setArtistMode(false);

        final data = Provider.of<AppController>(context, listen: false);

        data.setArtistMode(false);
        SessionManager.setProfileImage('');


        SessionManager.setProfileUpdate('0');
        showDialog(
            context: context,
            builder: (context) => SuccessDialogWidget(
                title: 'Verification',
                message: 'Successfully verification. Please! Login Now',
                onClick: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.id, (route) => false);
                },
                btnText: 'ok'));
      } else {
        Navigator.pop(context);
        Helper.showToastMessage(
            value.result ?? 'Something went wrong', Colors.red);
      }
    });
  }

  void registerInFireStore(String userId) {
    UserChat userChat = UserChat(
        uid: userId,
        email: widget.body['email'],
        fullName: widget.body['name'],
        userType: 'USER',
        profilePic:
            'https://www.kindpng.com/picc/m/21-214439_free-high-quality-person-icon-default-profile-picture.png',
        token: '');

    FirebaseHelper.registerInFireStore(userId, userChat).then((value) {
      Navigator.pop(context);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => SuccessDialogWidget(
              title: 'Verification',
              message: 'Successfully verification. Please! Login Now',
              onClick: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.id, (route) => false);
              },
              btnText: 'Login Now'));
    });
  }

  void resendOTP() async {
    String mobile = ' +91$phoneNumber';

    Helper.showLoaderDialog(context, message: 'Resend....');

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: mobile,
        codeSent: (verification, resendToken) {
          Navigator.pop(context);
          setState(() {
            verificationId = verification;
            print(verificationId);
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
        timeout: const Duration(seconds: 60));
  }
}

import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_dialog_widget.dart';
import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_radio_button.dart';
import 'package:book_indian_talents_app/components/custom_text_field_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/components/otp_form.dart';
import 'package:book_indian_talents_app/components/string_drop_down_widget.dart';
import 'package:book_indian_talents_app/firebase/firebase_helper.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/helper/size_config.dart';
import 'package:book_indian_talents_app/model/sub_category.dart';
import 'package:book_indian_talents_app/model/user_chat.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/provider/api_controller.dart';
import 'package:book_indian_talents_app/screens/home_screen.dart';
import 'package:book_indian_talents_app/screens/login_screen.dart';
import 'package:book_indian_talents_app/widgets/corporate_booking_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import '../helper/session_manager.dart';
import '../model/categories.dart';
import '../model/login.dart';
class ChooseModeDialogWidget extends StatefulWidget {
  const ChooseModeDialogWidget({super.key});

  @override
  State<ChooseModeDialogWidget> createState() => _ChooseModeDialogWidgetState();
}

class _ChooseModeDialogWidgetState extends State<ChooseModeDialogWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<ApiController>(context,listen: false).setMode1('');
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
        padding: const EdgeInsets.all(10.0),
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
              text: 'Choose Mode',
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
                            label: 'Hire a talent',
                            value: apiData.mode1 == 'Talent',
                            onChanged: (isCheck) {
                              apiData.setMode1('Talent');
                            }))),
                const SizedBox(width: 15.0),
                Expanded(
                    child: NeumorphismWidget(
                        padding: EdgeInsets.zero,
                        child: CustomRadioButton(
                            radius: 50,
                            label: 'Register as an Artist',
                            value: apiData.mode1 == 'Artist',
                            onChanged: (isCheck) {
                              apiData.setMode1('Artist');
                            })))
              ],
            ),
            const SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: CustomButtonWidget(
                text: 'OK',
                onClick: () {
                  if (apiData.mode1.isEmpty && apiData.mode2.isEmpty) {
                    Helper.showToastMessage('Choose mode', Colors.red);
                    return;
                  }
                  apiData.signUpBody['mode1'] = apiData.mode1;
                  apiData.setSignUpBody(apiData.signUpBody);
                  Navigator.pop(context);
                  if (apiData.mode1 == 'Talent') {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => const HireTalentDialogWidget());
                  } else {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => const ArtistRegisterPage());
                  }
                },
              ),
            ),
            const SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }
}

class ArtistRegisterPage extends StatefulWidget {
  const ArtistRegisterPage({super.key});
  @override
  State<ArtistRegisterPage> createState() => _ArtistRegisterPageState();
}
class _ArtistRegisterPageState extends State<ArtistRegisterPage> {
  bool isArtistRegister = false;
  final TextEditingController _ArtistnameController = TextEditingController();
  final TextEditingController _ArtistphoneController = TextEditingController();
  final TextEditingController _ArtistwebController = TextEditingController();
  final TextEditingController _ArtistemailController = TextEditingController();

  List<CategoryData> categoriesList = [];
  List<SubCategoryData> subcaregorylist = [];
  late CategoryData initialValue;
  SubCategoryData? initialValuesubcat;
  bool iscategorires = false;
  bool issubcategorires = false;
  bool listViewVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final apiData = Provider.of<ApiController>(context, listen: false);
    _ArtistphoneController.text = apiData.signUpBody['contact_number'];
    getCategorye();
  }
  void getCategorye() {
    setState(() {
      iscategorires = true;
    });
    CategoryData categoriesData =
        CategoryData(id: '-1', name: 'Select category', image: '', path: '');
    categoriesList.add(categoriesData);
    ApiHelper.getCategories().then(
      (value) {
        if (value.apiStatus == 'true') {
          categoriesList.addAll(value.data!);
        }
        setState(() {
          iscategorires = false;
        });
      },
    );
    initialValue = categoriesList[0];
    print(initialValue.name);
  }
  void getSubcategory() {
    subcaregorylist.clear();
    setState(() {
      issubcategorires = true;
    });
    SubCategoryData subCategorydata = SubCategoryData(
      id: '-1',
      subName: 'Select sub category',
      image: '',
      path: '',
    );
    subcaregorylist.add(subCategorydata);
    Map<String, dynamic> body = {"cat_id": initialValue.id};
    print(body);
    ApiHelper.getSubcat(body).then((value) {
      if (value.apiStatus == 'true') {
        subcaregorylist.addAll(value.data!);
      }
      setState(() {
        issubcategorires = false;
      });
    });
    initialValuesubcat = subcaregorylist[0];
  }
  @override
  Widget build(BuildContext context) {
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
                  text: 'Register as Artist',
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
                    CustomTextFieldWidget(
                      hintText: 'Enter Artist name',
                      controller: _ArtistnameController,
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      prefixIcon: Icons.person_2_outlined,
                    ),
                    const SizedBox(height: 15.0),
                    CustomTextFieldWidget(
                      hintText: 'Enter contact number',
                      isEnable: false,
                      controller: _ArtistphoneController,
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.next,
                      prefixIcon: Icons.phone_android_rounded,
                    ),
                    const SizedBox(height: 15.0),
                    CustomTextFieldWidget(
                      hintText: 'Enter Email',
                      controller: _ArtistemailController,
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.done,
                      prefixIcon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 15.0),
                    iscategorires
                        ? CustomLoaderWidget()
                        : CategoreyDropDownWidget(
                            initialValue: initialValue,
                            items: categoriesList,
                            onChange: (value) {
                              setState(() {
                                initialValue = value;
                                getSubcategory();
                              });
                            },
                          ),
                    const SizedBox(height: 15.0),
                    Visibility(
                      visible: initialValue.id != '-1',
                      child: issubcategorires
                          ? const CustomLoaderWidget()
                          : SubCategoreyDropDownWidget(
                              initialValuesubcat:
                                  initialValuesubcat ?? SubCategoryData(),
                              items: subcaregorylist,
                              onChange: (value) {
                                setState(() {
                                  initialValuesubcat = value;
                                });
                              },
                            ),
                    ),
                    const SizedBox(height: 25.0),
                    CustomButtonWidget(
                      text: 'Submit',
                      onClick: () {
                        sendotp();
                        //  showDialog(
                        //      context: context,
                        //      builder: (context) =>  EmailVerificationDialogWidget(body: {},));
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
  void sendotp() async {
    String name = _ArtistnameController.text;
    String mobile = _ArtistphoneController.text;
    String email = _ArtistemailController.text;
    if (name.isEmpty) {
      Helper.showToastMessage('Enter Name', Colors.red);
      return;
    }
    if (mobile.isEmpty) {
      Helper.showToastMessage('Enter Mobile Number', Colors.red);
      return;
    }

    if (!Helper.isEmailValid(email)) {
      Helper.showToastMessage('Enter your Valid email',Colors.red);
      return;
    }
    if (initialValue.id == '-1') {
      Helper.showToastMessage('Select Category', Colors.red);
      return;
    }
    if (initialValuesubcat!.id == '-1') {
      Helper.showToastMessage('Select Sub Category', Colors.red);
      return;
    }
    Map<String, dynamic> body = {
      'verification_id': '123456',
      "name": name,
      "contact": mobile,
      "email": email,
      "category_id": initialValue.id,
      "subcat_id": initialValuesubcat!.id,
      'token': SessionManager.getToken()
    };
    print('BODYYYYY ${body}');
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => EmailVerificationDialogWidget(
          body: body,
        ));
  /*  Helper.showLoaderDialog(context, message: 'Please wait...');
    String phone = ' +91$mobile';

    print('SENDING OTP');

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        codeSent: (verificationId, resendToken) {
          Navigator.pop(context);

          Map<String, dynamic> body = {
            'verification_id': verificationId,
            "name": name,
            "contact": mobile,
            "email": email,
            "category_id": initialValue.id,
            "subcat_id": initialValuesubcat!.id,
            'token': SessionManager.getToken()
          };
          print('BODYYYYY ${body}');
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => EmailVerificationDialogWidget(
                    body: body,
                  ));
        },
        verificationCompleted: (credential) {
          // Navigator.pop(context);
        },
        verificationFailed: (ex) {
          print(ex);
          //Navigator.pop(context);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          //Navigator.pop(context);
        },
        timeout: const Duration(seconds: 30));

   */
  }
}
//todo:-----------------------------------------------------------------

//todo:---------------------------------------------------------------------------------
class EmailVerificationDialogWidget extends StatefulWidget {
  const EmailVerificationDialogWidget({super.key, required this.body});

  final Map<String, dynamic> body;

  @override
  State<EmailVerificationDialogWidget> createState() =>
      _EmailVerificationDialogWidgetState();
}
class _EmailVerificationDialogWidgetState
    extends State<EmailVerificationDialogWidget> {
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
    print(widget.body);
    verificationId = widget.body['verification_id'];
    phoneNumber = widget.body['contact'];
  }
  int seconds = 30;
  @override
  Widget build(BuildContext context) {
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
                  textColor: Theme
                      .of(context)
                      .primaryColorLight,
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
                      textColor: Theme
                          .of(context)
                          .primaryColorLight,
                    ),
                    SizedBox(height: 15.0),
                    CustomTextWidget(
                      text:
                      'Enter the 6-Digit number that we send on your Phone number',
                      textColor: Theme
                          .of(context)
                          .hintColor,
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
                      onDone: (text) {

                      },
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
                    const SizedBox(height: 25.0),
                    isVerify
                        ? const CustomLoaderWidget()
                        : CustomButtonWidget(
                      text: 'Verify',
                      onClick: () {
                          widget.body.remove('verification_id');
                        register('1234');
                       // verifyOTP();
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
                                    //resendOTP();
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
      border:Border.all(color: Colors.black),
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
          widget.body.remove('verification_id');
          register(value.user!.uid);
        }
      }).onError((error, stackTrace) {
        Navigator.pop(context);
        Helper.showToastMessage(' The verification code is invalid', Colors.red);
      });
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);
      Helper.showSnackBar(context, ex.message!, Colors.red);
    }
  }

  void register(String uid) {

    print(uid);
    Helper.showLoaderDialog(context, message: 'Please wait...');
    ApiHelper.artistRegister(widget.body).then((value) {

      if (value.apiStatus!.toLowerCase() == 'true') {
        SessionManager.setUserLoggedIn(true);
        SessionManager.setUserID(value.id!.toString());
        SessionManager.setUserName(value.name!);
        SessionManager.setUserEmail(value.email!);
        SessionManager.setLoginWith('ARTIST');
        SessionManager.setMobile(value.contact!);
        SessionManager.setProfileUpdate('0');
        SessionManager.setArtistMode(true);

        // if(value.userType!.toLowerCase() == 'artist'){
        //   SessionManager.setArtistMode(true);
        // }
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
                btnText: 'OK'));


        //registerInFireStore(uid ?? '');
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
        userType: 'ARTIST',
        profilePic:
            'https://www.kindpng.com/picc/m/21-214439_free-high-quality-person-icon-default-profile-picture.png',
        token: '');


    FirebaseHelper.registerInFireStore(userId, userChat).then((value)   {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => SuccessDialogWidget(
              title: 'Verification',
              message: 'Successfully verification. Please! Login Now',
              onClick: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.id, (route) => false);
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
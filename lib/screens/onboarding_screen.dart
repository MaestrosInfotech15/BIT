import 'dart:async';

import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/screens/welcom_screen.dart';
import 'package:book_indian_talents_app/widgets/onboarding_1_widget.dart';
import 'package:flutter/material.dart';

import '../helper/session_manager.dart';
import '../widgets/onboarding_2_widget.dart';
import '../widgets/onboarding_3_widget.dart';
import '../widgets/onboarding_4_widget.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static const String id = 'onboarding_screen';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pagecontroller = PageController(    initialPage: 0,
  );
  Timer? _timer;
int duration=5;
  List<Widget> pages = [
    const Onboarding1Widget(),
    const Onboarding2Widget(),
    const Onboarding3Widget(),
    const Onboarding4Widget(),
  ];
  PageController controller = PageController();
  int _selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   autoSlider();
  }

  void autoSlider(){
    _timer = Timer.periodic( Duration(seconds: duration), (Timer timer) {
      if (_selectedIndex < 3) {
        _selectedIndex++;
      } else {
        _selectedIndex = 0;
      }

      pagecontroller.animateToPage(
        _selectedIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(_timer!=null){
      _timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                itemCount: pages.length,
                controller: pagecontroller,
                onPageChanged: (page) {
                  if(_timer!=null){
                    _timer!.cancel();
                  }
                  autoSlider();
                  setState(() {
                    _selectedIndex = page;
                  });
                },
                itemBuilder: (context, position) {
                  return SafeArea(child: pages[position]);
                }),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
            color: kAppBarColor,
            child: Row(
              children: [
                CustomButtonWidget(
                    text: 'Skip',
                    width: 80,
                    height: 35,
                    radius: 20,
                    fontSize: 16,
                    onClick: () {
                      setState(() {
                        if(_timer!=null){
                          _timer!.cancel();
                        }
                        SessionManager.setWelcome(true);
                        Navigator.pushNamed(context, LoginScreen.id);
                        /*if (pages.length - 1 == _selectedIndex) {
                          Navigator.pushNamed(context, WelcomScreen.id);

                        } else {
                          pagecontroller.animateToPage(_selectedIndex + 1,
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.bounceInOut);


                          autoSlider();
                        }*/
                      });
                    }),
                // TextButton(
                //     onPressed: () {
                //       setState(() {
                //         if(_timer!=null){
                //           _timer!.cancel();
                //         }
                //         Navigator.pushNamed(context, WelcomScreen.id);
                //         /*if (pages.length - 1 == _selectedIndex) {
                //           Navigator.pushNamed(context, WelcomScreen.id);
                //
                //         } else {
                //           pagecontroller.animateToPage(_selectedIndex + 1,
                //               duration: const Duration(milliseconds: 350),
                //               curve: Curves.bounceInOut);
                //
                //
                //           autoSlider();
                //         }*/
                //       });
                //     },
                //     child: const CustomTextWidget(
                //       text: 'Skip',
                //       textColor: Colors.white,
                //       fontSize: 16.0,
                //       fontWeight: FontWeight.w600,
                //     )),
                Expanded(
                  child: Center(
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                            pages.length,
                            (index) => AnimatedContainer(
                                  height: 10,
                                  width: 10,
                                  margin: const EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                      color: _selectedIndex == index
                                          ? kAppColor
                                          : Colors.red.shade100,
                                      shape: BoxShape.circle),
                                  duration: const Duration(milliseconds: 350),
                                ))),
                  ),
                ),
                CustomButtonWidget(
                    text: 'Next',
                    width: 80,
                    height: 35,
                    radius: 20,
                    fontSize: 16,
                    onClick: () {
                      setState(() {
                        if(_timer!=null){
                          _timer!.cancel();
                        }
                        if (pages.length - 1 == _selectedIndex) {
                          SessionManager.setWelcome(true);
                          Navigator.pushNamed(context, LoginScreen.id);
                        } else {

                          //  pagecontroller.jumpToPage(_selectedIndex + 1);
                          pagecontroller.animateToPage(_selectedIndex + 1,
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.bounceInOut);

                          autoSlider();
                        }
                      });
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

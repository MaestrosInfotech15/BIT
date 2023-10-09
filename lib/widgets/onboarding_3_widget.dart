import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/size_config.dart';
import 'package:flutter/material.dart';

import '../components/custom_text_widget.dart';

class Onboarding3Widget extends StatelessWidget {
  const Onboarding3Widget({super.key});

  @override
  Widget build(BuildContext context) {
    print(SizeConfig.screenHeight() * 35);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/onboarding_3.png',
              height: SizeConfig.screenHeight() * 35, width: double.infinity),
          const SizedBox(height: 10),
           SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: 'Showcase Your Talent '.toUpperCase(),
                  textColor: kAppColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
                SizedBox(height: 2.0),
                CustomTextWidget(
                  text:
                      "Talented and seeking opportunities? Join BIT to showcase your skills to a global audience. From amateurs to seasoned professionals, everyone is welcome!",
                  textColor: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
                SizedBox(height: 10),
                CustomTextWidget(
                  text: 'Create Your Profile'.toUpperCase(),
                  textColor: kAppColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
                SizedBox(height: 2),
                CustomTextWidget(
                  text:
                      "Craft an impressive talent profile that highlights your expertise, experience, and past performances. Upload pictures and videos that capture your best moments.",
                  textColor: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextWidget(
                  text: 'Get Discovered'.toUpperCase(),
                  textColor: kAppColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
                SizedBox(height: 2.0),
                CustomTextWidget(
                  text:
                      "Reach out to potential clients and let them find you. Stand out with positive reviews and build your reputation in the entertainment world.",
                  textColor: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                SizedBox(height: 10),
                CustomTextWidget(
                  text: 'Secure Bookings'.toUpperCase(),
                  textColor: kAppColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
                SizedBox(height: 2.0),
                CustomTextWidget(
                  text:
                      "Receive booking requests from interested clients. Negotiate terms, accept offers, and get ready to shine on stage!",
                  textColor: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

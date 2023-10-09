import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/size_config.dart';
import 'package:flutter/material.dart';

import '../components/custom_text_widget.dart';

class Onboarding4Widget extends StatelessWidget {
  const Onboarding4Widget({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/onboarding_4.png',
            height: SizeConfig.screenHeight() * 35,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 10),
           Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: 'Your Event, Our Priority'.toUpperCase(),
                  textColor: kAppColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                ),
                SizedBox(height: 2.0),
                CustomTextWidget(
                  text:"At BIT, we prioritize your satisfaction and ensure a seamless hiring experience. Hire any Indian talent from BIT, Hassle free Booking.",
                  textColor: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                SizedBox(height: 10),
                CustomTextWidget(
                  text: 'Secure Payments'.toUpperCase(),
                  textColor: kAppColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
                SizedBox(height: 2.0),
                CustomTextWidget(
                  text:
                      "Process payments safely and securely through our trusted payment gateway. Only release funds when you are satisfied with the talent's performance.",
                  textColor: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                SizedBox(height: 10),
                CustomTextWidget(
                  text: '24/7 Customer Support'.toUpperCase(),
                  textColor: kAppColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
                SizedBox(height: 2.0),
                CustomTextWidget(
                  text: "Encounter any issues? Our dedicated support team is available around the clock to assist you, from initial inquiry to post-event follow-up.",
                  textColor: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                SizedBox(height: 10),
                CustomTextWidget(
                  text: 'Rate and Review'.toUpperCase(),
                  textColor: kAppColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
                SizedBox(
                  height: 2.0,
                ),
                CustomTextWidget(
                  text: "Share your valuable feedback to help us maintain a high standard of talent. Rate your experience and leave reviews for the talents you hire.",
                  textColor: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
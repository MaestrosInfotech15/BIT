import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/size_config.dart';
import 'package:flutter/material.dart';

class Onboarding1Widget extends StatelessWidget {
  const Onboarding1Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/onboarding_1.png',
          height: SizeConfig.screenHeight()*35,
          width: double.infinity,
        ),
        const SizedBox(height: 10),
         SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              CustomTextWidget(
                text: 'Welcome to Book Indian Talents (BIT)!'.toUpperCase(),
                textColor:kAppColor,
                fontWeight: FontWeight.w700,
                fontSize: 28,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              CustomTextWidget(
                text:
                "Discover Remarkable Talents for any occasion - from singers to actors, dancers to comedians, Poets, Live Bands etc. we've got it all! Explore a world of limitless possibilities and elevate your events.",
                textColor: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),

      ],
    );
  }
}

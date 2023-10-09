import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/size_config.dart';
import 'package:flutter/material.dart';

import '../components/custom_text_widget.dart';

class Onboarding2Widget extends StatelessWidget {
  const Onboarding2Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/onboarding_2.jpeg',
          width: double.infinity,
          height: SizeConfig.screenHeight() * 35,
        ),
        const SizedBox(height: 10),
         SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: 'Explore !'.toUpperCase(),
                textColor: kAppColor,

                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              SizedBox(height: 2.0),
              CustomTextWidget(
                text:
                    "Browse through a wide array of talented individuals. Use filters to refine your search based on Categories, Ratings, Budget",
                textColor: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              SizedBox(height: 10),
              CustomTextWidget(
                text: 'Shortlist !'.toUpperCase(),
                textColor: kAppColor,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              SizedBox(height: 2),
              CustomTextWidget(
                text:
                    "Create your shortlist of preferred talents. Review their profiles, performances, and testimonials to make informed decisions.",
                textColor: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              SizedBox(height: 10),
              CustomTextWidget(
                text: 'Connect !'.toUpperCase(),
                textColor: kAppColor,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              SizedBox(height: 2),
              CustomTextWidget(
                text:
                    "Connect with the talents through our secure system. Choose the package according to your requirements, and finalize the details.",
                textColor: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              )
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/screens/support_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/custom_text_widget.dart';
import '../components/neumorphism_widget.dart';
import '../helper/constants.dart';

class SupportBookingScreen extends StatefulWidget {
  static const String id = 'support_booking_Screen';

  const SupportBookingScreen({super.key});

  @override
  State<SupportBookingScreen> createState() => _SupportBookingScreenState();
}

class _SupportBookingScreenState extends State<SupportBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Support ',
          textColor: Theme
              .of(context)
              .primaryColorLight,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Column(
        children: [
          Expanded(child: Image.asset('assets/images/support_icon.png',)),

          InkWell(
            onTap: () {
              Navigator.pushNamed(context, SupportChatScreen.id);
            },
            child: NeumorphismWidget(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Image.asset('assets/images/comment.png',),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextWidget(
                      text: 'On Chat',
                      textColor: Colors.grey,
                      fontSize: 14,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextWidget(
                      text: 'Live Chat',
                      textColor: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Helper.whatsapp();
                    },
                    child: NeumorphismWidget(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Image.asset('assets/images/whatsapp.png'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextWidget(
                            text: 'On Chat',
                            textColor: Colors.grey,
                            fontSize: 14,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomTextWidget(
                            text: 'Whatsapp',
                            textColor: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: InkWell(onTap:() {
                    Helper.launchApp('mailto:smith@example.org');
                  },
                    child: NeumorphismWidget(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Image.asset('assets/images/email.png'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextWidget(
                            text: 'On Chat',
                            textColor: Colors.grey,
                            fontSize: 14,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomTextWidget(
                            text: 'Email',
                            textColor: kAppColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

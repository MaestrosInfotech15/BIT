import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/screens/login_screen.dart';
import 'package:book_indian_talents_app/screens/register_screen.dart';
import 'package:flutter/material.dart';

import '../components/custom_button_widget.dart';
import '../helper/constants.dart';

class WelcomScreen extends StatelessWidget {
  static const String id = 'welcom_screen';

  const WelcomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/welcom.png',
                  width: 400,
                  height: 400,
                ),
              ),
            ),
            Column(
              children: [
                CustomButtonWidget(
                  radius: 25,
                  height: 50,
                  width: 150,
                  text: 'Sign up',
                  onClick: () {
                    SessionManager.setWelcome(true);
                    //  Navigator.pushNamed(context, RegisterScreen.id);
                    Navigator.pushNamedAndRemoveUntil(
                        context, RegisterScreen.id, (route) => false);
                  },
                ),
                const SizedBox(
                  width: 10,
                  height: 10,
                ),
                CustomButtonWidget(
                  height: 50,
                  width: 150,
                  radius: 25,
                  btnColor: kAppColor.withOpacity(0.5),
                  text: 'Login',
                  onClick: () {
                    SessionManager.setWelcome(true);
                    //  Navigator.pushNamed(context, LoginScreen.id);
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginScreen.id, (route) => false);
                  },
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

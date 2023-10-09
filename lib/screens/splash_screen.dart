import 'dart:async';

import 'package:book_indian_talents_app/screens/ongoing_booking_screen.dart';
import 'package:flutter/material.dart';

import '../helper/session_manager.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    Timer(Duration(seconds: 4), () {
      Navigator.pushNamed(context,getPage());
    });
  }

  String getPage() {
    SessionManager.setWelcome(true);
    // if (SessionManager.getWelcome() == false) {
    //   return OnboardingScreen.id;
    // }
    if (SessionManager.isLoggedIn() == false) {
      return LoginScreen.id;
    }
    return HomeScreen.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation as Animation<double>,
          child: Center(
            child: Image.asset('assets/icons/transparent_logo.png',height: 180,width: 180,),
          ),
        ),
      ),
    );
  }
}

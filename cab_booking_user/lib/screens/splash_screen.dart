import 'dart:async';

import 'package:cab_booking_user/screens/slider_screen.dart';
import 'package:cab_booking_user/screens/welcome_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    // Wait for a couple of seconds to show the splash screen
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    // Check if the 'isFirstTime' key exists. If not, it's the first time.
    final bool isFirstTime = prefs.getBool('isFirstTime') ?? false;
    print('Is first time: $isFirstTime');

    if (mounted) {
      if (isFirstTime) {
        // If the user has already seen the onboarding, go to WelcomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      } else {
        // If it's the first time, show SliderScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SliderScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background
      body: Center(
        child: SvgPicture.asset(
          'assets/images/svg/app_logo.svg', // Ensure correct path
          width: 200,
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:cab_booking_user/screens/SliderScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// Import your welcome screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SliderScreen()),
      );
    });
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

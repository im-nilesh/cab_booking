// lib/user_pages/home_page.dart
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Home Page',
        style: TextStyle(fontSize: 24, color: blackColor),
      ),
    );
  }
}

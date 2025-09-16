// lib/user_pages/profile_page.dart
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile Page',
        style: TextStyle(fontSize: 24, color: blackColor),
      ),
    );
  }
}

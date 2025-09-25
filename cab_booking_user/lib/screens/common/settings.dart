// lib/screens/common/settings_screen.dart
import 'package:cab_booking_user/Widgets/app%20bar/custom_appbar.dart';
import 'package:cab_booking_user/components/settings/phone_number_card.dart';
import 'package:cab_booking_user/components/settings/setting_tile.dart';
import 'package:cab_booking_user/components/settings/signout_button.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color lightGreyBg = const Color(0xffF6F6F6);
    final Color subtleTextColor = Colors.grey.shade600;

    return Scaffold(
      backgroundColor: lightGreyBg,
      appBar: const CustomAppBar(title: "Settings"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Phone number section
            Text(
              "My Phone number",
              style: TextStyle(fontSize: 15, color: subtleTextColor),
            ),
            const SizedBox(height: 10),
            const PhoneNumberCard(
              phoneNumber: "7363738394",
              isVerified: true,
              onUpdate: null, // Add callback if needed
            ),
            const SizedBox(height: 20),

            // Notifications row
            SettingTile(
              title: "Notifications",
              onTap: () {
                // Navigate to notifications
              },
            ),

            const Spacer(),

            // Sign out button
            const SignOutButton(),

            const SizedBox(height: 15),

            // Delete account text
            Center(
              child: Text(
                "Delete my account",
                style: TextStyle(color: subtleTextColor, fontSize: 15),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

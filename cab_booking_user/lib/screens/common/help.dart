import 'package:cab_booking_user/Widgets/app%20bar/custom_appbar.dart';
import 'package:cab_booking_user/components/common/support_card.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define colors and styles to match the screenshot
    const Color lightGreyBg = Color(0xffF6F6F6);
    final Color subtleTextColor = Colors.grey.shade600;

    return Scaffold(
      backgroundColor: lightGreyBg,
      appBar: const CustomAppBar(title: "Help"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // "Customer care" label
            Text(
              "Customer care",
              style: TextStyle(fontSize: 15, color: subtleTextColor),
            ),
            const SizedBox(height: 10),

            // Customer support card
            CustomerSupportCard(
              phoneNumber: "1234262722",
              onCall: () {
                // To Do: Implement call functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}

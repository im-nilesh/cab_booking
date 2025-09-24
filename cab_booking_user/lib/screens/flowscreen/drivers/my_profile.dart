import 'package:cab_booking_user/components/Profile/profile_header_card.dart';
import 'package:cab_booking_user/components/Profile/profile_menu_item.dart';
import 'package:flutter/material.dart';

class MyProfileScreen extends StatelessWidget {
  final bool isDriver;

  const MyProfileScreen({super.key, this.isDriver = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProfileHeaderCard(
              name: "Manoj Pandey",
              imageUrl: 'assets/images/image11.png',
              isDriver: isDriver,
              rating: 4.2,
            ),
            const SizedBox(height: 20),
            ProfileMenuItem(
              icon: Icons.directions_car,
              title: 'My Vehicle Details',
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Icons.help_outline,
              title: 'Help',
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Icons.privacy_tip,
              title: 'Security & Privacy Policy',
              onTap: () {},
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

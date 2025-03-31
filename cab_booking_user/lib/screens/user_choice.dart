import 'package:cab_booking_user/Widgets/button/icon_button.dart';
import 'package:cab_booking_user/screens/user_reg.dart';
import 'package:flutter/material.dart';

import 'package:cab_booking_user/utils/constants.dart';

class UserChoice extends StatefulWidget {
  const UserChoice({super.key});

  @override
  State<UserChoice> createState() => _UserChoiceState();
}

class _UserChoiceState extends State<UserChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration Placeholder
            Image.asset(
              'assets/images/Carpool-bro 1.png', // Replace with your asset path
              height: 200,
            ),
            const SizedBox(height: 40),

            // Register as User Button
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.07,
              child: IconPrimaryButton(
                text: 'Register as a User',
                icon: Icons.person,
                onPressed: () {
                  // Navigate to User Registration Screen
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const UserRegistrationScreen(),
                    ),
                  );
                },
                backgroundColor: greencolor,
                textColor: Colors.white,
                iconColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Register as Driver Button
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.07,
              child: IconPrimaryButton(
                text: 'Register as a Driver',
                icon: Icons.directions_car,
                onPressed: () {
                  // Navigate to Driver Registration Screen
                  Navigator.pushNamed(context, '/driver_registration');
                },
                backgroundColor: greencolor,
                textColor: Colors.white,
                iconColor: Colors.white,
              ),
            ),
            const SizedBox(height: 40),

            // Information Text
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: dialogBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info, color: greencolor),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Driver accounts cannot request rides. Create a separate User account to request rides as a passenger.',
                      style: TextStyle(fontSize: 12, color: dialogTextColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

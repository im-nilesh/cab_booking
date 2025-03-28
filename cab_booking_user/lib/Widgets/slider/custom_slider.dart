import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    super.key,
    required this.imagePath,
    required this.heading,
    required this.subheading,
  });

  final String imagePath;
  final String heading;
  final String subheading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 250),
          SizedBox(height: 40),
          Text(
            heading,
            style: TextStyle(
              fontSize: 24,
              color: blackColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15),
          Text(
            subheading,
            style: TextStyle(fontSize: 14, color: grayColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

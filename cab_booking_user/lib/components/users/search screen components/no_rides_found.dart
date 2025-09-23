import 'package:flutter/material.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter_svg/svg.dart';

class NoRidesFound extends StatelessWidget {
  const NoRidesFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/images/svg/Sorry.svg', height: 200),
        const SizedBox(height: 20),
        const Text(
          'No rides found!',
          style: TextStyle(fontSize: 18, color: grayColor2),
        ),
      ],
    );
  }
}

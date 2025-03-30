import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:cab_booking_user/utils/constants.dart';

class CustomOtpInput extends StatelessWidget {
  final TextEditingController otpController;

  const CustomOtpInput({Key? key, required this.otpController})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 20,
        color: blackColor,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
        color: whiteColor,
      ),
    );

    return Pinput(
      controller: otpController,
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: greencolor),
          color: whiteColor,
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: activeborderColor),
          color: whiteColor,
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }
}

import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomPhonenoTextfield extends StatelessWidget {
  const CustomPhonenoTextfield({
    super.key,
    required this.phoneController,
    required this.selectedCountryCode,
  });

  final TextEditingController phoneController;
  final String selectedCountryCode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        fillColor: whiteColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor), // Default border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor), // Focused border color
        ),
        hintStyle: TextStyle(color: grayColor3),
        hintText: ' Your mobile number',
        prefixStyle: TextStyle(color: blackColor),
        prefixText: ' $selectedCountryCode',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor), // Default border color
        ),
      ),
    );
  }
}

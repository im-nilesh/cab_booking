// lib/widgets/custom_text_field.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart'; // Import your constants file

class CustomLocationTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isAreaField; // To indicate if it's an "Add Area" field
  final VoidCallback? onAddArea; // Callback for adding new area tags
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const CustomLocationTextfield({
    Key? key,
    required this.hintText,
    required this.controller,
    this.isAreaField = false,
    this.onAddArea,
    this.suffixIcon,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: whiteColor, // Background of the text field
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: borderColor, // Default border color
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: blackColor), // Input text color
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: hintColor),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: InputBorder.none, // Remove default TextField border
          suffixIcon:
              suffixIcon ??
              (isAreaField
                  ? IconButton(
                    icon: const Icon(Icons.add, color: greencolor),
                    onPressed: onAddArea,
                  )
                  : null),
        ),
      ),
    );
  }
}

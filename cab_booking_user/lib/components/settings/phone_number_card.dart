// lib/widgets/settings/phone_number_card.dart
import 'package:flutter/material.dart';

class PhoneNumberCard extends StatelessWidget {
  final String phoneNumber;
  final bool isVerified;
  final VoidCallback? onUpdate;

  const PhoneNumberCard({
    super.key,
    required this.phoneNumber,
    this.isVerified = false,
    this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final Color cardBorderColor = Colors.grey.shade300;
    final Color verifiedGreen = const Color(0xff12B76A);
    final Color subtleTextColor = Colors.grey.shade600;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cardBorderColor, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  phoneNumber,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (isVerified) ...[
                  const SizedBox(width: 8),
                  Icon(Icons.check_circle, color: verifiedGreen, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    "Verified",
                    style: TextStyle(
                      color: verifiedGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          GestureDetector(
            onTap: onUpdate,
            child: Text(
              "Update",
              style: TextStyle(
                color: subtleTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

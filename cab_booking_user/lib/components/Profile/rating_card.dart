import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';

class RatingCard extends StatelessWidget {
  final double rating;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;

  const RatingCard({
    super.key,
    required this.rating,
    this.backgroundColor = whiteColor,
    this.textColor = blackColor,
    this.iconColor = blackColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: blackColor,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, size: 16, color: iconColor),
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

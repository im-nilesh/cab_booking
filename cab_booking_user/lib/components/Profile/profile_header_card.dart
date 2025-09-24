import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:cab_booking_user/components/Profile/rating_card.dart';

class ProfileHeaderCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool isDriver;
  final double rating;

  const ProfileHeaderCard({
    super.key,
    required this.name,
    required this.imageUrl,
    this.isDriver = false,
    this.rating = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: greencolor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile image
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              imageUrl,
              width: 55,
              height: 55,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // Name + Rating
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: whiteColor,
                  ),
                ),
                const SizedBox(height: 6),
                RatingCard(
                  rating: rating,
                  backgroundColor: whiteColor,
                  textColor: blackColor,
                  iconColor: blackColor,
                ),
              ],
            ),
          ),

          // Edit button
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit, color: whiteColor),
          ),
        ],
      ),
    );
  }
}

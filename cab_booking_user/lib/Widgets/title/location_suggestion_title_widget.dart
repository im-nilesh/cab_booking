import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';

class LocationSuggestionTile extends StatelessWidget {
  final String city;
  final String address;
  final VoidCallback onTap;

  const LocationSuggestionTile({
    super.key,
    required this.city,
    required this.address,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Row(
          children: [
            // Location Icon inside circular background
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: dialogBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.location_on, // Flutter’s built-in location icon
                size: 22,
                color: greencolor,
              ),
            ),
            const SizedBox(width: 12),

            // City name + Address
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    address,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
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

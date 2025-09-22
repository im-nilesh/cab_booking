import 'package:flutter/material.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class CarOptionCard extends StatelessWidget {
  final String imagePath;
  final String carName;
  final int price;
  final bool isSelected;
  final VoidCallback onTap;

  const CarOptionCard({
    super.key,
    required this.imagePath,
    required this.carName,
    required this.price,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? greencolor.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? greencolor : Colors.grey.shade300,
            width: 1.5,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              height: 40,
              width: 80,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Placeholder in case image fails to load
                return const Icon(
                  Icons.directions_car,
                  size: 40,
                  color: Colors.grey,
                );
              },
            ),
            const SizedBox(width: 16),
            Text(
              carName,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: blackColor,
              ),
            ),
            const Spacer(),
            Text(
              price > 0 ? "₹ $price" : "N/A",
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

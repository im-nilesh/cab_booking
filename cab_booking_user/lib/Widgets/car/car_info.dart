import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarInfoRow extends StatelessWidget {
  final String carName;
  final dynamic carPrice;
  final dynamic advancePrice;
  final String carImage;

  const CarInfoRow({
    super.key,
    required this.carName,
    required this.carPrice,
    required this.advancePrice,
    required this.carImage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(carImage, height: 40, width: 80, fit: BoxFit.contain),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              carName,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Advance: ₹ $advancePrice',
              style: GoogleFonts.outfit(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        const Spacer(),
        Text(
          '₹ $carPrice',
          style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

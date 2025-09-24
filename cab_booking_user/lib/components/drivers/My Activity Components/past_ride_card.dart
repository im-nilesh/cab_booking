import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PastRideCard extends StatelessWidget {
  final Map<String, dynamic> rideData;

  const PastRideCard({Key? key, required this.rideData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rideData['date'],
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            color: grayColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          rideData['time'],
                          style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                    Column(
                      children: [
                        const Icon(
                          Icons.circle_outlined,
                          color: greencolor,
                          size: 12,
                        ),
                        SizedBox(
                          height: 20,
                          child: VerticalDivider(
                            color: grayColor,
                            thickness: 1,
                          ),
                        ),
                        const Icon(Icons.circle, color: Colors.green, size: 12),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rideData['origin'],
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          rideData['destination'],
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Earned",
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        color: grayColor2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹${rideData['earned']}',
                      style: GoogleFonts.outfit(
                        color: greencolor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total passengers : ${rideData['passengers']}',
                  style: GoogleFonts.outfit(fontSize: 16, color: grayColor2),
                ),
                Row(
                  children: [
                    Text(
                      'View in detail',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        color: grayColor2,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: grayColor,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

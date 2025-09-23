// lib/components/users/booked_ride_details_card.dart
import 'package:flutter/material.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BookedRideDetailsCard extends StatelessWidget {
  final Map<String, dynamic> rideData;

  const BookedRideDetailsCard({Key? key, required this.rideData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime rideDateTime = rideData['dateTime'].toDate();
    final String formattedTime = DateFormat('HH:mm').format(rideDateTime);
    final String formattedDate = DateFormat('dd MMM').format(rideDateTime);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Taxi Booked',
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: greencolor,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedDate,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formattedTime,
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    rideData['origin'],
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                    child: VerticalDivider(color: Colors.black, thickness: 5),
                  ),
                  Text(
                    rideData['destination'],
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '1 Seat reserved', // This is hardcoded for now
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.hourglass_bottom,
                        color: Colors.orange,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Request pending',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

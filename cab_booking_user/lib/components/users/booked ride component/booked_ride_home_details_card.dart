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
    final String rideStatus = rideData['ride_status'] ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cardtopcolor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Image.asset('assets/images/taxi.png', width: 30, height: 30),
                const SizedBox(width: 8),
                Text(
                  'Taxi Booked',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: greencolor,
                  ),
                ),
              ],
            ),
          ),

          // Ride Details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date and Time Column
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
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

                // Locations Column
                Row(
                  children: [
                    Column(
                      children: [
                        const Icon(
                          Icons.circle_outlined,
                          color: Colors.green,
                          size: 12,
                        ),
                        SizedBox(
                          height: 20,
                          child: VerticalDivider(
                            color: Colors.grey.shade400,
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

                // Seat and Status Column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Seat reserved',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (rideStatus == 'created')
                      Row(
                        children: [
                          const Icon(
                            Icons.hourglass_bottom,
                            color: Colors.orange,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Request pending',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

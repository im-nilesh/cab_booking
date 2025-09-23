// lib/components/drivers/driver_ride_card.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DriverRideCard extends StatelessWidget {
  final Map<String, dynamic> rideData;

  const DriverRideCard({Key? key, required this.rideData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime rideDateTime = rideData['dateTime'].toDate();
    final String formattedTime = DateFormat('HH:mm').format(rideDateTime);
    final String formattedDate = DateFormat('dd MMM').format(rideDateTime);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 2,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.timer_outlined, color: Colors.black),
                const SizedBox(width: 8.0),
                Text(
                  "02 hour : 30 min", // This is a placeholder
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedDate,
                      style: GoogleFonts.outfit(
                        color: Colors.grey.shade600,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      formattedTime,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.circle_outlined,
                          size: 16,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          rideData['origin'] ?? 'Origin',
                          style: GoogleFonts.outfit(fontSize: 16.0),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.0),
                      child: SizedBox(
                        height: 12.0,
                        child: VerticalDivider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.circle, size: 16, color: Colors.green),
                        const SizedBox(width: 8.0),
                        Text(
                          rideData['destination'] ?? 'Destination',
                          style: GoogleFonts.outfit(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  "Seat full",
                  style: GoogleFonts.outfit(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "View in detail >",
              style: GoogleFonts.outfit(color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }
}

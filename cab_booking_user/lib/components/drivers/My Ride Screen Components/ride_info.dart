import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RideInfoSection extends StatelessWidget {
  final Map<String, dynamic> rideData;

  const RideInfoSection({Key? key, required this.rideData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime rideDateTime = rideData['dateTime'].toDate();
    final String formattedTime = DateFormat('HH:mm').format(rideDateTime);
    final String formattedDate = DateFormat('dd MMM').format(rideDateTime);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Date + Time
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formattedDate,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formattedTime,
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            /// Origin → Destination with dotted line
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.circle_outlined,
                      color: greencolor,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      rideData['origin'] ?? 'Origin',
                      style: GoogleFonts.outfit(fontSize: 16),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  height: 18,
                  width: 1,
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: greencolor,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        children: List.generate(
                          6,
                          (index) => Expanded(
                            child: Container(
                              color:
                                  index % 2 == 0
                                      ? Colors.transparent
                                      : greencolor,
                              width: 1,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.circle, color: greencolor, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      rideData['destination'] ?? 'Destination',
                      style: GoogleFonts.outfit(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),

            /// Seats Left
            Text(
              "${rideData['seatsLeft']} seats left",
              style: GoogleFonts.outfit(
                color: greencolor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

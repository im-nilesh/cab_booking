import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cab_booking_admin/widgets/approval_buttons.dart';

class RideCard extends StatelessWidget {
  final Map<String, dynamic> rideData;

  const RideCard({Key? key, required this.rideData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carDetails = rideData['carDetails'] as Map<String, dynamic>? ?? {};
    final dateTime = (rideData['dateTime'] as Timestamp).toDate();
    final formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);
    final formattedTime = DateFormat('hh:mm a').format(dateTime);
    final status = rideData['payment_status'] as String? ?? '';

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  carDetails['image'] ?? 'assets/images/sedan.png',
                  height: 40,
                  width: 80,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      carDetails['name'] ?? 'N/A',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Advance: ₹ ${rideData['advancePrice'] ?? 0}',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  '₹ ${carDetails['price'] ?? 0}',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 30, thickness: 1),
            _buildDetailRow(
              Icons.trip_origin,
              "From",
              rideData['origin'] ?? 'N/A',
            ),
            _buildDetailRow(
              Icons.location_on,
              "To",
              rideData['destination'] ?? 'N/A',
            ),
            _buildDetailRow(Icons.calendar_today, "Date", formattedDate),
            _buildDetailRow(Icons.access_time, "Time", formattedTime),
            _buildDetailRow(
              Icons.person,
              "User ID",
              rideData['userId'] ?? 'N/A',
            ),
            const SizedBox(height: 10),
            if (status == 'success')
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [ApprovalButtons(onApprove: () {}, onReject: () {})],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade700),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: GoogleFonts.outfit(fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.outfit(color: Colors.grey.shade800),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

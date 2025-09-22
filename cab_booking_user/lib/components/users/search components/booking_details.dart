import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';

class BookingDetailsDialog extends StatelessWidget {
  final String origin;
  final String destination;
  final DateTime dateTime;
  final Map<String, dynamic> carDetails;

  const BookingDetailsDialog({
    Key? key,
    required this.origin,
    required this.destination,
    required this.dateTime,
    required this.carDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);
    final formattedTime = DateFormat('hh:mm a').format(dateTime);
    final carName = carDetails['name'];
    final carPrice = carDetails['price'];
    final carImage = carDetails['image'];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Confirm Your Ride',
            style: GoogleFonts.outfit(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildDetailRow(Icons.calendar_today_outlined, 'Date', formattedDate),
          _buildDetailRow(Icons.access_time_outlined, 'Time', formattedTime),
          _buildDetailRow(Icons.trip_origin_outlined, 'From', origin),
          _buildDetailRow(Icons.location_on_outlined, 'To', destination),
          const Divider(height: 30, thickness: 1),
          Row(
            children: [
              Image.asset(carImage, height: 40, width: 80, fit: BoxFit.contain),
              const SizedBox(width: 16),
              Text(
                carName,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '₹ $carPrice',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: PrimaryButton(
              text: 'Proceed to Book',
              onPressed: () {
                // TODO: Implement booking and payment logic here
                Navigator.pop(context); // Close the dialog
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 15),
          Text(
            '$label: ',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.outfit(
                fontSize: 15,
                color: Colors.grey.shade800,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

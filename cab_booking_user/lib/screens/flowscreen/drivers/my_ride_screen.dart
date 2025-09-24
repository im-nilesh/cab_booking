// lib/screens/drivers/ride_details_screen.dart
import 'package:cab_booking_user/components/drivers/My%20Ride%20Screen%20Components/message_to_passenger.dart';
import 'package:cab_booking_user/components/drivers/My%20Ride%20Screen%20Components/ride_info.dart';
import 'package:cab_booking_user/components/drivers/My%20Ride%20Screen%20Components/ride_request_section.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RideDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> rideData;

  const RideDetailsScreen({Key? key, required this.rideData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greencolor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My ride details",
          style: GoogleFonts.outfit(color: Colors.white, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RideInfoSection(rideData: rideData),
            const SizedBox(height: 12),
            RideRequestsSection(rideData: rideData),
            const SizedBox(height: 12),
            MessageToPassengers(message: rideData['message'] ?? ""),
          ],
        ),
      ),
    );
  }
}

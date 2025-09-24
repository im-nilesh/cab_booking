import 'package:cab_booking_user/Widgets/app%20bar/custom_appbar.dart';
import 'package:cab_booking_user/components/drivers/My%20Ride%20Screen%20Components/message_to_passenger.dart';
import 'package:cab_booking_user/components/drivers/My%20Ride%20Screen%20Components/ride_info.dart';
import 'package:flutter/material.dart';

class RideDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> rideData;

  const RideDetailsScreen({Key? key, required this.rideData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final message = rideData['message'] ?? "";

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background
      appBar: const CustomAppBar(title: 'My ride details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RideInfoSection(rideData: rideData),
            const SizedBox(height: 24),
            MessageToPassengers(message: message),
          ],
        ),
      ),
    );
  }
}

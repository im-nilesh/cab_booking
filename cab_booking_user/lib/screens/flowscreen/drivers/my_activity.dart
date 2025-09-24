import 'package:cab_booking_user/components/drivers/My%20Activity%20Components/past_ride_card.dart';
import 'package:cab_booking_user/components/drivers/My%20Activity%20Components/summary_card.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyActivityScreen extends StatelessWidget {
  const MyActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data for past rides
    final List<Map<String, dynamic>> pastRides = [
      {
        'date': '25 Mar',
        'time': '09:30',
        'origin': 'Kanpur',
        'destination': 'Delhi',
        'earned': 5000,
        'passengers': 5,
      },
      {
        'date': '25 Mar',
        'time': '09:30',
        'origin': 'Kanpur',
        'destination': 'Delhi',
        'earned': 3000,
        'passengers': 5,
      },
      {
        'date': '25 Mar',
        'time': '09:30',
        'origin': 'Kanpur',
        'destination': 'Delhi',
        'earned': 3000,
        'passengers': 5,
      },
      {
        'date': '25 Mar',
        'time': '09:30',
        'origin': 'Kanpur',
        'destination': 'Delhi',
        'earned': 5000,
        'passengers': 5,
      },
    ];

    // Calculate total earnings from dummy data
    final double totalEarnings = pastRides.fold(
      0,
      (sum, item) => sum + (item['earned'] as num),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('My Activity'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade800,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  SummaryCard(
                    title: 'Total rides',
                    value: pastRides.length.toString(),
                  ),
                  const SizedBox(width: 16),
                  SummaryCard(
                    title: 'Total earnings',
                    value: '₹${totalEarnings.toStringAsFixed(0)}',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My past rides',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: pastRides.length,
                itemBuilder: (context, index) {
                  return PastRideCard(rideData: pastRides[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

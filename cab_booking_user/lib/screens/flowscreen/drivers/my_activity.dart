import 'package:cab_booking_user/components/drivers/My%20Activity%20Components/past_ride_card.dart';
import 'package:cab_booking_user/components/drivers/My%20Activity%20Components/summary_card.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyActivityScreen extends StatelessWidget {
  const MyActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data
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
        'date': '26 Mar',
        'time': '10:00',
        'origin': 'Kanpur',
        'destination': 'Lucknow',
        'earned': 3000,
        'passengers': 4,
      },
      {
        'date': '27 Mar',
        'time': '12:15',
        'origin': 'Kanpur',
        'destination': 'Agra',
        'earned': 4500,
        'passengers': 3,
      },
    ];

    final double totalEarnings = pastRides.fold(
      0,
      (sum, item) => sum + (item['earned'] as num),
    );

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            Text(
              'My Activity',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 16),

            // Green summary box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade800,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      title: 'Total rides',
                      value: pastRides.length.toString(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SummaryCard(
                      title: 'Total earnings',
                      value: '₹${totalEarnings.toStringAsFixed(0)}',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Past rides title + filter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My past rides',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list, color: Colors.black54),
                  label: const Text(
                    'Filter',
                    style: TextStyle(color: Colors.black54),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Past rides list
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

import 'package:cab_booking_user/Widgets/app%20bar/custom_appbar.dart';
import 'package:cab_booking_user/components/drivers/Vehical%20Screen%20Edit%20Components/car_name_card.dart';
import 'package:cab_booking_user/components/drivers/Vehical%20Screen%20Edit%20Components/car_number_card.dart';
import 'package:cab_booking_user/components/drivers/Vehical%20Screen%20Edit%20Components/document_card.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';

class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "My vehicle details",
        onBackPress: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car name
            const CarNameCard(),
            const SizedBox(height: 24),

            // Car number
            const CarNumberCard(),
            const SizedBox(height: 24),

            // Section title
            const Text(
              'My car documents & image',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF237642), // green like your screenshot
              ),
            ),
            const SizedBox(height: 16),

            // Documents
            DocumentCard(
              title: 'Driving License',
              imagePath: 'assets/images/drivinglicense.png',
              onEdit: () {},
            ),
            const SizedBox(height: 16),
            DocumentCard(
              title: 'Image of vehicle\'s number plate',
              imagePath: 'assets/images/Frame34845.png',
              onEdit: () {},
            ),
            const SizedBox(height: 16),
            DocumentCard(
              title: 'Image of RC',
              imagePath: 'assets/images/drivinglicense.png',
              onEdit: () {},
            ),
          ],
        ),
      ),
    );
  }
}

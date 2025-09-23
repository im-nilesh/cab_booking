// lib/screens/flowscreen/users/my_rides_screen.dart
import 'package:cab_booking_user/components/users/booked%20ride%20component/booked_ride_home_details_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyRidesScreen extends StatelessWidget {
  const MyRidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(top: 0), // ✅ no gap
          child: Text("Please log in to see your rides."),
        ),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance
              .collection('rides')
              .where('userId', isEqualTo: currentUser.uid)
              .where('payment_status', isEqualTo: 'success') // fixed
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No successful rides booked yet.');
        }

        final rides = snapshot.data!.docs;

        // Sort by dateTime (latest first)
        rides.sort((a, b) {
          final aDateTime = (a['dateTime'] as Timestamp).toDate();
          final bDateTime = (b['dateTime'] as Timestamp).toDate();
          return bDateTime.compareTo(aDateTime);
        });

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: rides.length,
          itemBuilder: (context, index) {
            final ride = rides[index].data() as Map<String, dynamic>;
            return BookedRideDetailsCard(rideData: ride);
          },
        );
      },
    );
  }
}

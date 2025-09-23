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
      return const Center(child: Text("Please log in to see your rides."));
    }

    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance
              .collection('rides')
              .where('userId', isEqualTo: currentUser.uid)
              .where(
                'status',
                isEqualTo: 'success',
              ) // Added this line to filter by status
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No successful rides booked yet.'));
        }

        final rides = snapshot.data!.docs;

        return ListView.builder(
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

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
              .where('status', isEqualTo: 'success')
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 0),
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasError) {
          return Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 0),
              child: Text('No successful rides booked yet.'),
            ),
          );
        }

        final rides = snapshot.data!.docs;

        // Sort the rides by dateTime in descending order (latest to oldest)
        rides.sort((a, b) {
          final aData = a.data() as Map<String, dynamic>;
          final bData = b.data() as Map<String, dynamic>;
          final aDateTime = (aData['dateTime'] as Timestamp).toDate();
          final bDateTime = (bData['dateTime'] as Timestamp).toDate();
          return bDateTime.compareTo(aDateTime);
        });

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero, // ✅ removes default ListView padding
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

import 'package:cab_booking_user/components/drivers/Home Screen Components/driver_ride_card.dart';
import 'package:cab_booking_user/providers/driver_rides_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Home'), centerTitle: true),
        body: const Center(child: Text('Please log in to see your rides.')),
      );
    }

    final driverRidesAsyncValue = ref.watch(driverRidesProvider(user.uid));

    return Scaffold(
      appBar: AppBar(title: const Text('My Assigned Rides'), centerTitle: true),
      body: driverRidesAsyncValue.when(
        data: (driverRideDocs) {
          if (driverRideDocs.isEmpty) {
            return const Center(child: Text('No rides assigned to you yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: driverRideDocs.length,
            itemBuilder: (context, index) {
              final rideId = driverRideDocs[index]['rideId'];
              final rideDetailsAsyncValue = ref.watch(
                rideDetailsProvider(rideId),
              );

              return rideDetailsAsyncValue.when(
                data: (rideDoc) {
                  if (!rideDoc.exists) {
                    return const Card(
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(title: Text('Ride details not found.')),
                    );
                  }

                  final rideData = rideDoc.data() as Map<String, dynamic>;

                  // Ensure dateTime is valid
                  if (rideData['dateTime'] == null) {
                    rideData['dateTime'] = Timestamp.now();
                  }

                  // Ensure origin/destination exist
                  rideData['origin'] ??= 'Origin';
                  rideData['destination'] ??= 'Destination';

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DriverRideCard(rideData: rideData),
                  );
                },
                loading:
                    () => const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                error:
                    (error, stack) => Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('Error loading ride: $error'),
                      ),
                    ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stack) => Center(child: Text('An error occurred: $error')),
      ),
    );
  }
}

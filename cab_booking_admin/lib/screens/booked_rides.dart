import 'package:cab_booking_admin/components/ride_card.dart';
import 'package:cab_booking_admin/provider/ride_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookedRidesScreen extends ConsumerWidget {
  const BookedRidesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookedRidesAsync = ref.watch(bookedRidesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booked Rides'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: bookedRidesAsync.when(
        data: (rides) {
          if (rides.isEmpty) {
            return const Center(child: Text('No booked rides found.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: rides.length,
            itemBuilder: (context, index) {
              final ride = rides[index];
              return RideCard(
                rideData: ride.data() as Map<String, dynamic>,
                rideId: ride.id,
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stackTrace) =>
                Center(child: Text('Error loading booked rides: $error')),
      ),
    );
  }
}

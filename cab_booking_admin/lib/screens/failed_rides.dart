import 'package:cab_booking_admin/components/ride_card.dart';
import 'package:cab_booking_admin/provider/ride_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FailedRidesScreen extends ConsumerWidget {
  const FailedRidesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final failedRidesAsync = ref.watch(failedRidesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Failed Rides'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: failedRidesAsync.when(
        data: (rides) {
          if (rides.isEmpty) {
            return const Center(child: Text('No failed rides found.'));
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
                Center(child: Text('Error loading failed rides: $error')),
      ),
    );
  }
}

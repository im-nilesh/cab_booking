import 'package:cab_booking_admin/provider/ride_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cab_booking_admin/provider/driver_provider.dart';

class DriverConfirmationDialog extends ConsumerWidget {
  final String rideId;
  final String driverUid;
  final String driverName;

  const DriverConfirmationDialog({
    super.key,
    required this.rideId,
    required this.driverUid,
    required this.driverName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text("Confirm Assignment"),
      content: Text("Do you want to assign this ride to $driverName?"),
      actions: <Widget>[
        TextButton(
          child: Text("No", style: TextStyle(color: Colors.grey[800])),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Yes, Assign",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            try {
              await ref
                  .read(driverAssignmentProvider)
                  .assignDriver(
                    rideId: rideId,
                    driverUid: driverUid,
                    driverName: driverName,
                  );

              Navigator.of(context).pop(); // close confirmation
              Navigator.of(context).pop(); // close driver list

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Driver assigned successfully!")),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error assigning driver: $e")),
              );
            }
          },
        ),
      ],
    );
  }
}

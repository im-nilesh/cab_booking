import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RideRequestsSection extends StatelessWidget {
  final Map<String, dynamic> rideData;

  const RideRequestsSection({Key? key, required this.rideData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final requests = rideData['requests'] ?? [];

    return requests.isEmpty
        ? Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              "No ride requests yet",
              style: GoogleFonts.outfit(color: Colors.grey.shade600),
            ),
          ),
        )
        : Column(
          children:
              requests.map<Widget>((req) {
                return Card(
                  child: ListTile(
                    title: Text(req['name'] ?? 'Unknown'),
                    subtitle: Text(req['pickup'] ?? 'Pickup location'),
                    trailing: Text(req['status'] ?? 'Pending'),
                  ),
                );
              }).toList(),
        );
  }
}

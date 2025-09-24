import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RideRequestsSection extends StatelessWidget {
  final Map<String, dynamic> rideData;

  const RideRequestsSection({Key? key, required this.rideData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final requests = rideData['requests'] as List<dynamic>? ?? [];

    if (requests.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Center(
          child: Text(
            "No ride requests yet",
            style: GoogleFonts.outfit(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    // This part is for when there are requests.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ride Requests",
          style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ...requests.map<Widget>((req) {
          final requestData = req as Map<String, dynamic>;
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(requestData['name'] ?? 'Unknown Passenger'),
            subtitle: Text(
              requestData['pickup'] ?? 'Pickup location not specified',
            ),
            trailing: Text(
              requestData['status'] ?? 'Pending',
              style: const TextStyle(color: Colors.orange),
            ),
          );
        }).toList(),
      ],
    );
  }
}

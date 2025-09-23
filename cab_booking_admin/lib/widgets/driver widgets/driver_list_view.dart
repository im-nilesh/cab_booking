import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverListView extends StatelessWidget {
  final void Function(String driverUid, String driverName) onDriverTap;

  const DriverListView({super.key, required this.onDriverTap});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance
              .collection('drivers')
              .where('registration_status', isEqualTo: 'approved')
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "No approved drivers available.",
              style: TextStyle(color: Colors.grey[600]),
            ),
          );
        }
        final drivers = snapshot.data!.docs;

        return ListView.builder(
          shrinkWrap: true,
          itemCount: drivers.length,
          itemBuilder: (context, index) {
            final doc = drivers[index];
            final driver = doc.data() as Map<String, dynamic>;
            final driverUid = doc.id;
            final driverName =
                '${driver['firstName'] ?? ''} ${driver['lastName'] ?? ''}'
                    .trim();
            final phoneNumber = driver['phone_number'] ?? 'No phone number';

            return Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(
                    context,
                  ).primaryColor.withOpacity(0.1),
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                title: Text(
                  driverName,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(phoneNumber),
                onTap: () => onDriverTap(driverUid, driverName),
              ),
            );
          },
        );
      },
    );
  }
}

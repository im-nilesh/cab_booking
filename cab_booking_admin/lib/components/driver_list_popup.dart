import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverListPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Available Drivers'),
      content: Container(
        width: double.maxFinite,
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance
                  .collection('drivers')
                  .where('registration_status', isEqualTo: 'approved')
                  .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final drivers = snapshot.data!.docs;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: drivers.length,
              itemBuilder: (context, index) {
                final driver = drivers[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text('${driver['firstName']} ${driver['lastName']}'),
                  subtitle: Text(driver['phone_number']),
                );
              },
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class DriverConfirmationDialog extends StatelessWidget {
  final String driverName;

  const DriverConfirmationDialog({super.key, required this.driverName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text("Confirm Assignment"),
      content: Text("Do you want to assign this ride to $driverName?"),
      actions: <Widget>[
        TextButton(
          child: Text("No", style: TextStyle(color: Colors.grey[800])),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text("Yes, Assign", style: TextStyle(color: Colors.white)),
          onPressed: () {
            // Add your assignment logic here
            print('Assigned to $driverName');
            Navigator.of(context).pop(); // Close confirmation dialog
            Navigator.of(context).pop(); // Close driver list dialog
          },
        ),
      ],
    );
  }
}

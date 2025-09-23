import 'package:cab_booking_admin/widgets/driver%20widgets/driver_confirmation_dialog.dart';
import 'package:cab_booking_admin/widgets/driver%20widgets/driver_list_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverListPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  Widget _buildChild(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _DriverPopupHeader(),
          Divider(height: 30),
          Container(
            width: double.maxFinite,
            height: 350,
            child: DriverListView(
              onDriverTap: (driverName) {
                _showConfirmationDialog(context, driverName);
              },
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String driverName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DriverConfirmationDialog(driverName: driverName);
      },
    );
  }
}

class _DriverPopupHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.people_alt_outlined,
          color: Theme.of(context).primaryColor,
          size: 28,
        ),
        SizedBox(width: 10),
        Text(
          'Assign Driver',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
}

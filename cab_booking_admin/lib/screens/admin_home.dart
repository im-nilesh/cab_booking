import 'package:flutter/material.dart';
import 'package:cab_booking_admin/widgets/custom_admin_sidebar.dart';
import 'package:cab_booking_admin/screens/users.dart';
import 'package:cab_booking_admin/screens/drivers.dart';
import 'package:cab_booking_admin/screens/location.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int selectedIndex = 0;

  final List<Widget> _pages = [
    UsersPage(), // 0: Users
    DriversPage(), // 1: Drivers
    Center(child: Text("Booked Rides Page")), // 2: Booked Rides
    Center(child: Text("Failed Rides Page")), // 3: Failed Rides
    Center(child: Text("Pooled Users Page")), // 4: Pooled Users
    Center(child: Text("Pooling Rides Page")), // 5: Pooling Rides
    LocationScreen(), // 6: Locations
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AdminSidebar(
            selectedIndex: selectedIndex,
            onItemSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          Expanded(child: _pages[selectedIndex]),
        ],
      ),
    );
  }
}

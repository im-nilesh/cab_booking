import 'package:cab_booking_user/Widgets/button/custom_nav_item.dart';
import 'package:cab_booking_user/screens/flowscreen/drivers/create_ride.dart';
import 'package:cab_booking_user/screens/flowscreen/drivers/home.dart';
import 'package:cab_booking_user/screens/flowscreen/drivers/my_activity.dart';
import 'package:cab_booking_user/screens/flowscreen/drivers/my_profile.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';

class DriverNavigation extends StatefulWidget {
  const DriverNavigation({super.key});

  @override
  State<DriverNavigation> createState() => _DriverNavigationState();
}

class _DriverNavigationState extends State<DriverNavigation> {
  int _selectedIndex = 0;

  // List of screens to be displayed for each tab
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MyActivityScreen(),
    CreateRide(),
    MyProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        height: 80, // Adjust height as needed
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -3), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomNavItem(
              index: 0,
              selectedIndex: _selectedIndex,
              inactiveIconPath:
                  'assets/images/svg/Vector.svg', // Placeholder path
              activeIconPath:
                  'assets/images/svg/Vector-selected.svg', // Placeholder path
              label: 'Home',
              onTap: () => _onItemTapped(0),
              selectedColor: greencolor,
              unselectedColor: Colors.grey.shade500,
            ),
            CustomNavItem(
              index: 2,
              selectedIndex: _selectedIndex,
              inactiveIconPath: '', // Placeholder path
              activeIconPath:
                  'assets/images/svg/createrideselected.svg', // Placeholder path
              label: 'Create Ride',
              onTap: () => _onItemTapped(2),
              selectedColor: greencolor,
              unselectedColor: Colors.grey.shade500,
            ),
            CustomNavItem(
              index: 1,
              selectedIndex: _selectedIndex,
              inactiveIconPath:
                  'assets/images/svg/myactivityunselected.svg', // Placeholder path
              activeIconPath:
                  'assets/icons/activity_active.svg', // Placeholder path
              label: 'Activity',
              onTap: () => _onItemTapped(1),
              selectedColor: greencolor,
              unselectedColor: Colors.grey.shade500,
            ),
            CustomNavItem(
              index: 3,
              selectedIndex: _selectedIndex,
              inactiveIconPath:
                  'assets/images/svg/profile-circle.svg', // Placeholder path
              activeIconPath:
                  'assets/images/svg/profile-circle.svg', // Placeholder path
              label: 'Profile',
              onTap: () => _onItemTapped(3),
              selectedColor: greencolor,
              unselectedColor: Colors.grey.shade500,
            ),
          ],
        ),
      ),
    );
  }
}

// Example Theme file (lib/theme/theme.dart)
class AppTheme {
  static const Color primaryColor = Color(0xFF007BFF); // Example blue color
}

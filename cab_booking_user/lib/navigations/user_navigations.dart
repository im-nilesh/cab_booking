// lib/screens/flowscreen/users/user_navigation.dart

import 'package:cab_booking_user/Widgets/button/custom_nav_item.dart';
import 'package:cab_booking_user/screens/flowscreen/users/user_homepage.dart';
import 'package:cab_booking_user/screens/flowscreen/users/user_profilepage.dart';
import 'package:cab_booking_user/screens/flowscreen/users/user_searchpage.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';

class UserNavigation extends StatefulWidget {
  const UserNavigation({super.key});

  @override
  State<UserNavigation> createState() => _UserNavigationState();
}

class _UserNavigationState extends State<UserNavigation> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    ProfilePage(),
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
        height: 80,
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomNavItem(
              index: 0,
              selectedIndex: _selectedIndex,
              inactiveIconPath: 'assets/images/svg/Vector.svg',
              activeIconPath: 'assets/images/svg/Vector-selected.svg',
              label: 'Home',
              onTap: () => _onItemTapped(0),
              selectedColor: greencolor,
              unselectedColor: grayColor2,
            ),
            CustomNavItem(
              index: 1,
              selectedIndex: _selectedIndex,
              inactiveIconPath: 'assets/images/svg/majesticons_search-line.svg',
              activeIconPath: 'assets/images/svg/search selected.svg',
              label: 'Search',
              onTap: () => _onItemTapped(1),
              selectedColor: greencolor,
              unselectedColor: grayColor2,
            ),
            CustomNavItem(
              index: 2,
              selectedIndex: _selectedIndex,
              inactiveIconPath: 'assets/images/svg/profile-circle.svg',
              activeIconPath:
                  'assets/images/svg/profile-circle.svg', // Same icon for active state
              label: 'Profile',
              onTap: () => _onItemTapped(2),
              selectedColor: greencolor,
              unselectedColor: grayColor2,
            ),
          ],
        ),
      ),
    );
  }
}

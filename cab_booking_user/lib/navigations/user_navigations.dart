import 'package:cab_booking_user/screens/flowscreen/users/user_homepage.dart';
import 'package:cab_booking_user/screens/flowscreen/users/user_profilepage.dart';
import 'package:cab_booking_user/screens/flowscreen/users/user_searchpage.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
            _buildNavItem(
              index: 0,
              inactiveIconPath: 'assets/images/svg/Vector.svg',
              activeIconPath: 'assets/images/svg/Vector-selected.svg',
              label: 'Home',
            ),
            _buildNavItem(
              index: 1,
              inactiveIconPath: 'assets/images/svg/majesticons_search-line.svg',
              activeIconPath: 'assets/images/svg/search selected.svg',
              label: 'Search',
            ),
            _buildNavItem(
              index: 2,
              inactiveIconPath: 'assets/images/svg/profile-circle.svg',
              activeIconPath:
                  'assets/images/svg/profile-circle.svg', // Using the same icon for active state
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String inactiveIconPath,
    required String activeIconPath,
    required String label,
  }) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              isSelected ? activeIconPath : inactiveIconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isSelected ? greencolor : grayColor2,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12,
                color: isSelected ? greencolor : grayColor2,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

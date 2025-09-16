import 'package:cab_booking_user/screens/flowscreen/users/user_homepage.dart';
import 'package:cab_booking_user/screens/flowscreen/users/user_profilepage.dart';
import 'package:cab_booking_user/screens/flowscreen/users/user_searchpage.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg

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
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/home.svg',
              colorFilter: ColorFilter.mode(grayColor2, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/home.svg',
              colorFilter: ColorFilter.mode(greencolor, BlendMode.srcIn),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/search.svg',
              colorFilter: ColorFilter.mode(grayColor2, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/search.svg',
              colorFilter: ColorFilter.mode(greencolor, BlendMode.srcIn),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/profile.svg',
              colorFilter: ColorFilter.mode(grayColor2, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/profile.svg',
              colorFilter: ColorFilter.mode(greencolor, BlendMode.srcIn),
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: greencolor,
        unselectedItemColor: grayColor2,
        onTap: _onItemTapped,
      ),
    );
  }
}

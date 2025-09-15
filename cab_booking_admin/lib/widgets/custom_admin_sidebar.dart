import 'package:cab_booking_admin/utils/constants.dart';
import 'package:flutter/material.dart';

class AdminSidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const AdminSidebar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: greencolor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          // ✅ eTaxxi Admin Panel header at top
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Text(
              "eTaxxi Admin Panel",
              style: TextStyle(
                color: whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),

          const Divider(color: Colors.white24, height: 1),

          // ✅ Menu items (no extra section headers)
          _buildMenuItem(Icons.person, "Users", 0),
          _buildMenuItem(Icons.drive_eta, "Drivers", 1),
          _buildExpansionMenu(context),
          _buildMenuItem(Icons.group, "Pooled Users", 4),
          _buildMenuItem(Icons.local_taxi, "Pooling Rides", 5),
          _buildMenuItem(Icons.location_on, "Locations", 6),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, int index) {
    final bool isActive = selectedIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Material(
        color: isActive ? whiteColor.withOpacity(0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => onItemSelected(index),
          child: SizedBox(
            height: 52,
            child: Row(
              children: [
                const SizedBox(width: 12),
                Icon(
                  icon,
                  size: 22,
                  color: isActive ? whiteColor : whiteColor.withOpacity(0.9),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color:
                          isActive ? whiteColor : whiteColor.withOpacity(0.92),
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubMenuItem(String title, int index) {
    final bool isActive = selectedIndex == index;

    return Padding(
      padding: const EdgeInsets.only(left: 44, right: 10, top: 4, bottom: 4),
      child: Material(
        color: isActive ? whiteColor.withOpacity(0.10) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => onItemSelected(index),
          child: SizedBox(
            height: 42,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                  color: isActive ? whiteColor : whiteColor.withOpacity(0.88),
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpansionMenu(BuildContext context) {
    final bool childActive = selectedIndex == 2 || selectedIndex == 3;

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Icon(
          Icons.directions_car,
          color: childActive ? whiteColor : whiteColor.withOpacity(0.9),
        ),
        title: Text(
          "User Rides",
          style: TextStyle(
            color: childActive ? whiteColor : whiteColor.withOpacity(0.92),
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        iconColor: whiteColor,
        collapsedIconColor: whiteColor.withOpacity(0.9),
        childrenPadding: EdgeInsets.zero,
        children: [
          _buildSubMenuItem("Booked Rides", 2),
          _buildSubMenuItem("Failed Rides", 3),
        ],
      ),
    );
  }
}

// lib/widgets/custom_nav_item.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomNavItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String inactiveIconPath;
  final String activeIconPath;
  final String label;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;

  const CustomNavItem({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.inactiveIconPath,
    required this.activeIconPath,
    required this.label,
    required this.onTap,
    required this.selectedColor,
    required this.unselectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              isSelected ? activeIconPath : inactiveIconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isSelected ? selectedColor : unselectedColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12,
                color: isSelected ? selectedColor : unselectedColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

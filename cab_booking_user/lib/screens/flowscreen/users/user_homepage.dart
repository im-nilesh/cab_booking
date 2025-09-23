// lib/screens/flowscreen/users/user_homepage.dart
import 'package:cab_booking_user/components/users/booked%20ride%20component/my_rides.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
              decoration: const BoxDecoration(
                color: greencolor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text("Logo"),
                      ),
                      const Icon(
                        Icons.notifications,
                        color: whiteColor,
                        size: 30,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Where to?',
                      hintStyle: GoogleFonts.outfit(color: Colors.black54),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [Text("Now"), Icon(Icons.arrow_drop_down)],
                        ),
                      ),
                      filled: true,
                      fillColor: whiteColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My rides",
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height *
                        0.5, // Adjust height as needed
                    child: const MyRidesScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

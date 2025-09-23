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
      body: CustomScrollView(
        slivers: [
          // App bar section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 24),
              decoration: const BoxDecoration(
                color: greencolor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row with logo + notifications
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "Logo",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: const Icon(
                          Icons.notifications,
                          color: whiteColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Search field
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Where to?',
                      hintStyle: GoogleFonts.outfit(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Now"),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                      filled: true,
                      fillColor: whiteColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // "My Rides" title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                0,
              ), // removed bottom padding
              child: Text(
                "My rides",
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Rides list (directly below title, no gap)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                16,
              ), // tighter spacing
              child: const MyRidesScreen(),
            ),
          ),
        ],
      ),
    );
  }
}

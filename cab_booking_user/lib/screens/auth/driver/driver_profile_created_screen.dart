import 'package:cab_booking_user/screens/auth/driver/driver_vehical_registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';
import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar.dart';
import 'package:cab_booking_user/Widgets/info_box/info_dialog.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:cab_booking_user/providers/driver_registration_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class DriverProfileCreatedScreen extends ConsumerStatefulWidget {
  const DriverProfileCreatedScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DriverProfileCreatedScreen> createState() =>
      _DriverProfileCreatedScreenState();
}

class _DriverProfileCreatedScreenState
    extends ConsumerState<DriverProfileCreatedScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(driverRegistrationProvider).fetchProfileImage(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(driverRegistrationProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: blackColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomProgressBar(
              currentStep: 1,
              totalSteps: 2,
              label: 'Basic Information',
            ),
            const SizedBox(height: 150),
            CircleAvatar(
              radius: 130,
              backgroundColor: avatarborderColor,
              child: CircleAvatar(
                radius: 123,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 115,
                  backgroundImage:
                      provider.imageUrl != null
                          ? NetworkImage(provider.imageUrl!)
                          : const AssetImage('assets/images/placeholder.png')
                              as ImageProvider,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Your profile is created!',
              style: GoogleFonts.outfit(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: dialogBackgroundColor, // Background color
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
                // Border styling
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'To host a ride, you must register your vehicle on this platform.',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: dialogTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      'All it takes is 3 easy steps!',
                      style: TextStyle(
                        fontSize: 12,
                        color: dialogTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: PrimaryButton(
                    text: 'Start',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  const DriverVehicleRegistrationScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

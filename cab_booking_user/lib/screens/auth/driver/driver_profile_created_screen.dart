import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';
import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar.dart';
import 'package:cab_booking_user/Widgets/info_box/info_dialog.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:cab_booking_user/providers/driver_registration_provider.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const CustomProgressBar(
                currentStep: 1,
                totalSteps: 2,
                label: 'Basic Information',
              ),
              const SizedBox(height: 40),
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
              const Text(
                'Your profile is created!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const InfoDialog(
                text:
                    'To host a ride, you must register your vehicle on this platform.\nAll it takes is 3 easy steps!',
              ),
              const Spacer(),
              PrimaryButton(
                text: 'Start',
                onPressed: () {
                  // Navigate to the next screen
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

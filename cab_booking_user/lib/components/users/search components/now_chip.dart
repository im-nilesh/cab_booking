import 'package:flutter/material.dart';
import 'package:cab_booking_user/utils/constants.dart';

class NowButton extends StatelessWidget {
  const NowButton({super.key});

  Future<void> _pickDateTime(BuildContext context) async {
    // Step 1: pick date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: greencolor, // header + confirm btn
              onPrimary: whiteColor, // text on header
              onSurface: Colors.black, // body text
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: greencolor),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null) return;

    // Step 2: pick time
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: const TimePickerThemeData(
              dialHandColor: greencolor,
              hourMinuteTextColor: greencolor,
              dayPeriodColor: greencolor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime == null) return;

    // Step 3: combine into DateTime
    final selectedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    debugPrint("Selected DateTime: $selectedDateTime");
    // TODO: pass to state/provider if needed
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black.withOpacity(0.15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 0,
      ),
      onPressed: () => _pickDateTime(context),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Now', style: TextStyle(color: whiteColor, fontSize: 14)),
          SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down, color: whiteColor, size: 20),
        ],
      ),
    );
  }
}

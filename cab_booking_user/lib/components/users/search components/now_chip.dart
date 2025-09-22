import 'package:flutter/material.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:intl/intl.dart'; // for formatting date/time

class NowButton extends StatefulWidget {
  const NowButton({super.key});

  @override
  State<NowButton> createState() => _NowButtonState();
}

class _NowButtonState extends State<NowButton> {
  DateTime? selectedDateTime;

  Future<void> _pickDateTime(BuildContext context) async {
    // Step 1: pick date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: greencolor,
              onPrimary: whiteColor,
              onSurface: Colors.black,
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
      initialTime:
          selectedDateTime != null
              ? TimeOfDay(
                hour: selectedDateTime!.hour,
                minute: selectedDateTime!.minute,
              )
              : TimeOfDay.now(),
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
    final dateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      selectedDateTime = dateTime;
    });

    debugPrint("Selected DateTime: $selectedDateTime");
    // TODO: pass to state/provider if needed
  }

  @override
  Widget build(BuildContext context) {
    final displayText =
        selectedDateTime != null
            ? DateFormat('dd MMM, hh:mm a').format(selectedDateTime!)
            : 'Now';

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black.withOpacity(0.15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 0,
      ),
      onPressed: () => _pickDateTime(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            displayText,
            style: const TextStyle(color: whiteColor, fontSize: 14),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, color: whiteColor, size: 20),
        ],
      ),
    );
  }
}

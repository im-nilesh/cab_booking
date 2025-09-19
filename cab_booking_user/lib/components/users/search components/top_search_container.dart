import 'package:cab_booking_user/Widgets/textfield/custom_text_field_dynamic.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';

import 'now_chip.dart';
import 'location_connector.dart';

class TopSearchContainer extends StatelessWidget {
  final TextEditingController originController;
  final TextEditingController destinationController;
  final FocusNode originFocus;
  final FocusNode destinationFocus;
  final ValueChanged<String>? onOriginChanged;
  final ValueChanged<String>? onDestinationChanged; // ✅ new

  const TopSearchContainer({
    super.key,
    required this.originController,
    required this.destinationController,
    required this.originFocus,
    required this.destinationFocus,
    this.onOriginChanged,
    this.onDestinationChanged, // ✅ new
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Align(alignment: Alignment.topRight, child: NowButton()),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LocationConnector(
                isOriginFocused: originFocus.hasFocus,
                isDestinationFocused: destinationFocus.hasFocus,
              ),
              Expanded(
                child: Column(
                  children: [
                    CustomTextFieldDynamic(
                      controller: originController,
                      hintText: 'Enter origin',
                      focusNode: originFocus,
                      onChanged: onOriginChanged,
                    ),
                    const SizedBox(height: 12),
                    CustomTextFieldDynamic(
                      controller: destinationController,
                      hintText: 'Enter destination',
                      focusNode: destinationFocus,
                      onChanged: onDestinationChanged, // ✅ now dynamic
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

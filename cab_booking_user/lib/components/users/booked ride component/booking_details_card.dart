import 'package:cab_booking_user/Widgets/car/car_info.dart';
import 'package:cab_booking_user/Widgets/common/details_row.dart';
import 'package:cab_booking_user/providers/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';
import 'package:cab_booking_user/Widgets/button/success_button.dart';
import 'package:cab_booking_user/Widgets/button/failure_button.dart';

class BookingDetailsDialog extends ConsumerStatefulWidget {
  final String origin;
  final String destination;
  final DateTime dateTime;
  final Map<String, dynamic> carDetails;

  const BookingDetailsDialog({
    Key? key,
    required this.origin,
    required this.destination,
    required this.dateTime,
    required this.carDetails,
  }) : super(key: key);

  @override
  ConsumerState<BookingDetailsDialog> createState() =>
      _BookingDetailsDialogState();
}

class _BookingDetailsDialogState extends ConsumerState<BookingDetailsDialog> {
  bool _showStatusButtons = false;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMM, yyyy').format(widget.dateTime);
    final formattedTime = DateFormat('hh:mm a').format(widget.dateTime);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Confirm Your Ride',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          DetailRow(
            icon: Icons.calendar_today_outlined,
            label: 'Date',
            value: formattedDate,
          ),
          DetailRow(
            icon: Icons.access_time_outlined,
            label: 'Time',
            value: formattedTime,
          ),
          DetailRow(
            icon: Icons.trip_origin_outlined,
            label: 'From',
            value: widget.origin,
          ),
          DetailRow(
            icon: Icons.location_on_outlined,
            label: 'To',
            value: widget.destination,
          ),
          const Divider(height: 30, thickness: 1),
          CarInfoRow(
            carName: widget.carDetails['name'],
            carPrice: widget.carDetails['price'],
            advancePrice: widget.carDetails['advancePrice'] ?? 0,
            carImage: widget.carDetails['image'],
          ),
          const SizedBox(height: 30),
          if (!_showStatusButtons)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: PrimaryButton(
                text: 'Proceed to Book',
                onPressed: () {
                  setState(() {
                    _showStatusButtons = true;
                  });
                },
              ),
            ),
          if (_showStatusButtons)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 50,
                  child: SuccessButton(
                    text: 'Success',
                    onPressed: () async {
                      await ref
                          .read(bookingProvider)
                          .createRide(
                            origin: widget.origin,
                            destination: widget.destination,
                            dateTime: widget.dateTime,
                            carDetails: widget.carDetails,
                            status: 'success',
                          );
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 50,
                  child: FailureButton(
                    text: 'Failure',
                    onPressed: () async {
                      await ref
                          .read(bookingProvider)
                          .createRide(
                            origin: widget.origin,
                            destination: widget.destination,
                            dateTime: widget.dateTime,
                            carDetails: widget.carDetails,
                            status: 'failure',
                          );
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:cab_booking_user/Widgets/button/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _selectedCountryCode = '+91'; // Default country code
  String _selectedCountryFlag = '🇮🇳'; // Default country flag
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Enter your mobile number',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),

            // Country Picker and Phone Number Input
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: true,
                      onSelect: (Country country) {
                        setState(() {
                          _selectedCountryCode = '+${country.phoneCode}';
                          _selectedCountryFlag = country.flagEmoji;
                        });
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text(
                          _selectedCountryFlag,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_drop_down, color: Colors.black),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Your mobile number',
                      prefixText: '$_selectedCountryCode ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            // Continue Button
            CustomButton(
              text: 'Continue',
              onPressed: () {
                // Handle phone number submission
                final phoneNumber = _phoneController.text.trim();
                if (phoneNumber.isNotEmpty) {
                  // Proceed with the phone number
                  print('Phone Number: $_selectedCountryCode $phoneNumber');
                } else {
                  // Show error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter your mobile number')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

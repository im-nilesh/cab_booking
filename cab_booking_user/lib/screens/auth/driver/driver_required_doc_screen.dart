import 'package:flutter/material.dart';

class DriverRequiredDocScreen extends StatefulWidget {
  const DriverRequiredDocScreen({super.key});

  @override
  State<DriverRequiredDocScreen> createState() =>
      _DriverRequiredDocScreenState();
}

class _DriverRequiredDocScreenState extends State<DriverRequiredDocScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Required Documents',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please upload the following documents to complete your registration.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // List of required documents
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    title: const Text('Driver\'s License'),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    title: const Text('Vehicle Registration'),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    title: const Text('Insurance Document'),
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

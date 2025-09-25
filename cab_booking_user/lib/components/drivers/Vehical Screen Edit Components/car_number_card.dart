import 'package:flutter/material.dart';

class CarNumberCard extends StatelessWidget {
  const CarNumberCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'My car number',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            labelText: 'DL21M2431',
            border: const OutlineInputBorder(),
            suffixIcon: TextButton(onPressed: () {}, child: const Text('Edit')),
          ),
        ),
      ],
    );
  }
}

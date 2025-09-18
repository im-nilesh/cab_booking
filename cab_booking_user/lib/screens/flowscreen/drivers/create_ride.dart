import 'package:flutter/material.dart';

class CreateRide extends StatelessWidget {
  const CreateRide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Rides'), centerTitle: true),
      body: const Center(
        child: Text('My Rides Screen', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

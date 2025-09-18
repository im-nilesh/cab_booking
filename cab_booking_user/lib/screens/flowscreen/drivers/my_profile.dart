import 'package:flutter/material.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile'), centerTitle: true),
      body: const Center(
        child: Text('My Profile Screen', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

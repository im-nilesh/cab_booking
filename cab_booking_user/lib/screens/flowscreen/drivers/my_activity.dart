import 'package:flutter/material.dart';

class MyActivityScreen extends StatelessWidget {
  const MyActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Activity'), centerTitle: true),
      body: const Center(
        child: Text('My Activity Screen', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

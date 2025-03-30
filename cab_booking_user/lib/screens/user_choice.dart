import 'package:flutter/material.dart';

class UserChoice extends StatefulWidget {
  const UserChoice({super.key});

  @override
  State<UserChoice> createState() => _UserChoiceState();
}

class _UserChoiceState extends State<UserChoice> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('User Choice Screen', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';

class DriverCapturedPhotoScreen extends StatelessWidget {
  final String photoPath;

  const DriverCapturedPhotoScreen({Key? key, required this.photoPath})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Captured Photo'),
        backgroundColor: Colors.green,
      ),
      body: Center(child: Image.file(File(photoPath), fit: BoxFit.contain)),
    );
  }
}

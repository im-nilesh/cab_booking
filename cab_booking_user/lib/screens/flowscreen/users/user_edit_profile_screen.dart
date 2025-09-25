import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cab_booking_user/Widgets/app%20bar/custom_appbar.dart';
import 'package:cab_booking_user/Widgets/textfield/edit_profile_text_field.dart';
import 'package:cab_booking_user/components/Profile/profile_photo_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String name = "Manoj Pandey";
  File? profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Edit",
        onBackPress: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ProfilePhotoPicker(
                initialImage: 'assets/images/image11.png',
                onImageSelected: (file) {
                  setState(() => profileImage = file);
                },
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Name",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            EditProfileTextField(
              initialValue: name,
              onChanged: (value) => setState(() => name = value),
            ),
          ],
        ),
      ),
    );
  }
}

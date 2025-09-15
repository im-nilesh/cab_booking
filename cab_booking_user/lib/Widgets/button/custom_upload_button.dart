import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io'; // For File
import 'package:file_picker/file_picker.dart'; // Add this package for file picking

class CustomUploadButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  final Function(File?)? onFilePicked; // <-- Add this

  const CustomUploadButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.onFilePicked, // <-- Add this
  }) : super(key: key);

  @override
  _CustomUploadButtonState createState() => _CustomUploadButtonState();
}

class _CustomUploadButtonState extends State<CustomUploadButton> {
  File? _pickedFile;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _pickedFile = File(result.files.single.path!);
      });
      if (widget.onFilePicked != null) {
        widget.onFilePicked!(_pickedFile); // <-- Call the callback
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: uploadButtonborderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: GoogleFonts.outfit(
                  color: greencolor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              if (_pickedFile !=
                  null) // Only show the image if a file is selected
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _pickedFile!,
                    height: 90,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
          TextButton(
            onPressed: () {
              _pickFile();
              widget.onPressed();
            },
            child: Text(
              _pickedFile != null ? "Re-upload" : "Upload",
              style: GoogleFonts.outfit(
                color: greencolor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

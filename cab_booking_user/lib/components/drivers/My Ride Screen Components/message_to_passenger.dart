import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageToPassengers extends StatefulWidget {
  final String message;

  const MessageToPassengers({Key? key, required this.message})
    : super(key: key);

  @override
  State<MessageToPassengers> createState() => _MessageToPassengersState();
}

class _MessageToPassengersState extends State<MessageToPassengers> {
  late TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.message);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Your message to passengers",
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              icon: Icon(
                _isEditing ? Icons.check : Icons.edit,
                size: 20,
                color: Colors.grey.shade700,
              ),
              onPressed: _toggleEditing,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200),
          ),
          child:
              _isEditing
                  ? TextField(
                    controller: _controller,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type your message here...",
                    ),
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.grey.shade800,
                      height: 1.5,
                    ),
                  )
                  : Text(
                    _controller.text.isNotEmpty
                        ? _controller.text
                        : "No message added yet. Tap the edit icon to add one.",
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.grey.shade800,
                      height: 1.5,
                    ),
                  ),
        ),
      ],
    );
  }
}

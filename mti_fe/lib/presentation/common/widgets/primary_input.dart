import 'package:flutter/material.dart';

class PrimaryInput extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const PrimaryInput({
    super.key,
    required this.label,
    this.hintText = "Enter text",
    this.controller,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, // Display label
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 5), // Small spacing
        Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade50, // Light blue inner shade
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          // child: TextField(
          //   controller: controller,
          //   decoration: InputDecoration(
          //     hintText: hintText,
          //   ),
          // ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(hintText: hintText),
            validator: validator,
          ),
        ),
      ],
    );
  }
}

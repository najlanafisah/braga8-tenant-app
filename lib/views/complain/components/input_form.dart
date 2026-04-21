import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final int maxLines;

  const InputForm({
    super.key,
    required this.label,
    this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        // Kotak Input
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(
              0xFFE5D1CD,
            ).withValues(alpha: .9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

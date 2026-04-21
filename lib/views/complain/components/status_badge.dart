import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final bool isChecked;

  const StatusBadge({super.key, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    // Logika warna & label otomatis
    final color = isChecked ? Color(0xFF4CAF50) : Color(0xFFE57373);
    final label = isChecked ? "Checked" : "Unchecked";

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600),
      ),
    );
  }
}
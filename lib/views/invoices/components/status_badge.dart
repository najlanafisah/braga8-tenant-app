import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final bool isPaid;

  const StatusBadge({super.key, required this.isPaid});

  @override
  Widget build(BuildContext context) {
    final color = isPaid ? Color(0xFF4CAF50) : Color(0xFFE57373);
    final label = isPaid ? "Paid" : "Unpaid";

    return Container(
      alignment: Alignment.center,

      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

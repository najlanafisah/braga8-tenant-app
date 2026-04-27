import 'package:flutter/material.dart';

class StatusPaidBadge extends StatelessWidget {
  final bool isPaid;
  final VoidCallback? onTap;

  const StatusPaidBadge({
    super.key, 
    required this.isPaid, 
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isPaid ? const Color(0xFF4CAF50) : const Color(0xFFE54900); // Warna disesuaikan
    final label = isPaid ? "Paid" : "View Invoice";

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isPaid ? null : onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
        ),
      ),
    );
  }
}
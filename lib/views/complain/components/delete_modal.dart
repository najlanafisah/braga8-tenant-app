import 'dart:ui';
import 'package:flutter/material.dart';

class DeleteModal {
  static void showDetail({
    required BuildContext context,
    required String title,
    required List<Map<String, String>> infoData,
    VoidCallback? onTapYes,
    VoidCallback? onTapNo,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 340,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  decoration: BoxDecoration(
                    color: Color(0xFF131316),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.4),
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     Text(
                        "Hapus Laporan ini?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                     SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: _buildGradientBorderButton(
                              label: "Yes",
                              onTap: onTapYes ?? () {},
                              buttonColor: Color(0xFF3F2002), 
                            ),
                          ),
                         SizedBox(width: 15),
                          Expanded(
                            child: _buildGradientBorderButton(
                              label: "No",
                              onTap: onTapNo ?? () => Navigator.pop(context),
                              buttonColor: Color(0xFF211310),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: -5,
                  top: -10,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF382212),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
                      ),
                      child: Icon(Icons.close, color: Colors.white, size: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildGradientBorderButton({
    required String label,
    required VoidCallback onTap,
    required Color buttonColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.white.withValues(alpha: 0.6),
              Colors.white.withValues(alpha: 0.05),
              Colors.white.withValues(alpha: 0.6),
            ],
          ),
        ),
        padding: EdgeInsets.all(1.5),
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
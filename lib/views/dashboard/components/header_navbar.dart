import 'package:braga8_tenant_app/models/user_model.dart';
import 'package:braga8_tenant_app/views/dashboard/components/account_modal_tenant.dart';
import 'package:braga8_tenant_app/views/dashboard/components/notification_modal.dart';
import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

class HeaderNavbar extends StatelessWidget {
  final UserModel user;

  const HeaderNavbar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) => NotificationModal(),
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.notifications, color: Colors.white, size: 28),
            ),
          ),

          SizedBox(width: 20),

          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AccountModalTenant(user: user),
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.primaryOrange,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey.shade300,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

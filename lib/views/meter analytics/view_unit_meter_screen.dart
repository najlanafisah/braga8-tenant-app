import 'package:flutter/material.dart';
import 'package:braga8_tenant_app/models/tenant_model.dart';
import 'package:braga8_tenant_app/models/user_model.dart';
import 'package:braga8_tenant_app/views/meter%20analytics/components/meter_detail_card.dart';
import 'package:braga8_tenant_app/widgets/dark_brown_btn.dart';
import 'package:braga8_tenant_app/widgets/main_layouts.dart';
import 'package:braga8_tenant_app/widgets/view_media.dart';

class ViewUnitMeterScreen extends StatelessWidget {
  final UserModel user;
  final Unit invoiceData;

  const ViewUnitMeterScreen({
    super.key,
    required this.user,
    required this.invoiceData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          MainLayout(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  MeterDetailCard(
                    user: user,
                    invoiceData: invoiceData,
                    onStatusPressed: (val) {},
                  ),
                  const SizedBox(height: 30),
                  ViewMedia(
                    label: "Bukti Meter Air",
                    imagePath: "../../../assets/meter-sample.png",
                  ),
                  SizedBox(height: 20),
                  ViewMedia(
                    label: "Bukti Meter Listrik",
                    imagePath: "../../../assets/meter-sample.png",
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: DarkBrownBtn(
              label: "Kembali",
              onTap: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}

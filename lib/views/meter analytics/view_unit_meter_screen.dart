import 'package:braga8_tenant_app/models/invoice_modal.dart';
import 'package:braga8_tenant_app/models/unit_model.dart';
import 'package:flutter/material.dart';
import 'package:braga8_tenant_app/models/user_model.dart';
import 'package:braga8_tenant_app/views/meter%20analytics/components/meter_detail_card.dart';
import 'package:braga8_tenant_app/widgets/dark_brown_btn.dart';
import 'package:braga8_tenant_app/widgets/main_layouts.dart';
import 'package:braga8_tenant_app/widgets/view_media.dart';

class ViewUnitMeterScreen extends StatelessWidget {
  final UserModel user;
  final Unit unit;
  final Invoice invoiceData;

  const ViewUnitMeterScreen({
    super.key,
    required this.user,
    required this.invoiceData,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          MainLayout(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MeterDetailCard(
                    user: user,
                    invoiceData: invoiceData,
                    onStatusPressed: (val) {},
                    unit: unit,
                  ),
                  SizedBox(height: 30),
                  ViewMedia(
                    label: "Bukti Meter Air",
                    imagePath: "../../../assets/meter-sample.png",
                  ),
                  SizedBox(height: 20),
                  ViewMedia(
                    label: "Bukti Meter Listrik",
                    imagePath: "../../../assets/meter-sample.png",
                  ),
                  SizedBox(height: 80),
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

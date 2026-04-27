import 'package:flutter/material.dart';
import 'package:braga8_tenant_app/models/tenant_model.dart';
import 'package:braga8_tenant_app/views/invoices/components/invoice_actions.dart';
import '../../widgets/dark_brown_btn.dart';
import '../../widgets/main_layouts.dart';
import '../../widgets/view_media.dart';
import 'components/custom_data_table.dart';
import 'payment_form_screen.dart';

class InvoicesDetailScreen extends StatelessWidget {
  final Unit data;
  final String tenantName;
  const InvoicesDetailScreen({
    super.key,
    required this.data,
    required this.tenantName,
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
                  Text(
                    tenantName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Unit ${data.unit}",
                    style: const TextStyle(color: Colors.white38, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  CustomDataTable(
                    headers: ["Total Pembayaran", "Action"],
                    rows: [
                      {
                        "total_val": data.totalFormatted,
                        "action_val": InvoiceActions(
                          data: data,
                          tenantName: tenantName,
                        ),
                      },
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Detail Invoice",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomDataTable(
                    headers: ["Description", "Amount"],
                    rows: [
                      {"desc": "Pemakaian Air", "amt": data.waterDisplay},
                      {
                        "desc": "Pemakaian Listrik",
                        "amt": data.electricityDisplay,
                      },
                    ],
                  ),
                  const SizedBox(height: 40),
                  const ViewMedia(
                    label: "Bukti Meter Listrik",
                    imagePath: "assets/meter-sample.png",
                  ),
                  const ViewMedia(
                    label: "Bukti Meter Air",
                    imagePath: "assets/meter-sample.png",
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
              label: data.isPaid ? "Kembali" : "Bayar Sekarang",
              onTap: () {
                if (data.isPaid) {
                  Navigator.pop(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentFormScreen(
                        data: data,
                        tenantName: tenantName,
                        meterType: '',
                        amount: '',
                        meterId: '',
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

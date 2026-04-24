import 'package:braga8_tenant_app/views/invoices/components/invoice_actions.dart';
import 'package:flutter/material.dart';
import '../../widgets/dark_brown_btn.dart';
import '../../widgets/main_layouts.dart';
import '../../widgets/view_media.dart';
import 'components/custom_data_table.dart';
import 'payment_form_screen.dart';

// Pastikan file InvoiceActions sudah di-import
// import 'path_ke_invoice_actions.dart';

class InvoicesDetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  final String tenantName;

  const InvoicesDetailScreen({
    super.key,
    required this.data,
    required this.tenantName,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPaid = data['isPaid'] ?? false;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          MainLayout(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Text(
                    tenantName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Unit ${data['unit']}",
                    style: TextStyle(color: Colors.white38, fontSize: 14),
                  ),
                  SizedBox(height: 20),

                  CustomDataTable(
                    headers: ["Total Pembayaran", "Action"],
                    rows: [
                      {
                        "total_val": data['total'],
                        "action_val": InvoiceActions(
                          data: data,
                          tenantName: tenantName,
                        ),
                      },
                    ],
                  ),

                  SizedBox(height: 20),
                  Text(
                    "Detail Invoice",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  CustomDataTable(
                    headers: ["Description", "Amount"],
                    rows: [
                      {"desc": "Pemakaian Air", "amt": data['water'] ?? "Rp 0"},
                      {
                        "desc": "Pemakaian Listrik",
                        "amt": data['electricity'] ?? "Rp 0",
                      },
                      {"desc": "Administrasi", "amt": "Rp 3,000"},
                      {"desc": "PPN", "amt": "Rp 50,000"},
                    ],
                  ),
                  SizedBox(height: 40),
                  ViewMedia(
                    label: "Bukti Meter Listrik",
                    imagePath: "assets/meter-sample.png",
                  ),
                  SizedBox(height: 20),
                  ViewMedia(
                    label: "Bukti Meter Air",
                    imagePath: "assets/meter-sample.png",
                  ),
                  SizedBox(height: 120),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: DarkBrownBtn(
                label: isPaid ? "Kembali" : "Bayar Sekarang",
                onTap: () {
                  if (isPaid) {
                    Navigator.pop(context);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentFormScreen(
                          data: data,
                          tenantName: tenantName,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

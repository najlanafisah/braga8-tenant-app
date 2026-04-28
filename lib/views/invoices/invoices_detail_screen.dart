import 'package:braga8_tenant_app/models/invoice_modal.dart';
import 'package:braga8_tenant_app/models/unit_model.dart';
import 'package:flutter/material.dart';
import 'package:braga8_tenant_app/views/invoices/components/invoice_actions.dart';
import '../../widgets/dark_brown_btn.dart';
import '../../widgets/main_layouts.dart';
import '../../widgets/view_media.dart';
import 'components/custom_data_table.dart';
import 'payment_form_screen.dart';

class InvoicesDetailScreen extends StatelessWidget {
  final Invoice invoice;
  final Unit unit;
  final String tenantName;

   const InvoicesDetailScreen({
    super.key,
    required this.invoice,
    required this.unit,
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
              padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tenantName,
                    style:  TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Unit ${unit.unit}",
                    style:  TextStyle(
                      color: Colors.white38,
                      fontSize: 14,
                    ),
                  ),

                   SizedBox(height: 20),
                  CustomDataTable(
                    headers: ["Total Pembayaran", "Action"],
                    rows: [
                      {
                        "total_val": invoice.totalFormatted,
                        "action_val": InvoiceActions(
                          data: invoice,
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
                      {
                        "desc": "Pemakaian Air",
                        "amt": invoice.waterDisplay,
                      },
                      {
                        "desc": "Pemakaian Listrik",
                        "amt": invoice.electricityDisplay,
                      },
                    ],
                  ),

                   SizedBox(height: 40),

                   ViewMedia(
                    label: "Bukti Meter Listrik",
                    imagePath: "assets/meter-sample.png",
                  ),
                   ViewMedia(
                    label: "Bukti Meter Air",
                    imagePath: "assets/meter-sample.png",
                  ),
                  SizedBox(height: 80)
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: DarkBrownBtn(
              label: invoice.isPaid ? "Kembali" : "Bayar Sekarang",
              onTap: () {
                if (invoice.isPaid) {
                  Navigator.pop(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentFormScreen(
                        data: invoice,
                        tenantName: tenantName,
                        meterType: "Total",
                        amount: invoice.totalFormatted,
                        meterId: unit.unit,
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
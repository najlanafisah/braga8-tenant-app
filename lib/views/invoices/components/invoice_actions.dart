import 'package:braga8_tenant_app/models/invoice_modal.dart';
import 'package:braga8_tenant_app/widgets/action_button_table.dart';
import 'package:flutter/material.dart';

class InvoiceActions extends StatelessWidget {
  final Invoice data;
final String tenantName;

  const InvoiceActions({
    super.key, 
    required this.data, 
    required this.tenantName
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Tombol Export
        Expanded(
          child: ActionButtonTable(
            label: "Export",
            icon: Icons.file_download,
            color: Colors.blueAccent, // Warna biru
            onPressed: () {
              print("Exporting invoice for data.unit");
            },
          ),
        ),
        SizedBox(width: 8), // Sedikit jarak antar tombol
        // Tombol View PDF
        Expanded(
          child: ActionButtonTable(
            label: "PDF",
            icon: Icons.picture_as_pdf,
            color: Colors.redAccent, // Warna merah
            onPressed: () {
              print("Opening PDF for data.unit");
            },
          ),
        ),
      ],
    );
  }
}
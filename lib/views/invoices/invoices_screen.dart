import 'package:flutter/material.dart';
import 'package:braga8_tenant_app/models/invoice_modal.dart';
import 'package:braga8_tenant_app/models/unit_model.dart';
import 'package:braga8_tenant_app/models/user_model.dart';
import 'package:braga8_tenant_app/data/tenant_data.dart';

import '../../widgets/table_card.dart';
import '../../widgets/page_header.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/main_layouts.dart';
import '../../widgets/action_button_table.dart';
import 'components/status_badge.dart';
import 'invoices_detail_screen.dart';
import 'payment_form_screen.dart';

class InvoicesScreen extends StatefulWidget {
   const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> getAllInvoices(UserModel user) {
    List<Map<String, dynamic>> result = [];

    for (var unit in user.units) {
      for (var inv in unit.invoices) {
        result.add({"unit": unit, "invoice": inv});
      }
    }

    return result;
  }

  List<Map<String, dynamic>> filterInvoices(
    List<Map<String, dynamic>> data,
    String query,
  ) {
    if (query.isEmpty) return data;

    final q = query.toLowerCase();

    return data.where((e) {
      final unit = (e["unit"] as Unit).unit.toLowerCase();
      final month = (e["invoice"] as Invoice).month.toLowerCase();

      return unit.contains(q) || month.contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final all = getAllInvoices(dummyUser);
    final filtered = filterInvoices(all, _searchController.text);

    final unpaid = filtered
        .where((e) => !(e["invoice"] as Invoice).isPaid)
        .toList();

    final paid = filtered
        .where((e) => (e["invoice"] as Invoice).isPaid)
        .toList();

    return Scaffold(
      body: MainLayout(
        child: SafeArea(
          child: SingleChildScrollView(
            padding:  EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: 40),

                 PageHeader(
                  title: "Invoices",
                  subtitle: "Braga8 Utility Billing Management",
                ),

                 SizedBox(height: 30),

                CustomSearchBar(
                  controller: _searchController,
                  hintText: "Cari Unit / Bulan...",
                  onChanged: (_) => setState(() {}),
                ),

                 SizedBox(height: 30),

                if (unpaid.isNotEmpty) ...[
                   Text(
                    "Terbaru",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   SizedBox(height: 16),

                  ...unpaid.map((item) {
                    final Unit unit = item["unit"];
                    final Invoice invoice = item["invoice"];

                    return TableCard(
                      key: ValueKey("${unit.unit}-${invoice.month}"),
                      prefix: "Bulan:",
                      main: invoice.month,
                      columns: ["Unit", "Total", "Actions"],
                      data: [
                        {
                          "unit": unit.unit,
                          "total": invoice.totalFormatted,
                        },
                      ],
                      rowBuilder: (_) => [
                        Text(
                          unit.unit,
                          style:  TextStyle(color: Colors.white),
                        ),
                        Text(
                          invoice.totalFormatted,
                          style:  TextStyle(color: Colors.white),
                        ),
                        Row(
                          children: [
                            ActionButtonTable(
                              label: "View",
                              icon: Icons.visibility,
                              color: Colors.blueGrey,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => InvoicesDetailScreen(
                                      invoice: invoice,
                                      unit: unit,
                                      tenantName: dummyUser.companyName,
                                    ),
                                  ),
                                );
                              },
                            ),
                             SizedBox(width: 8),
                            ActionButtonTable(
                              label: "PAY",
                              icon: Icons.payment,
                              color: Colors.orange,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PaymentFormScreen(
                                      data: invoice,
                                      tenantName: dummyUser.companyName,
                                      meterType: "Total",
                                      amount: invoice.totalFormatted,
                                      meterId: unit.unit,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  }),

                   SizedBox(height: 30),
                ],

                if (paid.isNotEmpty) ...[
                   Text(
                    "Sudah Terbayar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   SizedBox(height: 16),

                  ...paid.map((item) {
                    final Unit unit = item["unit"];
                    final Invoice invoice = item["invoice"];

                    return TableCard(
                      key: ValueKey("${unit.unit}-${invoice.month}"),
                      prefix: "Bulan:",
                      main: invoice.month,
                      columns: ["Unit", "Total", "Status", "Actions"],
                      data: [
                        {
                          "unit": unit.unit,
                          "total": invoice.totalFormatted,
                        },
                      ],
                      rowBuilder: (_) => [
                        Text(
                          unit.unit,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          invoice.totalFormatted,
                          style: TextStyle(color: Colors.white),
                        ),
                        StatusBadge(isPaid: true),
                        Row(
                          children: [
                            ActionButtonTable(
                              label: "View",
                              icon: Icons.visibility,
                              color: Colors.blueGrey,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => InvoicesDetailScreen(
                                      invoice: invoice,
                                      unit: unit,
                                      tenantName: dummyUser.companyName,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

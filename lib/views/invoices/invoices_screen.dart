import 'package:braga8_tenant_app/views/invoices/components/status_badge.dart';
import 'package:flutter/material.dart';
import '../../widgets/table_card.dart';
import '../../widgets/page_header.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/main_layouts.dart';
import '../../widgets/action_button_table.dart';
import 'invoices_detail_screen.dart';
import 'payment_form_screen.dart';
import 'view_unit_meter_screen.dart';
import '../../models/user_model.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  final List<Map<String, dynamic>> _allTenants = [
    {
      "name": "Burger Bangor",
      "units_data": [
        {
          "total": "Rp. 537,000",
          "unit": "2A",
          "isPaid": true,
          "water": "Rp. 150,000",
          "electricity": "Rp. 150,000",
        },
        {
          "total": "Rp. 537,000",
          "unit": "2B",
          "isPaid": false,
          "water": "Rp. 150,000",
          "electricity": "Rp. 150,000",
        },
      ],
    },
    {
      "name": "Kopi Kenangan",
      "units_data": [
        {
          "total": "Rp. 200,000",
          "unit": "3A",
          "isPaid": false,
          "water": "Rp. 150,000",
          "electricity": "Rp. 150,000",
        },
      ],
    },
    {
      "name": "Solaria",
      "units_data": [
        {
          "total": "Rp. 537,000",
          "unit": "3C",
          "isPaid": true,
          "water": "Rp. 150,000",
          "electricity": "Rp. 150,000",
        },
      ],
    },
    {
      "name": "Hokben",
      "units_data": [
        {
          "total": "Rp. 537,000",
          "unit": "1D",
          "isPaid": false,
          "water": "Rp. 150,000",
          "electricity": "Rp. 150,000",
        },
      ],
    },
  ];

  List<Map<String, dynamic>> _filteredTenants = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredTenants = _allTenants;
  }

  void _filterData(String query) {
    setState(() {
      _filteredTenants = query.isEmpty
          ? _allTenants
          : _allTenants
                .where(
                  (t) => t['name'].toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainLayout(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
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
                  hintText: "Cari Tenant / Unit...",
                  onChanged: _filterData,
                  onSearchPressed: () => _filterData(_searchController.text),
                ),
                SizedBox(height: 30),
                // Di dalam map units_data:
                ..._filteredTenants.map((tenant) {
                  return Column(
                    children: (tenant['units_data'] as List).map((item) {
                      final bool isPaid = item['isPaid'] ?? false;

                      if (isPaid) {
                        return TableCard(
                          key: ValueKey(
                            "${tenant['name']}-${item['unit']}-paid",
                          ),
                          prefix: "Tenant:",
                          main: tenant['name'],
                          columnWidths: {
                            0: FixedColumnWidth(60),
                            1: FlexColumnWidth(1.2),
                            2: FlexColumnWidth(1),
                            3: FlexColumnWidth(1),
                          },
                          columns: ["Unit", "Total", "Status", "Actions"],
                          data: [item],
                          rowBuilder: (data) => [
                            Text(
                              data['unit'],
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              data['total'],
                              style: TextStyle(color: Colors.white),
                            ),
                            StatusBadge(isPaid: true),
                            ActionButtonTable(
                              label: "View",
                              icon: Icons.visibility,
                              color: Colors.blueGrey,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewUnitMeterScreen(
                                      user: UserModel(
                                        tenantName: tenant['name'],
                                        unit: data['unit'],
                                      ),
                                      invoiceData:
                                          data, // DATA INI SEKARANG LENGKAP (ADA WATER & ELECTRICITY)
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      } else {
                        return TableCard(
                          key: ValueKey(
                            "${tenant['name']}-${item['unit']}-unpaid",
                          ),
                          prefix: "Tenant:",
                          main: tenant['name'],
                          columnWidths: {
                            0: FixedColumnWidth(50),
                            1: FixedColumnWidth(100),
                            2: FlexColumnWidth(1.4),
                          },
                          columns: ["Unit", "Total", "Actions"],
                          data: [item],
                          rowBuilder: (data) => [
                            Text(
                              data['unit'],
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              data['total'],
                              style: TextStyle(color: Colors.white),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ActionButtonTable(
                                    label: "View",
                                    icon: Icons.visibility,
                                    color: Colors.blueGrey,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              InvoicesDetailScreen(
                                                data: data,
                                                tenantName: tenant['name'],
                                              ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: ActionButtonTable(
                                    label: "PAY",
                                    icon: Icons.payment,
                                    color: Colors.orange,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentFormScreen(
                                                data: data,
                                                tenantName: tenant['name'],
                                              ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    }).toList(),
                  );
                }),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

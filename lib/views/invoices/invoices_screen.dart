import 'package:braga8_tenant_app/views/invoices/components/status_badge.dart';
import 'package:braga8_tenant_app/views/invoices/payment_form_screen.dart';
import 'package:braga8_tenant_app/widgets/action_button_table.dart';
import 'package:flutter/material.dart';
import '../../widgets/table_card.dart';
import '../../widgets/page_header.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/main_layouts.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  final List<Map<String, dynamic>> _allTenants = [
    {
      "name": "Burger Bangor",
      "isCurrent": true,
      "units_data": [
        {"total": "Rp. 300,000", "unit": "2A"},
        {"total": "Rp. 200,000", "unit": "3A"},
      ],
    },
    {
      "name": "Kopi Kenangan",
      "isCurrent": false,
      "units_data": [
        {"total": "Rp. 300,000", "unit": "1B"},
      ],
    },
    {
      "name": "Indomaret Fresh",
      "isCurrent": false,
      "units_data": [
        {"total": "Rp. 200,000", "unit": "GF1"},
        {"total": "Rp. 300,000", "unit": "GF2"},
      ],
    },
    {
      "name": "Solaria",
      "isCurrent": false,
      "units_data": [
        {"total": "Rp. 400,000", "unit": "4C"},
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
      if (query.isEmpty) {
        _filteredTenants = _allTenants;
      } else {
        _filteredTenants = _allTenants
            .where(
              (tenant) =>
                  tenant['name'].toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                  title: "Meter Analytics",
                  subtitle: "Braga8 Utility Billing Management",
                ),
                SizedBox(height: 30),
                CustomSearchBar(
                  controller: _searchController,
                  hintText: "Cari Tenant / Unit...",
                  onChanged: (value) => _filterData(value),
                  onSearchPressed: () => _filterData(_searchController.text),
                ),
                SizedBox(height: 30),
                if (_filteredTenants.isEmpty)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Data tidak ditemukan",
                        style: TextStyle(color: Colors.white24),
                      ),
                    ),
                  )
                else
                  ..._filteredTenants.map((tenant) {
                    final bool isCurrent = tenant['isCurrent'] ?? false;

                    if (isCurrent) {
                      return TableCard(
                        key: ValueKey("${tenant['name']}-current"),
                        prefix: "Tenant:",
                        columnWidths: {
                          0: FixedColumnWidth(50),
                          1: FixedColumnWidth(100),
                          2: FlexColumnWidth(1.6),
                        },
                        main: tenant['name'],
                        columns: ["Unit", "Total", "Actions"],
                        data: List<Map<String, dynamic>>.from(
                          tenant['units_data'],
                        ),
                        rowBuilder: (item) => [
                          Text(
                            item['unit'],
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            item['total'],
                            style: TextStyle(color: Colors.white),
                          ),
                          Row(
                            // 2 Tombol
                            children: [
                              Expanded(
                                child: ActionButtonTable(
                                  label: "View",
                                  icon: Icons.visibility,
                                  color: Colors.blueGrey,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: ActionButtonTable(
                                  label: "Pay".toUpperCase(),
                                  icon: Icons.payment,
                                  color: Colors.orange,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PaymentFormScreen(
                                          data:
                                              item,
                                          tenantName:
                                              tenant['name'],
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
                    } else {
                      return TableCard(
                        key: ValueKey("${tenant['name']}-past"),
                        prefix: "Tenant:",
                        columnWidths: {
                          0: FixedColumnWidth(60),
                          1: FlexColumnWidth(1.2),
                          2: FlexColumnWidth(1),
                          3: FlexColumnWidth(1),
                        },
                        main: tenant['name'],
                        columns: ["Unit", "Total", "Status", "Actions"],
                        data: List<Map<String, dynamic>>.from(
                          tenant['units_data'],
                        ),
                        rowBuilder: (item) => [
                          Text(
                            item['unit'],
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            item['total'],
                            style: TextStyle(color: Colors.white),
                          ),

                          SizedBox(
                            width: double.infinity,
                            child: StatusBadge(isPaid: true),
                          ),

                          SizedBox(
                            width: double.infinity,
                            child: ActionButtonTable(
                              label: "View",
                              icon: Icons.visibility,
                              color: Colors.blueGrey,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      );
                    }
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

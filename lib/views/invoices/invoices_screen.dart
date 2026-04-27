import 'package:flutter/material.dart';
import 'package:braga8_tenant_app/models/tenant_model.dart';
import 'package:braga8_tenant_app/data/tenant_data.dart';
import 'package:braga8_tenant_app/views/invoices/components/status_badge.dart';
import '../../widgets/table_card.dart';
import '../../widgets/page_header.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/main_layouts.dart';
import '../../widgets/action_button_table.dart';
import 'invoices_detail_screen.dart';
import 'payment_form_screen.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});
  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  List<Tenant> _filteredTenants = allTenants;
  final TextEditingController _searchController = TextEditingController();

  void _filterData(String query) {
    setState(() {
      _filteredTenants = query.isEmpty
          ? allTenants
          : allTenants.where((t) {
              final matchTenant = t.name.toLowerCase().contains(
                query.toLowerCase(),
              );
              final matchUnit = t.units.any(
                (u) => u.unit.toLowerCase().contains(query.toLowerCase()),
              );
              return matchTenant || matchUnit;
            }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainLayout(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const PageHeader(
                  title: "Invoices",
                  subtitle: "Braga8 Utility Billing Management",
                ),
                const SizedBox(height: 30),
                CustomSearchBar(
                  controller: _searchController,
                  hintText: "Cari Tenant / Unit...",
                  onChanged: _filterData,
                  onSearchPressed: () => _filterData(_searchController.text),
                ),
                const SizedBox(height: 30),
                ..._filteredTenants.map((tenant) {
                  return Column(
                    children: tenant.units.map((item) {
                      final Map<String, dynamic> itemMap = {
                        "unit": item.unit,
                        "total": item.totalFormatted,
                      };
                      return TableCard(
                        key: ValueKey("${tenant.name}-${item.unit}"),
                        prefix: "Tenant:",
                        main: tenant.name,
                        columns: item.isPaid
                            ? ["Unit", "Total", "Status", "Actions"]
                            : ["Unit", "Total", "Actions"],
                        data: [itemMap],
                        rowBuilder: (data) => [
                          Text(
                            item.unit,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            item.totalFormatted,
                            style: const TextStyle(color: Colors.white),
                          ),
                          if (item.isPaid) const StatusBadge(isPaid: true),
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
                                      builder: (context) =>
                                          InvoicesDetailScreen(
                                            data: item,
                                            tenantName: tenant.name,
                                          ),
                                    ),
                                  );
                                },
                              ),
                              if (!item.isPaid) ...[
                                const SizedBox(width: 8),
                                ActionButtonTable(
                                  label: "PAY",
                                  icon: Icons.payment,
                                  color: Colors.orange,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PaymentFormScreen(
                                          data: item,
                                          tenantName: tenant.name,
                                          meterType: "Total",
                                          amount: item.totalFormatted,
                                          meterId: item.unit,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ],
                          ),
                        ],
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

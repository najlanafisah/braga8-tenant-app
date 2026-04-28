import 'package:flutter/material.dart';
import 'package:braga8_tenant_app/data/tenant_data.dart';
import 'package:braga8_tenant_app/models/user_model.dart';
import 'package:braga8_tenant_app/models/unit_model.dart';
import 'package:braga8_tenant_app/models/invoice_modal.dart';
import 'package:braga8_tenant_app/views/meter analytics/view_unit_meter_screen.dart';
import 'package:braga8_tenant_app/widgets/action_button_table.dart';
import '../../widgets/table_card.dart';
import '../../widgets/page_header.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/main_layouts.dart';

class MeterAnalyticsScreen extends StatefulWidget {
  const MeterAnalyticsScreen({super.key});

  @override
  State<MeterAnalyticsScreen> createState() => _MeterAnalyticsScreenState();
}

class _MeterAnalyticsScreenState extends State<MeterAnalyticsScreen> {
  final TextEditingController _searchController = TextEditingController();

  // 🔥 GROUPING PER BULAN
  Map<String, List<Map<String, dynamic>>> groupByMonth(UserModel user) {
    Map<String, List<Map<String, dynamic>>> result = {};

    for (var unit in user.units) {
      for (var inv in unit.invoices) {
        final month = inv.month;

        if (!result.containsKey(month)) {
          result[month] = [];
        }

        result[month]!.add({"unit": unit, "invoice": inv});
      }
    }

    return result;
  }

  // 🔥 FILTER SEARCH
  Map<String, List<Map<String, dynamic>>> filterGrouped(
    Map<String, List<Map<String, dynamic>>> data,
    String query,
  ) {
    if (query.isEmpty) return data;

    final q = query.toLowerCase();
    Map<String, List<Map<String, dynamic>>> result = {};

    data.forEach((month, list) {
      final filteredList = list.where((e) {
        final unit = (e["unit"] as Unit).unit.toLowerCase();
        final m = (e["invoice"] as Invoice).month.toLowerCase();

        return unit.contains(q) || m.contains(q);
      }).toList();

      if (filteredList.isNotEmpty) {
        result[month] = filteredList;
      }
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = groupByMonth(dummyUser);
    final filtered = filterGrouped(grouped, _searchController.text);

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
                  hintText: "Cari Unit / Bulan...",
                  onChanged: (value) => setState(() {}),
                ),

                SizedBox(height: 30),

                if (filtered.isEmpty)
                  Center(
                    child: Text(
                      "Data tidak ditemukan",
                      style: TextStyle(color: Colors.white24),
                    ),
                  )
                else
                  ...filtered.entries.map((entry) {
                    final month = entry.key;
                    final items = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TableCard(
                          prefix: "Bulan:",
                          main: month,
                          columns: [
                            "Unit",
                            "Floor",
                            "Electricity",
                            "Water",
                            "Actions",
                          ],
                          data: items.map((e) {
                            final Unit unit = e["unit"];
                            final Invoice invoice = e["invoice"];

                            return {
                              "unit": unit.unit,
                              "floor": unit.floor,
                              "electricity": invoice.electricityDisplay,
                              "water": invoice.waterDisplay,
                              "unitObj": unit,
                              "invoice": invoice,
                            };
                          }).toList(),

                          rowBuilder: (item) {
                            final Invoice invoice = item["invoice"];

                            return [
                              Text(
                                item["unit"],
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                item["floor"],
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                item["electricity"],
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                item["water"],
                                style: TextStyle(color: Colors.white),
                              ),

                              ActionButtonTable(
                                label: "View",
                                icon: Icons.visibility,
                                color: Colors.blueGrey,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewUnitMeterScreen(
                                        user: dummyUser,
                                        invoiceData: invoice, unit: item["unitObj"],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ];
                          },
                        ),

                        SizedBox(height: 6),
                      ],
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

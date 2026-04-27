import 'package:flutter/material.dart';
import 'package:braga8_tenant_app/models/tenant_model.dart'; // Import model
import 'package:braga8_tenant_app/data/tenant_data.dart'; // Import data
import 'package:braga8_tenant_app/models/user_model.dart';
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
  List<Tenant> _filteredTenants = allTenants;
  final TextEditingController _searchController = TextEditingController();

  void _filterData(String query) {
    setState(() {
      _filteredTenants = query.isEmpty 
          ? allTenants 
          : allTenants.where((t) => t.name.toLowerCase().contains(query.toLowerCase())).toList();
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const PageHeader(
                  title: "Meter Analytics",
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
                
                if (_filteredTenants.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text("Data tidak ditemukan", style: TextStyle(color: Colors.white24)),
                    ),
                  )
                else
                  ..._filteredTenants.map((tenant) {
                    // Konversi list Unit menjadi List<Map> agar TableCard bisa baca
                    final List<Map<String, dynamic>> unitsMapList = tenant.units.map((unit) {
                      return {
                        "unit": unit.unit,
                        "floor": unit.floor,
                        "electricity": unit.electricityDisplay,
                        "water": unit.waterDisplay,
                        "originalUnit": unit, // Simpan objek aslinya buat navigasi
                      };
                    }).toList();

                    return TableCard(
                      prefix: "Tenant:",
                      columnWidths: const {
                        0: FixedColumnWidth(50),
                        1: FixedColumnWidth(50),
                        2: FlexColumnWidth(1.4),
                        3: FlexColumnWidth(1.4),
                        4: FixedColumnWidth(90),
                      },
                      suffixText: "${tenant.units.length} Units",
                      main: tenant.name,
                      columns: const ["Unit", "Floor", "Electricity", "Water", "Actions"],
                      data: unitsMapList,
                      rowBuilder: (item) {
                        final Unit unitObj = item['originalUnit'];
                        return [
                          Text(item['unit'], style: const TextStyle(color: Colors.white)),
                          Text(item['floor'], style: const TextStyle(color: Colors.white)),
                          Text(item['electricity'], style: const TextStyle(color: Colors.white)),
                          Text(item['water'], style: const TextStyle(color: Colors.white)),
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
                                      tenantName: tenant.name,
                                      unit: item['unit'],
                                    ),
                                    // Kirim objek unitObj (tipe Unit) ke screen tujuan
                                    invoiceData: unitObj, 
                                  ),
                                ),
                              );
                            },
                          ),
                        ];
                      },
                    );
                  }),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:braga8_tenant_app/widgets/action_button_table.dart';
import 'package:flutter/material.dart';
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
  final List<Map<String, dynamic>> _allTenants = [
    {
      "name": "Burger Bangor",
      "units_data": [
        {"unit": "2A", "floor": "2", "electricity": "30403 Kwh", "water": "233 m"},
        {"unit": "3A", "floor": "2", "electricity": "30403 Kwh", "water": "233 m"},
      ],
    },
    {
      "name": "Kopi Kenangan",
      "units_data": [
        {"unit": "1B", "floor": "1", "electricity": "30450 Kwh", "water": "220 m"},
      ],
    },
    {
      "name": "Indomaret Fresh",
      "units_data": [
        {"unit": "GF1", "floor": "G", "electricity": "34503 Kwh", "water": "433 m"},
        {"unit": "GF2", "floor": "G", "electricity": "30603 Kwh", "water": "453 m"},
      ],
    },
    {
      "name": "Solaria",
      "units_data": [
        {"unit": "4C", "floor": "4", "electricity": "40403 Kwh", "water": "563 m"},
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
                    return TableCard(
                      prefix: "Tenant:",
                      columnWidths: {
                        0: FixedColumnWidth(50),
                        1: FixedColumnWidth(50),
                        2: FlexColumnWidth(1.4),
                        3: FlexColumnWidth(1.4),
                        4: FixedColumnWidth(90),
                      },
                      suffixText: "${_allTenants.length} Units",
                      main: tenant['name'],
                      columns: [
                        "Unit",
                        "Floor",
                        "Electricity",
                        "Water",
                        "Actions",
                      ],
                      data: List<Map<String, dynamic>>.from(
                        tenant['units_data'],
                      ),
                      rowBuilder: (item) => [
                        Text(
                          item['unit'],
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          item['floor'],
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          item['electricity'],
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          item['water'],
                          style: TextStyle(color: Colors.white),
                        ),
                        ActionButtonTable(
                          label: "View",
                          icon: Icons.visibility,
                          color: Colors.blueGrey,
                          onPressed: () {},
                        ),
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

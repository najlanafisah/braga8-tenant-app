import 'package:braga8_tenant_app/views/complain/add_complain_screen.dart';
import 'package:braga8_tenant_app/views/complain/view_complain_screen.dart';
import 'package:braga8_tenant_app/widgets/action_button_table.dart';
import 'package:braga8_tenant_app/widgets/custom_search_bar.dart';
import 'package:braga8_tenant_app/widgets/glassy_btn.dart';
import 'package:braga8_tenant_app/widgets/main_layouts.dart';
import 'package:braga8_tenant_app/widgets/page_header.dart';
import 'package:braga8_tenant_app/views/complain/components/status_badge.dart';
import 'package:braga8_tenant_app/widgets/table_card.dart';
import 'package:flutter/material.dart';

class ComplainsScreen extends StatefulWidget {
  const ComplainsScreen({super.key});

  @override
  State<ComplainsScreen> createState() => _ComplainsScreenState();
}

class _ComplainsScreenState extends State<ComplainsScreen> {
  final List<Map<String, dynamic>> _allTenants = [
    {
      "histories_data": [
        {
          "judul": "meter reading tidak sesuai",
          "keterangan": "meter ga berfungsi dengan baiq",
          "isCheck": false,
        },
        {
          "judul": "electricity reading tidak sesuai",
          "keterangan": "meter ga berfungsi dengan baiq",
          "isCheck": false,
        },
        {
          "judul": "petugas kurang ramah",
          "keterangan": "petugas tidak menyapa tenant saat lewat",
          "isCheck": true,
        },
        {
          "judul": "koneksi jelek",
          "keterangan":
              "koneksi internet ga sampek ke tempat saya, jadi jelek fotonya",
          "isCheck": false,
        },
        {
          "judul": "lubang di atap",
          "keterangan":
              "atap saya jebol gara2 hujan 2 bulan lalu tapi gaada yang respon",
          "isCheck": true,
        },
        {
          "judul": "kamar mandi bocor",
          "keterangan":
              "kamar mandi saya airnya sering bocor, gaada yang mau benerin kah??",
          "isCheck": true,
        },
      ],
    },
  ];

  List<Map<String, dynamic>> _filteredHistories = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredHistories = List<Map<String, dynamic>>.from(
      _allTenants[0]['histories_data'],
    );
  }

  void _filterData(String query) {
    setState(() {
      List<Map<String, dynamic>> allData = List<Map<String, dynamic>>.from(
        _allTenants[0]['histories_data'],
      );

      if (query.isEmpty) {
        _filteredHistories = allData;
      } else {
        _filteredHistories = allData.where((h) {
          final keterangan = h['keterangan'].toString().toLowerCase();
          final judul = h['judul'].toString().toLowerCase();
          final search = query.toLowerCase();

          return keterangan.contains(search) || judul.contains(search);
        }).toList();
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
                  title: "List Komplain",
                  subtitle: "Braga8 Utility Billing Management",
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: CustomSearchBar(
                        controller: _searchController,
                        hintText: "Cari Komplain...",
                        onChanged: (value) => _filterData(value),
                        onSearchPressed: () =>
                            _filterData(_searchController.text),
                      ),
                    ),
                    SizedBox(width: 12),
                    SizedBox(
                      width: 85,
                      height: 55,
                      child: GlassyBtn(
                        label: "+  Add",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddComplainScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                if (_filteredHistories.isEmpty)
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
                  ..._filteredHistories.map((item) {
                    return TableCard(
                      main: item['judul'] ?? "Komplain Tanpa Judul",
                      suffixText: "12/04/2026",
                      columnWidths: {
                        0: FlexColumnWidth(2.5),
                        1: FixedColumnWidth(100),
                        2: FixedColumnWidth(100),
                        3: FixedColumnWidth(2),
                        4: FixedColumnWidth(2),
                      },
                      columns: ["Keterangan", "Status", "Actions"],
                      data: [item],
                      rowBuilder: (currentItem) => [
                        Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Text(
                            currentItem['keterangan'] ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        StatusBadge(isChecked: currentItem['isCheck'] ?? false),
                        ActionButtonTable(
                          label: "view",
                          icon: Icons.visibility,
                          color: Colors.blueGrey,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ViewKomplainScreen(data: item),
                              ),
                            );
                          },
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

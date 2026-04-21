import 'package:braga8_tenant_app/views/history/components/pop_up_detail.dart';
import 'package:braga8_tenant_app/widgets/custom_search_bar.dart';
import 'package:braga8_tenant_app/widgets/main_layouts.dart';
import 'package:braga8_tenant_app/widgets/page_header.dart';
import 'package:braga8_tenant_app/widgets/table_card.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<Map<String, dynamic>> _allTenants = [
    {
      "histories_data": [
        {
          "no": "1",
          "activity": "Paid for Invoice 23",
          "done at": "8 PM 3/10/2026",
        },
        {
          "no": "2",
          "activity": "Paid for Invoice 20",
          "done at": "8 PM 3/10/2026",
        },
        {
          "no": "3",
          "activity": "Paid for Invoice 23",
          "done at": "8 PM 3/10/2026",
        },
        {
          "no": "4",
          "activity": "Paid for Invoice 40",
          "done at": "8 PM 3/10/2026",
        },
        {
          "no": "5",
          "activity": "Paid for Invoice 27",
          "done at": "8 PM 3/10/2026",
        },
        {
          "no": "6",
          "activity": "Paid for Invoice 43",
          "done at": "8 PM 3/10/2026",
        },
        {
          "no": "7",
          "activity": "Paid for Invoice 50",
          "done at": "8 PM 3/10/2026",
        },
      ],
    },
  ];

  List<Map<String, dynamic>> _filteredHistories = [];
  final TextEditingController _searchController = TextEditingController();

  void _filterData(String query) {
    setState(() {
      List<Map<String, dynamic>> allData = List<Map<String, dynamic>>.from(
        _allTenants[0]['histories_data'],
      );

      if (query.isEmpty) {
        _filteredHistories = allData;
      } else {
        _filteredHistories = allData.where((h) {
          final activity = h['activity'].toString().toLowerCase();
          final search = query.toLowerCase();

          return activity.contains(search);
        }).toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _filteredHistories = List<Map<String, dynamic>>.from(
      _allTenants[0]['histories_data'],
    );
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
                  title: "Activity History",
                  subtitle: "Braga8 Utility Billing Management",
                ),
                SizedBox(height: 30),
                CustomSearchBar(
                  controller: _searchController,
                  hintText: "Cari Nama atau Aktivitas...",
                  onChanged: (value) => _filterData(value),
                  onSearchPressed: () => _filterData(_searchController.text),
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
                  TableCard(
                    main: "History",
                    columnWidths: {
                      0: FixedColumnWidth(40),
                      1: FlexColumnWidth(1),
                    },
                    showUnitCount: false,
                    columns: ["No", "Activity", "Done At"],
                    data: _filteredHistories,
                    onRowTap: (item) {
                      PopUpDetail.showDetail(
                        context: context,
                        title: "Detail Activity",
                        infoData: [
                          {"label": "Activity", "value": item['activity']},
                          {"label": "Time", "value": item['done at']},
                        ],
                      );
                    },
                    rowBuilder: (item) => [
                      Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Text(
                          item['no'],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item['activity'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item['done at'],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:braga8_tenant_app/views/complain/complains_screen.dart';
import 'package:braga8_tenant_app/views/history/history_screen.dart';
import 'package:braga8_tenant_app/views/invoices/invoices_screen.dart';
import 'package:braga8_tenant_app/views/meter%20analytics/meter_analytics_screen.dart';
import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar_costom.dart';
import '../../widgets/main_layouts.dart';
import 'components/dashboard_body.dart';

class DashboardScreen extends StatefulWidget {
  final int initialIndex;

  const DashboardScreen({super.key, this.initialIndex = 0});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      DashboardBody(onMenuTap: _onItemTapped),
      MeterAnalyticsScreen(),
      InvoicesScreen(),
      HistoryScreen(),
      ComplainsScreen(),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xFF141315),
      body: MainLayout(
        child: IndexedStack(index: _selectedIndex, children: pages),
      ),
      bottomNavigationBar: BottomNavbarCustom(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

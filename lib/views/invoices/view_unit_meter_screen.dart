import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/user_model.dart';
import 'invoices_detail_screen.dart';

class ViewUnitMeterScreen extends StatelessWidget {
  final UserModel user;
  final Map<String, dynamic> invoiceData;

  const ViewUnitMeterScreen({super.key, required this.user, required this.invoiceData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white70),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("View Unit Meter", style: TextStyle(color: Colors.white54, fontSize: 14)),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildHeaderCard(context),
                const SizedBox(height: 25),
                const Text("Bukti Meter Air", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                _buildMeterImage("assets/meter-sample.png"),
                const SizedBox(height: 25),
                const Text("Bukti Meter Listrik", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                _buildMeterImage("assets/meter-sample.png"),
                const SizedBox(height: 140),
              ],
            ),
          ),
          Positioned(bottom: 30, left: 20, right: 20, child: _buildBottomBtn(context, "Kembali", () => Navigator.pop(context))),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: .1)),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: SvgPicture.asset("assets/bg_body.svg", fit: BoxFit.fill)),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Unit ${user.unit}", style: const TextStyle(color: Colors.white38, fontSize: 14)),
                Text(user.tenantName!, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.black.withValues(alpha: .3), borderRadius: BorderRadius.circular(20)),
                  child: _buildMeterTable(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeterTable(BuildContext context) {
    return Table(
      columnWidths: const {0: FlexColumnWidth(1.2), 1: FlexColumnWidth(1), 2: FlexColumnWidth(1.2), 3: FlexColumnWidth(2)},
      children: [
        _tableHeader(),
        _tableRow(context, "LST88", "Listrik", "245 Kwh", true),
        _tableRow(context, "WTR88", "Air", "356m", false), // Jika false, muncul tombol View Invoice
      ],
    );
  }

  TableRow _tableRow(BuildContext context, String c1, String c2, String c3, bool isPaidRow) {
    return TableRow(
      children: [
        _cell(c1), _cell(c2), _cell(c3),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: GestureDetector(
            onTap: () {
              // Jika diklik "View Invoice", pindah ke Detail Screen
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => InvoicesDetailScreen(data: invoiceData, tenantName: user.tenantName!),
              ));
            },
            child: _statusButton(isPaidRow ? "PAID" : "View Invoice"),
          ),
        ),
      ],
    );
  }

  // ... (Gunakan widget _cell, _tableHeader, _statusButton, _buildMeterImage dari kode aslimu)
  
  Widget _buildBottomBtn(BuildContext context, String label, VoidCallback onTap) {
     return InkWell(onTap: onTap, child: Container(
       height: 60, alignment: Alignment.center,
       decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/bg_tambahkan_btn.png"), fit: BoxFit.fill)),
       child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
     ));
  }



  TableRow _tableHeader() {
    return TableRow(
      children: ["Meter", "Jenis", "Value", "Status"].map((text) =>
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(text, style: TextStyle(color: Colors.white38, fontSize: 11)),
        )
      ).toList(),
    );
  }



  Widget _cell(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Text(text, style: TextStyle(color: Colors.white70, fontSize: 11)),
    );
  }


  Widget _statusButton(String status) {
  bool isPaid = status == "PAID";
 
  return Container(
    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: isPaid
          ? [
              Color(0xFF3B4D2B),
              Color(0xFF232E1A),
            ]
          : [
              Color(0xFF4D3B33),
              Color(0xFF2D221E),
            ],
      ),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.white.withValues(alpha: .15),
        width: 1,
      ),
    ),
    child: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isPaid) ...[
            Icon(Icons.visibility_outlined, color: Colors.white, size: 12),
            SizedBox(width: 5),
          ],
          Text(
            isPaid ? "PAID" : "View Invoice",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    ),
  );
}


  Widget _buildMeterImage(String asset) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                asset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.white10,
                  child: Center(
                    child: Icon(Icons.image_not_supported, color: Colors.white24),
                  ),
                ),
              ),
            ),


            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 68,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ColorFilter.mode(
                    Colors.black.withValues(alpha: .7),
                    BlendMode.darken,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: .0),
                          Colors.black.withValues(alpha: .8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),


            Positioned(
              left: 24,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Click to View",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: .8),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Image",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: .8),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
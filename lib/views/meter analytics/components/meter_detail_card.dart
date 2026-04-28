import 'package:braga8_tenant_app/models/invoice_modal.dart';
import 'package:braga8_tenant_app/models/unit_model.dart';
import 'package:braga8_tenant_app/views/invoices/invoices_detail_screen.dart';
import 'package:braga8_tenant_app/views/invoices/payment_form_screen.dart';
import 'package:braga8_tenant_app/views/meter%20analytics/components/status_paid_badge.dart';
import 'package:braga8_tenant_app/views/meter%20analytics/view_unit_meter_screen.dart';
import 'package:flutter/material.dart';
import 'package:braga8_tenant_app/models/user_model.dart';

class MeterDetailCard extends StatelessWidget {
  final UserModel user;
  final Unit unit;
  final Invoice invoiceData;
  final Function(String) onStatusPressed;

  const MeterDetailCard({
    super.key,
    required this.user,
    required this.invoiceData,
    required this.onStatusPressed,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.2),
            Color(0xFFE54900).withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: .1)),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withValues(alpha: .2)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Meter Details",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Unit ${unit.unit}",
              style: TextStyle(color: Colors.white38, fontSize: 14),
            ),
            Text(
              user.tenantName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Tabel
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      border: Border(bottom: BorderSide(color: Colors.white12)),
                      color: Colors.white10,
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Bulan: April",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: {
                        0: FlexColumnWidth(1.2),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1.2),
                        3: FlexColumnWidth(2),
                      },
                      children: [
                        TableRow(
                          children: ["Meter", "Jenis", "Value", "Status"]
                              .asMap()
                              .entries
                              .map(
                                (e) => _buildTableCell(
                                  isHeader: true,
                                  isLastColumn: e.key == 3,
                                  child: Text(
                                    e.value,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        _buildTableRow(
                          context,
                          "LST88",
                          "Listrik",
                          invoiceData.electricityDisplay,
                          invoiceData.isPaid,
                        ),
                        _buildTableRow(
                          context,
                          "WTR88",
                          "Air",
                          invoiceData.waterDisplay,
                          invoiceData.isPaid,
                        ),
                      ],
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

  Widget _buildTableCell({
    required Widget child,
    required bool isLastColumn,
    bool isHeader = false,
  }) {
    return Container(
      constraints: BoxConstraints(minHeight: 50),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isHeader
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: Colors.white12),
          right: isLastColumn
              ? BorderSide.none
              : BorderSide(color: Colors.white12),
        ),
      ),
      child: child,
    );
  }

  TableRow _buildTableRow(
    BuildContext context,
    String m,
    String j,
    String v,
    bool isPaid,
  ) {
    return TableRow(
      children: [
        _buildTableCell(
          isLastColumn: false,
          child: Text(m, style: TextStyle(color: Colors.white70, fontSize: 11)),
        ),
        _buildTableCell(
          isLastColumn: false,
          child: Text(j, style: TextStyle(color: Colors.white70, fontSize: 11)),
        ),
        _buildTableCell(
          isLastColumn: false,
          child: Text(v, style: TextStyle(color: Colors.white70, fontSize: 11)),
        ),
        _buildTableCell(
          isLastColumn: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: StatusPaidBadge(
              isPaid: isPaid,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InvoicesDetailScreen(
                      unit: unit,
                      invoice: invoiceData,
                      tenantName: user.tenantName,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

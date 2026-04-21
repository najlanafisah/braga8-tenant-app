import 'package:flutter/material.dart';

class TableCard extends StatelessWidget {
  final String? prefix;
  final String? main;
  final String? suffix;
  final List<String> columns;
  final List<Map<String, dynamic>> data;
  final List<Widget> Function(Map<String, dynamic> item) rowBuilder;
  final Function(Map<String, dynamic> item)? onRowTap;
  final bool showUnitCount;
  final String? suffixText;
  final Map<int, TableColumnWidth>? columnWidths;

  const TableCard({
    super.key,
    this.onRowTap,
    this.prefix,
    this.main,
    this.suffix,
    required this.columns,
    required this.data,
    required this.rowBuilder,
    this.showUnitCount = true,
    this.suffixText,
    this.columnWidths,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          if (prefix != null || main != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Row(
                children: [
                  if (prefix != null)
                    Text(
                      prefix!,
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  SizedBox(width: 8),
                  if (main != null)
                    Expanded(
                      child: Text(
                        main!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (suffixText != null)
                    Text(
                      suffixText!,
                      style: TextStyle(color: Colors.white38, fontSize: 14),
                    ),
                ],
              ),
            ),

          Table(
            columnWidths:
                columnWidths ??
                {
                  0: FixedColumnWidth(40),
                  1: FlexColumnWidth(1), 
                  2: FlexColumnWidth(1),
                  3: IntrinsicColumnWidth(),
                },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.06),
                  border: Border(
                    top: BorderSide(color: Colors.white10, width: 0.5),
                  ),
                ),
                children: columns
                    .map(
                      (col) => _cell(
                        Text(
                          col,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              ...data.map(
                (item) => TableRow(
                  children: rowBuilder(item).map((widget) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onRowTap?.call(item),
                      child: _cell(widget),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cell(Widget child) => Padding(
    padding: EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 8,
    ),
    child: Align(
      alignment: Alignment.centerLeft,
      child: child,
    ),
  );
}

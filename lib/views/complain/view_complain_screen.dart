import 'package:braga8_tenant_app/views/complain/complains_screen.dart';
import 'package:braga8_tenant_app/views/complain/components/delete_modal.dart';
import 'package:braga8_tenant_app/views/complain/components/view_media.dart';
import 'package:braga8_tenant_app/views/complain/edit_laporan_screen.dart';
import 'package:braga8_tenant_app/widgets/light_brown_btn.dart';
import 'package:braga8_tenant_app/widgets/main_layouts.dart';
import 'package:braga8_tenant_app/views/complain/components/action_btn.dart';
import 'package:braga8_tenant_app/views/complain/components/status_badge.dart';
import 'package:flutter/material.dart';

class ViewKomplainScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const ViewKomplainScreen({super.key, required this.data});

  @override
  State<ViewKomplainScreen> createState() => _ViewKomplainScreenState();
}

class _ViewKomplainScreenState extends State<ViewKomplainScreen> {
  @override
  Widget build(BuildContext context) {
    final String title = widget.data['judul'] ?? 'Tanpa Judul';
    final String description = widget.data['keterangan'] ?? '-';
    final bool isChecked = widget.data['isCheck'] ?? false;

    return MainLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '30 January 2006',
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                    SizedBox(height: 32),
                    
                    _buildLabel('Keterangan'),
                    SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    
                    SizedBox(height: 24),
                    
                    _buildLabel('Status'),
                    SizedBox(height: 8),
                    StatusBadge(isChecked: isChecked),
                    
                    SizedBox(height: 32),
                    ViewMedia(
                      label: "Bukti komplain",
                      imagePath: "assets/meter-sample.png",
                    ),
                    
                    SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(
                          child: ActionBtn(
                            label: "Edit",
                            backgroundColor: Color(0xFF3E2723),
                            icon: Icons.edit,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditLaporanScreen(data: widget.data),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ActionBtn(
                            label: "Delete",
                            backgroundColor: Colors.red.shade900,
                            icon: Icons.delete,
                            onTap: () {
                              DeleteModal.showDetail(
                                context: context,
                                title: "Hapus Komplain?",
                                infoData: [],
                                onTapNo: () => Navigator.pop(context),
                                onTapYes: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ComplainsScreen(),
                                    ),
                                    (route) => false,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    LightBrownBtn(
                      onTap: () => Navigator.pop(context),
                      label: "Kembali",
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
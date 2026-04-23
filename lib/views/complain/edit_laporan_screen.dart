import 'package:braga8_tenant_app/widgets/edit_media.dart';
import 'package:braga8_tenant_app/views/complain/components/header_title.dart';
import 'package:braga8_tenant_app/views/complain/components/input_form.dart';
import 'package:braga8_tenant_app/widgets/light_brown_btn.dart';
import 'package:braga8_tenant_app/views/complain/components/status_badge.dart';
import 'package:braga8_tenant_app/widgets/success_modal.dart';
import 'package:flutter/material.dart';
import '../../widgets/main_layouts.dart';

class EditLaporanScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const EditLaporanScreen({super.key, required this.data});

  @override
  State<EditLaporanScreen> createState() => _EditLaporanScreenState();
}

class _EditLaporanScreenState extends State<EditLaporanScreen> {
  late TextEditingController judulController;
  late TextEditingController keteranganController;

  @override
  void initState() {
    super.initState();
    judulController = TextEditingController(text: widget.data['judul']);
    keteranganController = TextEditingController(
      text: widget.data['keterangan'],
    );
  }

  @override
  void dispose() {
    judulController.dispose();
    keteranganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderTitle(title: "Edit Laporan"),

              SizedBox(height: 32),

              InputForm(label: "Pasal Komplain", controller: judulController),
              SizedBox(height: 20),

              InputForm(
                label: "Keterangan",
                controller: keteranganController,
                maxLines: 3,
              ),

              SizedBox(height: 20),

              Text(
                "Status",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              StatusBadge(isChecked: false),
              SizedBox(height: 20),

              EditMedia(label: 'Foto Komplain (Opsional)'),

              SizedBox(height: 40),
              LightBrownBtn(
                onTap: () {
                  SuccessModal.show(
                    context,
                    title: "Berhasil di Update!",
                    onConfirm: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  );
                },
                label: 'Tambahkan',
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

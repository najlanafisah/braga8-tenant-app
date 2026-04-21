import 'dart:io';
import 'package:braga8_tenant_app/services/image_services.dart';
import 'package:braga8_tenant_app/views/complain/components/add_media.dart';
import 'package:braga8_tenant_app/views/complain/components/input_form.dart';
import 'package:braga8_tenant_app/widgets/light_brown_btn.dart';
import 'package:braga8_tenant_app/widgets/main_layouts.dart';
import 'package:braga8_tenant_app/widgets/success_modal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AddComplainScreen extends StatefulWidget {
  const AddComplainScreen({super.key});

  @override
  State<AddComplainScreen> createState() => _AddComplainScreenState();
}

class _AddComplainScreenState extends State<AddComplainScreen> {
  final ImageService _imageService = ImageService();
  File? _imageFile;

  Future<void> _handlePickImage() async {
    if (!kIsWeb) {
      var status = await Permission.camera.request();
      if (!status.isGranted) return;
    }

    File? file = await _imageService.pickImage(fromGallery: kIsWeb);

    if (file != null) {
      setState(() {
        _imageFile = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title Section
                Text(
                  'Lapor Komplain',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Braga8',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 32),

                InputForm(label: "Pasal Komplain", maxLines: 1),

                SizedBox(height: 20),

                InputForm(label: "Keterangan", maxLines: 3),

                SizedBox(height: 20),

                AddMedia(
                  label: "Foto Komplain (Opsional)",
                  onPickImage: _handlePickImage,
                  btnText: _imageFile == null ? 'Ambil Foto' : 'Ganti Foto',
                  imageFile: _imageFile, // Kirim filenya ke komponen
                ),
                SizedBox(height: 40),
                LightBrownBtn(
                  onTap: () {
                    SuccessModal.show(
                      context,
                      title: "Berhasil di Tambahkan!",
                      onConfirm: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    );
                  },
                  label: 'Tambahkan',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

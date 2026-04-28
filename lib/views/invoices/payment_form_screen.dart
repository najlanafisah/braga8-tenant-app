import 'dart:io';
import 'package:braga8_tenant_app/models/invoice_modal.dart';
import 'package:braga8_tenant_app/services/image_services.dart';
import 'package:braga8_tenant_app/views/dashboard/dashboard_screen.dart';
import 'package:braga8_tenant_app/views/invoices/components/custom_text_field.dart';
import 'package:braga8_tenant_app/widgets/add_media.dart';
import 'package:braga8_tenant_app/widgets/dark_brown_btn.dart';
import 'package:braga8_tenant_app/widgets/main_layouts.dart';
import 'package:braga8_tenant_app/widgets/success_modal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class PaymentFormScreen extends StatefulWidget {
  final Invoice data;
  final String tenantName;
  final String meterType;
  final String amount;
  final String meterId;

  const PaymentFormScreen({
    super.key,
    required this.tenantName,
    required this.meterType,
    required this.amount,
    required this.meterId,
    required this.data,
  });

  @override
  State<PaymentFormScreen> createState() => _PaymentFormScreenPageState();
}

class _PaymentFormScreenPageState extends State<PaymentFormScreen> {
  String? _selectedMethod;
  late TextEditingController _amountController;
  final TextEditingController _noteController = TextEditingController();
  final List<String> _paymentMethods = [
    'Transfer Bank (BCA)',
    'Transfer Bank (Mandiri)',
    'E-Wallet (Gopay/OVO)',
    'Tunai/Cash',
  ];

  final ImageService _imageService = ImageService();

  Future<void> _handlePickImage() async {
    if (!kIsWeb) {
      var status = await Permission.camera.request();
      if (!status.isGranted) return;
    }

    File? file = await _imageService.pickImage(fromGallery: kIsWeb);

    if (file != null) {
      setState(() {});
    }
  }

  String _formatCurrency(String value) {
    final number = int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(number);
  }

  @override
  void initState() {
    super.initState();
    String rawAmount = widget.amount.replaceAll(RegExp(r'[^0-9]'), '');
    _amountController = TextEditingController(text: _formatCurrency(rawAmount));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: MainLayout(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Text(
                      "Payment Form",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Unit ${widget.data.waterUsage}",
                      style: TextStyle(color: Colors.white38, fontSize: 18),
                    ),
                    SizedBox(height: 30),
                    CustomTextField(
                      label: "Total Pembayaran",
                      controller: _amountController,
                      readOnly: true,
                      isNumber: true,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      label: "Pilih Metode Pembayaran",
                      dropdownItems: _paymentMethods,
                      dropdownValue: _selectedMethod,
                      onDropdownChanged: (val) =>
                          setState(() => _selectedMethod = val),
                    ),
                    SizedBox(height: 20),
                    AddMedia(
                      label: "Tambahkan Bukti Foto Pembayaran",
                      onPickImage: () {
                        _handlePickImage();
                      },
                      btnText: "Pilih Foto",
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      label: "Tambah Keterangan (Opsional)",
                      controller: _noteController,
                      hint: "Contoh: Pembayaran bulan April",
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: DarkBrownBtn(
                        label: "Kirim Pembayaran",
                        onTap: () {
                          SuccessModal.show(
                            context,
                            title: "Pembayaran Berhasil Dikirim!",
                            onConfirm: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DashboardScreen(initialIndex: 2),
                                ),
                                (route) => false,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

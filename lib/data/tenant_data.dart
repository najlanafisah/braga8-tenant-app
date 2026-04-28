import 'package:braga8_tenant_app/models/invoice_modal.dart';
import 'package:braga8_tenant_app/models/unit_model.dart';
import 'package:braga8_tenant_app/models/user_model.dart';

final UserModel dummyUser = UserModel(
  username: 'Akhmad',
  email: 'akhmad@gmail.com',
  joinDate: 'Juni 2009',
  tenantName: "Akhmad",
  companyName: "Solaria",
  phone: "0812345678",
  businessType: "Restaurant",

  units: [
    Unit(
      unit: "2A",
      floor: "2",
      invoices: [
        Invoice(
          month: "Desember",
          electricityUsage: 400,
          waterUsage: 200,
          isPaid: true,
        ),
        Invoice(
          month: "Januari",
          electricityUsage: 420,
          waterUsage: 210,
          isPaid: true,
        ),
        Invoice(
          month: "Februari",
          electricityUsage: 450,
          waterUsage: 230,
          isPaid: false,
        ),
      ],
    ),
    Unit(
      unit: "2B",
      floor: "2",
      invoices: [
        Invoice(
          month: "Desember",
          electricityUsage: 300,
          waterUsage: 180,
          isPaid: true,
        ),
        Invoice(
          month: "Januari",
          electricityUsage: 320,
          waterUsage: 190,
          isPaid: true,
        ),
        Invoice(
          month: "Februari",
          electricityUsage: 220,
          waterUsage: 200,
          isPaid: false,
        ),
      ],
    ),
  ],
);
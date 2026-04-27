import '../models/tenant_model.dart';

final List<Tenant> allTenants = [
  Tenant(
    name: "Burger Bangor",
    units: [
      Unit(
        unit: "2A",
        floor: "2",
        electricityUsage: 403,
        waterUsage: 233,
        isPaid: true,
      ),
      Unit(
        unit: "3A",
        floor: "2",
        electricityUsage: 410,
        waterUsage: 240,
        isPaid: false,
      ),
    ],
  ),
  Tenant(
    name: "Kopi Kenangan",
    units: [
      Unit(
        unit: "1B",
        floor: "1",
        electricityUsage: 850,
        waterUsage: 220,
        isPaid: false,
      ),
    ],
  ),
  Tenant(
    name: "Indomaret Fresh",
    units: [
      Unit(
        unit: "GF1",
        floor: "G",
        electricityUsage: 503,
        waterUsage: 433,
        isPaid: true,
      ),
      Unit(
        unit: "GF2",
        floor: "G",
        electricityUsage: 603,
        waterUsage: 453,
        isPaid: false,
      ),
    ],
  ),
  Tenant(
    name: "Solaria",
    units: [
      Unit(
        unit: "4C",
        floor: "4",
        electricityUsage: 403,
        waterUsage: 563,
        isPaid: false,
      ),
    ],
  ),
];
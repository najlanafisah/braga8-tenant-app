class Tenant {
  final String name;
  final List<Unit> units;

  Tenant({required this.name, required this.units});
}

class Unit {
  final String unit;
  final String floor;
  final double electricityUsage; 
  final double waterUsage;     
  final double pricePerKwh;
  final double pricePerM3;
  final bool isPaid;

  Unit({
    required this.unit,
    required this.floor,
    required this.electricityUsage,
    required this.waterUsage,
    this.pricePerKwh = 1500,
    this.pricePerM3 = 2000,
    required this.isPaid,
  });

  double get electricityTotal => electricityUsage * pricePerKwh;
  
  double get waterTotal => waterUsage * pricePerM3;
  
  double get grandTotal => electricityTotal + waterTotal;

  String get electricityDisplay => "${electricityUsage.toStringAsFixed(0)} Kwh";
  String get waterDisplay => "${waterUsage.toStringAsFixed(0)} m";
  String get totalFormatted => "Rp. ${grandTotal.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
}
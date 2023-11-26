class ExpenceModel {
  final int id;
  final String name;
  final double water;
  final double power;
  final double gas;
  final double waterPrice;
  final double powerPrice;
  final double gasPrice;
  final double sumCost;
  final String status;
  final DateTime dateTime;
  ExpenceModel(
      {required this.id,
      required this.name,
      required this.water,
      required this.power,
      required this.gas,
      required this.waterPrice,
      required this.powerPrice,
      required this.gasPrice,
      required this.sumCost,
      required this.status,
      required this.dateTime});
}

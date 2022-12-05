
final String tableExpence = 'expences';
class expenceField{
  static final String id = '_id';
  static final String cost = 'cost';
  static final String name = 'name';
  static final String dateTime = 'dateTime';
}

class expenceModel{
  final int? id;
  final double cost;
  final String name;
  final DateTime dateTime;
  expenceModel({
    this.id,
    required this.cost,
    required this.name,
    required this.dateTime
  });

}
import 'package:drift/drift.dart';

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get color => integer()();
}

class Budgets extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get budget => real()();
  TextColumn get description => text()();
  DateTimeColumn get day => dateTime()();
  IntColumn get tag => integer().references(Tags, #id)();
}

class Exchanges extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get conversion => real()();
  TextColumn get symbol => text()();
}


class ExchangeModel {
  String name;
  double conversion;
  String symbol;

  ExchangeModel(
      {required this.name, required this.conversion, required this.symbol});

  Map<String, Object?> toMap() =>
      {'name': name, 'conversion': conversion, 'symbol': symbol};

  ExchangeModel.fromMap(Map<String, Object?> m)
      : name = m['name'] as String,
        conversion = m['conversion'] as double,
        symbol = m['symbol'] as String;
}

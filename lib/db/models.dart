import 'package:flutter/material.dart';

// TODO make tests of constructors. They should be identity fromMap . toMap

class TagModel {
  Color color;
  String name;
  double monthlyLimit;

  TagModel({
    required this.color,
    required this.name,
    required this.monthlyLimit,
  });

  TagModel.fromMap(Map<String, Object?> m)
      : color = m['color'] as Color,
        name = m['name'] as String,
        monthlyLimit = m['monthlyLimit'] as double;

  Map<String, Object?> toMap() => {
        'color': color.value,
        'name': name,
        'monthlyLimit': monthlyLimit,
      };
}

class BudgetModel {
  double budget;
  String description;
  DateTime day;
  TagModel tag;

  BudgetModel(
      {required this.budget,
      required this.description,
      required this.day,
      required this.tag});

  Map<String, Object?> toMap() => {
        "budget": budget,
        'description': description,
        'day': day.millisecondsSinceEpoch,
        'tag': tag.toMap(),
      };

  BudgetModel.fromMap(Map<String, Object?> m)
      : budget = m['budget'] as double,
        description = m['description'] as String,
        day = DateTime.fromMillisecondsSinceEpoch(m['day'] as int),
        tag = TagModel.fromMap(m['tag'] as Map<String, Object?>);
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

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

void createDatabase() async {
  openDatabase(
    join(await getDatabasesPath(), 'budget.db'),
    onCreate: (db, version) {
      return db.transaction(
          (txn) async {
            txn.execute("CREATE TABLE Tag(tagId Integer Primary Key, tagColor Integer, tagName Text Unique) STRICT;");
            txn.execute("CREATE TABLE Budget(budgetId Integer Primary Key, budget Real, description Text, day Integer, tagId Integer, Foreign Key(tagId) References TAG(tagId)) STRICT;");
            txn.execute("CREATE TABLE AssociatedWord(wordId Integer Primary Key, word Text Unique, tag Integer, Foreign Key(tag) References Tag(tagId)) Strict;");
            txn.execute("CREATE TABLE Exchange(exchangeId Integer Primary Key, name Text, conversion Real, symbol Text) Strict;");
          });
    },
    version: 1,
  );
}
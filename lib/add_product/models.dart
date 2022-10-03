
import 'dart:ui';

import 'package:flutter/cupertino.dart';

enum TimeTagEnum { daily, weekly, monthly, annualy, oneTime }

class TimeTagTuple {
  final String title;
  final TimeTagEnum timeTag;

  TimeTagTuple({required this.title, required this.timeTag});
}

List<TimeTagTuple> allTags = [
  TimeTagTuple(title: 'One time', timeTag: TimeTagEnum.oneTime),
  TimeTagTuple(title: 'Monthly', timeTag: TimeTagEnum.monthly),
  TimeTagTuple(title: 'Daily', timeTag: TimeTagEnum.daily),
  TimeTagTuple(title: 'Weekly', timeTag: TimeTagEnum.weekly),
  TimeTagTuple(title: 'Annually', timeTag: TimeTagEnum.annualy),
];

class Tag {
  Color color;
  String name;
  bool created;

  Tag({required this.color, required this.name, required this.created});
}

class TagColorPicker with ChangeNotifier {
  Color _color;

  Color get color => _color;

  set color(Color c) {
    _color = c;
    notifyListeners();
  }

  TagColorPicker(this._color);
}

class BudgetFormData with ChangeNotifier {
  double _budget;
  TimeTagEnum _timeTag;

  double get budget => _budget;
  String _description;
  Tag _tag;
  int _step = 0;

  BudgetFormData(this._budget, this._timeTag, this._description, this._tag);

  void setBudget(double budget) {
    _budget = budget;
    notifyListeners();
  }

  void setTimeTagEnum(TimeTagEnum timeTagEnum) {
    _timeTag = timeTagEnum;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  void setTag(Tag tag) {
    _tag = tag;
    notifyListeners();
  }

  void overStep(int Function(int) step) {
    _step = step(_step);
    notifyListeners();
  }

  void awaitColorPicker(Future<Color?> colorF) async {
    var value = await colorF;
    if (value != null) {
      overTag((t) => Tag(color: value, name: t.name, created: t.created));
    }
  }

  TimeTagEnum get timeTag => _timeTag;

  String get description => _description;

  Tag get tag => _tag;

  int get step => _step;

  void overTag(Tag Function(Tag t) f) {
    _tag = f(_tag);
    notifyListeners();
  }
}
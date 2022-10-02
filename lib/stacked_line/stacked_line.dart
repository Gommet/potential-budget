import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarBudgetChart extends StatelessWidget {
  const BarBudgetChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        AspectRatio(
          aspectRatio: 2,
          child: context.watch<BarBudgetData>().generateBarChart(),
        )
      ],
    );
  }
}

class BudgetDataTag {
  Color color;
  List<double> values;
  String tag;

  BudgetDataTag(this.color, this.values, this.tag);
}

class BudgetData {
  List<BudgetDataTag> data;

  BudgetData(this.data);

  BarBudgetData generateData() {
    List<BarBudgetSectionData> ls = [];
    for (int i = 0; i < data[0].values.length; i++) {
      ls.add(BarBudgetSectionData(i,
          data.map((e) => BarSectionData(e.values[i], e.color)).toList()));
    }
    return BarBudgetData(ls);
  }
}

class BarBudgetData {
  List<BarBudgetSectionData> sections;

  BarBudgetData(this.sections);

  BarChart generateBarChart() {
    return BarChart(BarChartData(
      barGroups: sections.map((e) => e.generateGroupData()).toList(),
    ));
  }
}

class BarSectionData {
  double size;
  Color color;

  BarSectionData(this.size, this.color);
}

class _Combinator {
  List<BarChartRodData> ls;
  double current;

  _Combinator(this.ls, this.current);
}

class BarBudgetSectionData {
  int x;
  List<BarSectionData> ls;

  BarBudgetSectionData(this.x, this.ls);

  BarChartGroupData generateGroupData() {
    return BarChartGroupData(
        x: x,
        groupVertically: true,
        barRods: ls.fold(_Combinator([], 0), (previousValue, element) {
          double toY = previousValue.current + element.size;
          return _Combinator(
              previousValue.ls +
                  [
                    BarChartRodData(
                      toY: toY,
                      borderRadius: BorderRadius.zero,
                      fromY: previousValue.current,
                      color: element.color,
                      width: 19,
                    ),
                  ],
              toY);
        }).ls);
  }
}

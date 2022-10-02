import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BudgetPieChart extends StatelessWidget {
  const BudgetPieChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var p = context.watch<PieChartProvider>();
    var sections = p.sections;
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: [
          const SizedBox(height: 18),
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: sections
                  .map((e) => Indicator(
                  color: e.color, text: e.tag, isSquare: p.isSquare))
                  .toList()),
          const SizedBox(height: 18),
          Expanded(
            child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(PieChartData(
                    sections: sections
                        .map((e) => PieChartSectionData(
                        value: e.value,
                        color: e.color,
                        title: '${e.value}'))
                        .toList()))),
          )
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}

class PieChartSection {
  Color color;
  double value;
  String tag;

  PieChartSection(this.color, this.value, this.tag);
}

class PieChartProvider {
  List<PieChartSection> sections;
  bool isSquare;

  PieChartProvider(this.sections, this.isSquare);
}

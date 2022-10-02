import 'package:example/add_product/page.dart';
import 'package:example/pie_chart/pie_chart.dart';
import 'package:example/stacked_line/stacked_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider(
        create: (_) => PieChartProvider(
          <PieChartSection>[
            PieChartSection(Colors.teal, 700, 'Travel Expenses'),
            PieChartSection(Colors.amber, 400, 'Flat')
          ],
          true,
        ),
      ),
      Provider(
          create: (_) => BudgetData([
                BudgetDataTag(Colors.teal,
                    [400, 200, 100, 50, 0, 0, 0, 0, 0, 0, 0, 0], 'Flat'),
                BudgetDataTag(
                    Colors.amber,
                    [700, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                    'Travel Expenses'),
              ]).generateData())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Budget',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.deepPurple,
          useMaterial3: true,
        ),
        routes: {
          '/': (_) => const MyHomePage(),
          '/add-product': (_) => const AddProductPage(),
        });
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: const [
            Text(
              'Pie chart',
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            BudgetPieChart(),
            SizedBox(height: 50,),
            Text('Monthly activity',
                style: TextStyle(
                  fontSize: 32,
                )),
            BarBudgetChart(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add-product'),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

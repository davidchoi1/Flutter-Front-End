import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';


// will data need associated dates since x-axis is weeks and y axis is between 0-5?
// how do I associate weeks with survey?
class MyData {
  final int x;
  final double y;

  MyData(this.x, this.y);
}

class MyLineChart extends StatelessWidget {
  final List<MyData> data;
  final bool animate;

  MyLineChart(this.data, {super.key, required this.animate});

  @override
  Widget build(BuildContext context) {
    final series = [
      charts.Series<MyData, int>(
        id: 'My Data',
        colorFn: (_, __) => charts.MaterialPalette.black,
        domainFn: (MyData data, _) => data.x,
        measureFn: (MyData data, _) => data.y,
        data: data,
      ),
    ];

    return charts.LineChart(
      series,
      animate: animate,
      defaultRenderer: charts.LineRendererConfig(
        includeArea: true,
        includePoints: true,
        includeLine: true,
      ),
      domainAxis: const charts.NumericAxisSpec(
        tickProviderSpec:
            charts.BasicNumericTickProviderSpec(desiredTickCount: 3),
      ),
      primaryMeasureAxis: const charts.NumericAxisSpec(
        tickProviderSpec:
            charts.BasicNumericTickProviderSpec(desiredTickCount: 5),
      ),
    );
  }
}

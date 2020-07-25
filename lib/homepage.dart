import 'package:flutter/material.dart';
import 'package:geophone/data.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// List<DataPoint> points = new List();
// dataToPoints(List data) {
//   for (int i = 0; i < 1023; i++) {
//     points.add(DataPoint<int>(value: data[i], xAxis: i));
//   }
//   return points;
// }

// ignore: must_be_immutable

class GraphPoint {
  final int x;
  final int y;
  GraphPoint(this.x, this.y);
}

valuesToPoints(List values, int sensor) {
  List<GraphPoint> points = new List();
  if (sensor == 0) {
    for (int i = 0; i < 1023; i++) {
      points.add(GraphPoint(i, values[i]));
    }
  }
  if (sensor == 1) {
    for (int i = 1024; i < 2047; i++) {
      points.add(GraphPoint(i % 1024, values[i]));
    }
  }
  if (sensor == 2) {
    for (int i = 2048; i < 3071; i++) {
      points.add(GraphPoint(i % 1024, values[i]));
    }
  }
  return points;
}

class HomePage extends StatelessWidget {
  List<GraphPoint> points0 = valuesToPoints(exampleData[0], 0);
  List<GraphPoint> points1 = valuesToPoints(exampleData[0], 1);
  List<GraphPoint> points2 = valuesToPoints(exampleData[0], 2);
  _getSeriesData() {
    List<charts.Series<GraphPoint, int>> series = [
      charts.Series(
          id: "0",
          data: points0,
          domainFn: (GraphPoint series, _) => series.x,
          measureFn: (GraphPoint series, _) => series.y,
          colorFn: (GraphPoint series, _) =>
              charts.MaterialPalette.blue.shadeDefault),
      charts.Series(
          id: "1",
          data: points1,
          domainFn: (GraphPoint series, _) => series.x,
          measureFn: (GraphPoint series, _) => series.y,
          colorFn: (GraphPoint series, _) =>
              charts.MaterialPalette.red.shadeDefault),
      charts.Series(
          id: "2",
          data: points2,
          domainFn: (GraphPoint series, _) => series.x,
          measureFn: (GraphPoint series, _) => series.y,
          colorFn: (GraphPoint series, _) =>
              charts.MaterialPalette.green.shadeDefault)
    ];
    return series;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: new charts.LineChart(
        _getSeriesData(),
        animate: false,
      ),
    );
  }
}

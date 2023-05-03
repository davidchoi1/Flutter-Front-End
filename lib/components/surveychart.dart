import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

class SurveyChart extends StatefulWidget {
  final String userEmail;

  const SurveyChart({required this.userEmail});

  @override
  _SurveyChartState createState() => _SurveyChartState();
}

class _SurveyChartState extends State<SurveyChart> {
  List<FlSpot> chartData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String apiUrl = "https://your-backend-api-url.com"; // Replace with your backend API URL
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'userEmail': widget.userEmail,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      processChartData(data);
    } else {
      print("Error fetching data: ${response.statusCode}");
    }
  }

  void processChartData(List<dynamic> data) {
    List<double> averages = [];

    data.forEach((survey) {
      Map<String, dynamic> surveyMap = survey['surveyMap'];
      double sum = 0;
      int count = 0;
      
      surveyMap.forEach((key, value) {
        sum += value;
        count++;
      });

      double average = sum / count;
      averages.add(average);
    });

    setState(() {
      chartData = averages
          .asMap()
          .entries
          .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: chartData.length.toDouble() - 1,
        minY: 0,
        maxY: 10, // Change the range based on your data values
        lineBarsData: [
          LineChartBarData(
            spots: chartData,
            isCurved: true,
            colors: [Colors.blue],
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}

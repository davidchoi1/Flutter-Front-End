import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class SurveyChart extends StatefulWidget {
  final String userEmail;

  const SurveyChart({required this.userEmail});

  @override
  _SurveyChartState createState() => _SurveyChartState();
}

class _SurveyChartState extends State<SurveyChart> {
  List<FlSpot> chartData = [];
  List<DateTime> createdAtDates = [];

  // initialize values and fetch data
  @override
  void initState() {
    super.initState(); // call parent class initial state function
    fetchData();
  }

  // function to fetch survey data from backend
  Future<void> fetchData() async {
    String apiUrl =
        "https://your-backend-api-url.com"; // Replace with your backend API URL
    final response = await http.get(
      // contents of get request stored in response (response.body)
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'userEmail': widget.userEmail,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(
          response.body); // decode and store response json contents into a list
      processChartData(data); // pass decoded data into process chart function
    } else {
      print("Error fetching data: ${response.statusCode}");
    }
  }

  // function to process survey data into survey chart
  void processChartData(List<dynamic> data) {
    List<double> averages = []; // create list to hold average values
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
      createdAtDates.add(DateTime.parse(survey['createdAt']));
    });

    setState(() {
      int daysSinceFirstSurvey(DateTime date) {
        return date.difference(createdAtDates.first).inDays;
      }

      chartData = averages
          .asMap()
          .entries
          .map((entry) => FlSpot(
              daysSinceFirstSurvey(createdAtDates[entry.key]) as double,
              entry.value))
          .toList();
    });
  }

  // In the build method, modify LineChartData to show custom X-axis labels
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              getTextStyles: (BuildContext context, double value) => const TextStyle(color: Colors.black, fontSize: 12),
              getTitles: (value) {
                int index = createdAtDates.indexWhere((date) =>
                    date.difference(createdAtDates.first).inDays ==
                    value.toInt());
                if (index != -1) {
                  return DateFormat('MM/dd/yyyy').format(createdAtDates[index]);
                }
                return '';
              },
            ),
            leftTitles: SideTitles(showTitles: true),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: (createdAtDates.last.difference(createdAtDates.first).inDays)
              .toDouble(),
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
      ),
    );
  }
}

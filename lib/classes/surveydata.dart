import 'package:intl/intl.dart';

class SurveyData {
  DateTime createdAt;
  Map<String, dynamic> surveyMap;
  String? userEmail;
  SurveyData({required this.createdAt, required this.surveyMap, required this.userEmail});

  String formatDateTime() {
    return "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}";
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': formatDateTime(),
      'surveyMap': surveyMap,
      'userEmail': userEmail // Include the userEmail in the data sent to the backend
    };
  }
}

import 'package:circle_app/pages/authpage.dart';
import 'package:circle_app/pages/surveypage.dart';
import 'package:circle_app/pages/contactspage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:math';
import '../classes/contact.dart';
import '../classes/surveydata.dart';
import '../components/surveychart.dart';
import 'package:health/health.dart';

class HomePage extends StatefulWidget {
  final String? userEmail;
  const HomePage({super.key, this.userEmail = ''});

  @override
  State<HomePage> createState() => _HomePageState();
}
//creating a healthFactory for use in the app
HealthFactory health = HealthFactory();



class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Contact> contacts = List.empty(growable: true);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // sign user out function
  void _handleSignOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AuthPage()),
      (route) => false,
    );
  }

  Future<void> updateContacts(String? userEmail, List<Contact> contacts) async {
    final response = await http.post(
      Uri.parse(
          'https://your-api-url/contacts/update'), // Replace with your API endpoint
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userEmail': userEmail,
        'contacts': contacts.map((contact) => contact.toJson()).toList(),
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update contacts');
    }
  }

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    Future<void> _scheduleWeeklyNotification() async {
      var scheduledNotificationDateTime = DateTime.now().add(Duration(days: 7));
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'weeklySurveyReminderChannel', 'Weekly Survey Reminder',
          importance: Importance.high, priority: Priority.high);
      var platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.schedule(
          0,
          'Weekly Survey Reminder',
          'Don\'t forget to complete your weekly survey!',
          scheduledNotificationDateTime,
          platformChannelSpecifics);
      await Future.delayed(Duration(days: 7)); // wait for 7 seconds
      _scheduleWeeklyNotification(); // schedule the next notification
    }

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    _scheduleWeeklyNotification();
    generateRandomSurveyData();
  }
Future<List<HealthDataPoint>> getHealthData() async{
  List<HealthDataPoint> healthData = [];
  var types =  [
    HealthDataType.STEPS,
    HealthDataType.HEART_RATE
  ];

  bool granted = await health.requestAuthorization(types);

  if (granted) {
    DateTime startDate = DateTime.now().subtract(Duration(days: 7));
    DateTime endDate = DateTime.now();

    try {
      healthData = await health.getHealthDataFromTypes(startDate, endDate, types);
    } catch (e) {
      print('Error fetching health data: $e');
    }
  } else {
    print('Authorization not granted');
  }
  for (var data in healthData) {
    print('Type: ${data.typeString} | Value: ${data.value} | Unit: ${data.unitString} | Date: ${data.dateFrom}');
  }

  return healthData;
}

  // generate and send random data
  Future<void> generateRandomSurveyData() async {
    // Random number generator
    final random = Random();

    // DateTime today
    DateTime today = DateTime(2023, 5, 5);

    // Iterate through the last 2 months (60 days)
    for (int i = 0; i < 63; i + 7) {
      // Generate random survey data
      Map<String, dynamic> surveyMap = {
        'Interest Deviation': 1 + random.nextDouble() * 4,
        'Depression': 1 + random.nextDouble() * 4,
        'Sleep': 1 + random.nextDouble() * 4,
        'Social': 1 + random.nextDouble() * 4,
        'Focus': 1 + random.nextDouble() * 4,
        'Irritability': 1 + random.nextDouble() * 4,
        'ObsessionAddiction': 1 + random.nextDouble() * 4,
        'Suicidality': 1 + random.nextDouble() * 4,
        'Movement': 1 + random.nextDouble() * 4,
      };

      // Calculate the createdAt date by subtracting 'i' days from today
      DateTime createdAt = today.subtract(Duration(days: i));

      // Create a SurveyData object
      SurveyData surveyData = SurveyData(
        createdAt: createdAt,
        surveyMap: surveyMap,
        userEmail: widget.userEmail,
      );

      // Send the survey data to the backend
      // Replace this line with the code to send surveyData to your backend
      await sendSurveyDataToBackend(surveyData);
    }
  }

  // fetch random data
  Future<void> sendSurveyDataToBackend(SurveyData surveyData) async {

    if (widget.userEmail == null) {
    print('Error: userEmail is null in homepage');
    return;
    }

    String apiUrl =
        "https://your-backend-api-url.com"; // Replace with your backend API URL

    // Convert the SurveyData object to a JSON string
    String jsonString = jsonEncode(surveyData.toJson());

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'userEmail': widget.userEmail ?? '',
      },
      body: jsonString,
    );

    if (response.statusCode != 200) {
      print("Error sending survey data: ${response.statusCode}");
    }
  }
  void printHealthData(List<HealthDataPoint> healthData) {
    for (var data in healthData) {
      print('Type: ${data.typeString} | Value: ${data.value} | Unit: ${data.unitString} | Date: ${data.dateFrom}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: const Text("Home Page"),
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            )),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // widget display for steps
                Card(
                    color: Color.fromARGB(90, 121, 146, 158),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: const Text('Weekly Screentime: 15 hours',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                      ],
                    )),
                // widget display for steps
                ElevatedButton(
                  child: Text('Fetch Health Data'),
                  onPressed: () async {
                    List<HealthDataPoint> healthData = await getHealthData();
                    printHealthData(healthData);
                  },
                ),
                Card(
                    color: Color.fromARGB(90, 121, 146, 158),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: const Text('Steps This Week: 100',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                      ],
                    )),
                // widget display for heart rate
                Card(
                    color: const Color.fromARGB(90, 121, 146, 158),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: const Text('Weekly Average Heartrate: 69',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                      ],
                    )),
                // widget display for weekly sentiment
                Card(
                    color: Color.fromARGB(90, 121, 146, 158),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: const Text(
                              'Weekly Sentiment: You have been sad this week. {Suggestion}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                      ],
                    )),
                // widget display for surveychart
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: widget.userEmail != null
                            ? SurveyChart(userEmail: widget.userEmail!)
                            : Container(),
                      ),
                    ],
                  ),
                ) // render survey chart
              ],
            ),
          ),
        ),
        drawer: Drawer(
            child: ListView(children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey.shade300),
              child: const Text('Options Menu')),
          ListTile(
              title: const Text('View/Update Contacts'),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ContactsPage(userEmail: widget.userEmail)),
                );
                try {
                  await updateContacts(widget.userEmail, contacts);
                  print('Contacts updated successfully');
                } catch (e) {
                  print('Error updating contacts: $e');
                }
              }),
          ListTile(
              title: const Text('Take weekly survey'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SurveyPage(userEmail: widget.userEmail)),
                );
              }
              // Send the update request when the user navigates back

              ),
          ListTile(
              title: const Text('Signout'),
              onTap: () {
                _handleSignOut(context);
              }),
        ])));
  }
}

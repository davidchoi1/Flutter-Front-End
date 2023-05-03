import 'package:circle_app/pages/authpage.dart';
import 'package:circle_app/pages/surveypage.dart';
import 'package:circle_app/pages/contactspage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../classes/contact.dart';
import '../components/surveychart.dart';

class HomePage extends StatefulWidget {
  final String? userEmail;
  const HomePage({super.key, this.userEmail = ''});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  List<Contact> contacts = List.empty(growable: true);
  

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
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
    Uri.parse('https://your-api-url/contacts/update'), // Replace with your API endpoint
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
      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics);
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
  }



  @override
  Widget build(BuildContext context) {

    print('Email: ${widget.userEmail}');
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
                Card(
                    // widget display for steps
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
                Card(
                    // widget display for steps
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
                Card(
                    // widget display for heart rate
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
                Card(
                    color: Color.fromARGB(90, 121, 146,
                        158), // widget display for weekly sentiment
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
                  widget.userEmail != null ? SurveyChart(userEmail: widget.userEmail!) : Container()                      // render survey chart
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
                  MaterialPageRoute(builder: (context) => SurveyPage(userEmail: widget.userEmail)),
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

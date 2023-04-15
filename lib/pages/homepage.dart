import 'package:circle_app/pages/authpage.dart';
import 'package:circle_app/pages/surveypage.dart';
import 'package:circle_app/pages/contactspage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:circle_app/components/linechart.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final data = [
    MyData(0, 5),
    MyData(1, 10),
    MyData(2, 8),
    MyData(14, 3),
    MyData(7, 16),
    MyData(4, 3),
    MyData(11, 9),
  ];

  // sign user out function
  void _handleSignOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AuthPage()),
      (route) => false,
    );
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
                Card(
                    // linechart
                    color: Color.fromARGB(90, 121, 146, 158),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: const Text('Mental Health Historical Data',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                        Container(
                            height: 300,
                            child: MyLineChart(data, animate: true)),
                      ],
                    )),
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactsPage()),
                );
              }),
          ListTile(
              title: const Text('Take weekly survey'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SurveyPage()),
                );
              }),
          ListTile(
              title: const Text('Signout'),
              onTap: () {
                _handleSignOut(context);
              }),
        ])));
  }
}

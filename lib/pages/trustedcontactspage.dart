import 'package:circle_app/pages/homepage.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Contacts extends StatelessWidget {
  const Contacts({Key? key}) : super(key: key);

  // sign user out function
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contacts"),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: const MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  String name = "";
  String number = "";
  var contacts = new Map();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: textController1,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Contact Name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: textController2,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Phone Number',
            ),
          ),
        ),
        Center(
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  name = textController1.text;
                  number = textController2.text;
                  contacts[name] = number;
                  print(contacts);
                  textController1.clear();
                  textController2.clear();
                });
              },
              child: const Text("add contact")),
        ),
      ],
    );
  }
}

// IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const HomePage()),
          //     );
          //   },
          //   icon: Icon(Icons.arrow_back),
          // )
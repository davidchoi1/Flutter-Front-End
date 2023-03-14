import 'package:circle_app/pages/surveypage.dart';
import 'package:flutter/material.dart';

import '../components/button.dart';
import '../components/textfield.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  //navigate to next page
  void _navigateToNext(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SurveyPage()),
  );
}
  // controllers for textfields
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dobController = TextEditingController();
  final civilController = TextEditingController();
  final genderController = TextEditingController();
  final numberController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();
  final countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Information"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // personal information text
              const Text("Let's get your personal information for your account!",
                  style: TextStyle(
                    color: Color.fromARGB(255, 79, 77, 77),
                    fontSize: 16,
                  )),
              const SizedBox(height: 20),

              // name text
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text("Name*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // email textfield
              MyTextField(
                controller: firstNameController,
                hintText: "First Name",
                obscureText: false,
              ),
              const SizedBox(height: 10),
              // password textfield
              MyTextField(
                controller: lastNameController,
                hintText: "Last Name",
                obscureText: false,
              ),
              const SizedBox(height: 50),

              // dob text
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text("Date of Birth*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // confirm password textfield
              MyTextField(
                controller: dobController,
                hintText: "Ex: 10/18/1993",
                obscureText: false,
              ),
              const SizedBox(height: 50),

              // Civil Status text
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text("Civil status*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // civil status textfield
              MyTextField(
                controller: civilController,
                hintText: "Single/Married/Other",
                obscureText: false,
              ),
              const SizedBox(height: 50),

              // gender text
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text("Gender",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // gender textfield
              MyTextField(
                controller: civilController,
                hintText: "Male/Female/Other",
                obscureText: false,
              ),
              const SizedBox(height: 50),

              // phone number text
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text("Phone number",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // phone number textfield
              MyTextField(
                controller: civilController,
                hintText: "Ex: 1-213-344-9081",
                obscureText: false,
              ),
              const SizedBox(height: 50),





              // address text
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text("Residence*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // street address textfield
              MyTextField(
                controller: streetController,
                hintText: "Street number and name",
                obscureText: false,
              ),
              const SizedBox(height: 10),
              // city textfield
              MyTextField(
                controller: cityController,
                hintText: "City",
                obscureText: false,
              ),
              const SizedBox(height: 10),
              // State textfield
              MyTextField(
                controller: stateController,
                hintText: "State",
                obscureText: false,
              ),
              const SizedBox(height: 10),
              // zip code textfield
              MyTextField(
                controller: zipController,
                hintText: "Zip Code",
                obscureText: false,
              ),
              const SizedBox(height: 10),
              // country textfield
              MyTextField(
                controller: countryController,
                hintText: "Country",
                obscureText: false,
              ),
              const SizedBox(height: 10),

                    // continue button
               Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyButton(onTap:() => _navigateToNext(context), message: "Continue Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

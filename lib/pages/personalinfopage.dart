import 'package:circle_app/pages/surveypage.dart';
import 'package:flutter/material.dart';
import 'package:circle_app/components/dropdown.dart';
import '../components/button.dart';
import '../components/textfield.dart';
import 'package:flutter/cupertino.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  // controllers for textfields
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final numberController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();
  final countryController = TextEditingController();

  //string variables to hold civil status and gender
  late String civilStatus, gender;

  //datetime variable
  DateTime _dateTime = DateTime.utc(1993, 10, 18);

  //navigate to next page
  void _navigateToNext(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SurveyPage()),
    );
  }

  // date picker for date of birth
  void _showDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.utc(1993, 10, 18),
        firstDate: DateTime(1900),
        lastDate: DateTime(2005),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary:
                    Color.fromRGBO(224, 224, 224, 1), // Header background color
                onPrimary: Colors.black, // Header text color
                surface: Color.fromARGB(
                    255, 212, 155, 155), // Selected date background color
                onSurface: Colors.black54, // Selected date text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.black87, // Action button text color
                ),
              ),
            ),
            child: child!,
          );
        }).then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              const Text(
                  "Let's get your personal information for your account!",
                  style: TextStyle(
                    color: Color.fromARGB(255, 79, 77, 77),
                    fontSize: 16,
                  )),
              const SizedBox(height: 20),

              // name text
              Row(
                children: const [
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
                children: const [
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
              // Date of Birth - date picker
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SizedBox(
                  height: 50,
                  child: MaterialButton(
                      onPressed: _showDatePicker,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${_dateTime.month}/${_dateTime.day}/${_dateTime.year} (Click to Change)',
                          style: const TextStyle(
                              color: Color.fromRGBO(158, 158, 158, 1),
                              fontSize: 16),
                        ),
                      )),
                ),
              ),
              const SizedBox(height: 50),

              // Civil Status text
              Row(
                children: const [
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
              // civil status dropdownbuttonwidget
              DropdownButtonWidget<String>(
                items: const ['Single', 'Married', 'Divorced', 'Widowed'],
                onItemSelected: (value) {
                  civilStatus = value;
                },
                hintText: 'Choose Civil Status',
              ),

              const SizedBox(height: 50),

              // gender text
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text("Gender*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // gender dropdownbuttonwidget
              DropdownButtonWidget<String>(
                  items: const [
                    'Male',
                    'Female',
                    'Other',
                    'Prefer Not to Answer'
                  ],
                  onItemSelected: (value) {
                    civilStatus = value;
                  },
                  hintText: 'Choose Gender'),
              const SizedBox(height: 50),

              // phone number text
              Row(
                children: const [
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
                controller: numberController,
                hintText: "Ex: 1-213-344-9081",
                obscureText: false,
              ),
              const SizedBox(height: 50),

              // address text
              Row(
                children: const [
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
                child: MyButton(
                    onTap: () => _navigateToNext(context),
                    message: "Continue Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

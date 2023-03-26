import 'package:circle_app/pages/surveypage.dart';
import 'package:flutter/material.dart';
import 'package:circle_app/components/dropdown.dart';
import '../components/button.dart';
import '../components/textformfield.dart';

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

  //formkey for input validation
  final _formkey = GlobalKey<FormState>();

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
    return Form(
      key: _formkey,
      child: Scaffold(
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

                // personal information text
                const SizedBox(height: 20),
                const Text(
                    "Let's get your personal information for your account!",
                    style: TextStyle(
                      color: Color.fromARGB(255, 79, 77, 77),
                      fontSize: 16,
                    )),
                const SizedBox(height: 20),

                // name textfields
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
                MyTextFormField(
                  controller: firstNameController,
                  hintText: "First Name",
                  inputError: "Please include first name",
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextFormField(
                  controller: lastNameController,
                  hintText: "Last Name",
                  inputError: "Please include last name",
                  obscureText: false,
                ),
                const SizedBox(height: 50),

                // Date picker
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
                                color: Colors.black,
                                fontSize: 16),
                          ),
                        )),
                  ),
                ),
                const SizedBox(height: 50),

                // Civil Status dropdown button
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
                DropdownButtonWidget<String>(
                  items: const ['Single', 'Married', 'Divorced', 'Widowed'],
                  onItemSelected: (value) {
                    civilStatus = value;
                  },
                  hintText: 'Choose Civil Status',
                  inputError: 'Please Pick Civil Status',
                  
                ),
                const SizedBox(height: 50),

                // gender dropdown button
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
                    hintText: 'Choose Gender',
                    inputError: 'Please choose gender',
                ),
                const SizedBox(height: 50),

                // phone number textfield
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text("Phone number*",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                MyTextFormField(
                  controller: numberController,
                  hintText: "Ex: 2133449081",
                  inputError: "Please enter phone number",
                  obscureText: false,
                ),
                const SizedBox(height: 50),

                // address textfield
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
                MyTextFormField(
                  controller: streetController,
                  hintText: "Street number and name",
                  inputError: "Please complete address",
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                // city textfield
                MyTextFormField(
                  controller: cityController,
                  hintText: "City",
                  inputError: "Please complete address",
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                // State textfield
                MyTextFormField(
                  controller: stateController,
                  hintText: "State",
                  inputError: "Please complete address",
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                // zip code textfield
                MyTextFormField(
                  controller: zipController,
                  hintText: "Zip Code",
                  inputError: "Please complete address",
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                // country textfield
                MyTextFormField(
                  controller: countryController,
                  hintText: "Country",
                  inputError: "Please complete address",
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                // continue button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MyButton(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          _navigateToNext(context);
                        } else {
                          
                        }
                      },
                      message: "Continue Next"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

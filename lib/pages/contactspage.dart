import 'package:flutter/material.dart';
import '../classes/contact.dart';
import '../components/textformfield.dart';


class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  //formkey for input validation
  final _formkey = GlobalKey<FormState>();

  List<Contact> contacts =
      List.empty(growable: true); // list to stored created contacts

  // controllers for textfields
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  int selectedIndex = -1;

  // regular expression for phone number input validation
  final RegExp phoneRegex = RegExp(r'^\d{10}$');

  // phone number input validation function
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number in example format';
    }
    return null;
  }

  Widget getRow(index) {
    // function to create and manage contact list tile
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Card(
        child: ListTile(
            leading: CircleAvatar(
              // circular avatar for created contacts
              backgroundColor: index % 2 == 0 ? Colors.blueGrey : Colors.amber,
              foregroundColor: Colors.white,
              child: Text(
                contacts[index].name[0],                                              
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // contact name and number representation in created list tile
                Text(contacts[index].name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),                           // !! must insert information from json here !! 
                Text(contacts[index].number),
              ],
            ),
            trailing: SizedBox(
              // edit and delete buttons in created list tiles
              width: 70,
              child: Row(
                children: [
                  InkWell(
                      onTap: (() {
                        nameController.text = contacts[index].name.trim();
                        numberController.text = contacts[index].number.trim();
                        setState(
                          () {
                            selectedIndex = index;
                          },
                        );
                      }),
                      child: const Icon(Icons.edit)),
                  InkWell(
                      onTap: (() {
                        setState(() {
                          contacts.removeAt(index);
                        });
                      }),
                      child: const Icon(Icons.delete)),
                ],
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
          appBar: AppBar(                                                                     // appbar
            title: const Text("Trusted Contacts"),
            backgroundColor: Colors.black,
          ),
          backgroundColor: Colors.grey[300],
          body: Column(
            children: [
              const SizedBox(height: 20),
              
              MyTextFormField(                                                                // name textfield
                controller: nameController, 
                hintText: 'Contact Name', 
                inputError: 'Please include name', 
                obscureText: false
                ),
              const SizedBox(height: 20),
              
              Padding(                                                                        // number textfield
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  controller: numberController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 56, 52, 52)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Ex: 2133449081",
                    hintStyle: TextStyle(color: Color.fromRGBO(158, 158, 158, 1)),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: validatePhoneNumber,
                ),
              ),
              const SizedBox(height: 20),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(                                                         // add button
                    onPressed: () {
                      String name = nameController.text.trim();
                      String number = numberController.text.trim();
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          nameController.text = '';
                          numberController.text = '';
                          contacts.add(Contact(name: name, number: number));
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                    ),
                    child: const Text('Add'),
                  ),
                  ElevatedButton(                                                         // update button
                      onPressed: () {
                        String name = nameController.text.trim();
                        String number = numberController.text.trim();
                        if (_formkey.currentState!.validate()) {
                            setState(() {
                              nameController.text = '';
                              numberController.text = '';
                              contacts[selectedIndex].name = name;
                              contacts[selectedIndex].number = number;
                              selectedIndex = -1;
                            });
                          }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16), // Rounded corners
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16), // Button padding
                      ),
                      child: const Text('Update')), // Button text
                ],
              ),
              const SizedBox(height: 20),
              contacts.isEmpty
                  ? const Text('No Contacts yet...',
                      style: TextStyle(fontSize: 22))
                  : Expanded(
                      child: ListView.builder(
                          itemCount: contacts.length,
                          itemBuilder: (context, index) => getRow(index)),
                    )
            ],
          )),
    );
  }
}

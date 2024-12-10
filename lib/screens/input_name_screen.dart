import 'package:flutter/material.dart';
import 'notification_screen.dart';

class InputNameScreen extends StatefulWidget {
  const InputNameScreen({super.key});

  @override
  _InputNameScreenState createState() => _InputNameScreenState();
}

class _InputNameScreenState extends State<InputNameScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;

  void _checkFormValidity() {
    // Check if form is valid and update button state
    setState(() {
      isButtonEnabled = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Your Name",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF171717),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Please provide your name to personalize your experience.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF737373),
                    ),
                  ),
                ],
              ),
            ),
            // Form for Name Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Form(
                key: _formKey,
                onChanged: _checkFormValidity, // Check form validity on field change
                child: Column(
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: "First Name",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: "Last Name",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isButtonEnabled
                            ? () {
                                // Save data (e.g., update state)
                                final firstName = _firstNameController.text;
                                final lastName = _lastNameController.text;

                                // Print the name for debugging
                                print('First Name: $firstName');
                                print('Last Name: $lastName');

                                // Navigate to the Notification Screen
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotificationScreen(
                                      firstName: firstName,
                                      lastName: lastName,
                                    ),
                                  ),
                                );
                              }
                            : null, // Disable button if form is not valid
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF523AE4),
                          foregroundColor: Colors.white, // Set the color to #523AE4
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text("Submit"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/avatar.jpg'),
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          controller: oldPasswordController,
                          decoration: InputDecoration(
                            hintText: 'Old Password',
                            labelText: 'Old Password',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your old password';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: newPasswordController,
                          decoration: InputDecoration(
                            hintText: 'New Password',
                            labelText: 'New Password',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a new password';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            hintText: 'Confirm New Password',
                            labelText: 'Confirm New Password',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your new password';
                            }
                            if (value != newPasswordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Perform password change logic here
                              print('Password change request submitted');
                              // Clear text fields after submission
                              oldPasswordController.clear();
                              newPasswordController.clear();
                              confirmPasswordController.clear();
                              // Navigate back to previous screen
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueGrey,
                            side: BorderSide(color: Colors.black),
                          ),
                          child: Text(
                            'Change Password',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

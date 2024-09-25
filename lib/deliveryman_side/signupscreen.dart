import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'SignInScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> _register() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _formKey.currentState?.fields['email']?.value,
          password: _formKey.currentState?.fields['password']?.value,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'name': _formKey.currentState?.fields['name']?.value,
          'email': _formKey.currentState?.fields['email']?.value,
          'phone': _formKey.currentState?.fields['phone']?.value,
        });

        print('Registration successful');
        // Clear the form fields
        _formKey.currentState?.reset();
        // Navigate to SignInScreen on successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('The account already exists for that email.')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration failed: ${e.message}')),
          );
        }
      }
    } else {
      print('Validation failed');
    }
  }

  String? _validatePassword(value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 10),
                Center(
                  child: Image.asset(
                    'assets/avatar.jpg', // Adjust path based on your actual asset location
                    height: 100, // Adjusted height of the avatar image
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          FormBuilderTextField(
                            name: 'name',
                            decoration:
                                const InputDecoration(labelText: 'Name'),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: 'email',
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email(),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: 'phone',
                            decoration: const InputDecoration(
                                labelText: 'Phone Number'),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.numeric(),
                              FormBuilderValidators.minLength(10),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: 'password',
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              (value) => _validatePassword(value),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: 'confirm_password',
                            decoration: const InputDecoration(
                                labelText: 'Confirm Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value !=
                                  _formKey.currentState?.fields['password']
                                      ?.value) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              'Register',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInScreen()),
                              );
                            },
                            child:
                                const Text('Already have an account? Sign In'),
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
      ),
    );
  }
}

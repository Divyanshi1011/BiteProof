import 'package:biteproof/deliveryman_side/homepage.dart';
import 'package:biteproof/deliveryman_side/signupscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _rememberMe = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signIn() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final email = _formKey.currentState?.fields['email']?.value;
      final password = _formKey.currentState?.fields['password']?.value;

      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        // Clear the form fields
        _formKey.currentState?.reset();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user found for that email.')),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Wrong password provided.')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.message}')),
          );
        }
      }
      print('Sign-In successful');
    } else {
      print('Validation failed');
    }
  }

  void _recoverPassword() async {
    if (_formKey.currentState?.fields['email']?.value == null ||
        _formKey.currentState?.fields['email']?.value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email first.')),
      );
      return;
    }

    final email = _formKey.currentState?.fields['email']?.value;

    try {
      await _auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password recovery email sent.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 255, 255, 255), // Set the background color
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 10),
            Center(
              child: Image.asset(
                'assets/avatar.jpg', // Adjust path based on your actual asset location
                height: 100, // Adjusted height of the logo
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(8.0), // Reduced border radius
              ),
              margin: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 8.0), // Add margin
              shadowColor: const Color.fromARGB(
                  255, 71, 19, 19), // Set the shadow color to black
              child: FormBuilder(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(12.0), // Reduced padding
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FormBuilderTextField(
                        name: 'email',
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(
                                  255, 1, 2, 2)), // Customize label color
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ]),
                      ),
                      const SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'password',
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(
                                  255, 0, 0, 0)), // Customize label color
                        ),
                        obscureText: true,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      const SizedBox(height: 10),
                      FormBuilderCheckbox(
                        name: 'remember_me',
                        initialValue: _rememberMe,
                        title: const Text('Remember me'),
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _signIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey, // Button color
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: _recoverPassword,
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: Colors.blueGrey), // Text button color
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()),
                          );
                        },
                        child: const Text(
                          'New user? Sign Up',
                          style: TextStyle(color: Colors.blueGrey),
                          // style: TextStyle(color: Colors.black),
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
    );
  }
}

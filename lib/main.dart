import 'package:biteproof/customer_side/welcome_customer.dart';
import 'package:biteproof/deliveryman_side/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyBT1sJ3lKarBmo_LRghtaCAHvPgew3dwQU',
    appId: '1:527047135966:android:749a52e754f6afb813284f',
    messagingSenderId: '527047135966',
    projectId: 'biteproof-13317',
    storageBucket: 'biteproof-13317.appspot.com',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // Define primary and contrast colors
  static const Color primaryColor = Color.fromARGB(255, 28, 23, 47);
  static const Color contrastColor = Colors.white;
  static const Color buttonColor = Colors.blueGrey;

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'biteproof',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
      routes: {
        '/customer': (context) => const CustomerWelcomeScreen(),
        '/delivery': (context) => const WelcomeScreen(),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyApp.primaryColor,
        toolbarHeight: 0, // This will hide the AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Replace 'assets/logo.png' with the path to your logo
            Image.asset(
              'assets/logo.png',
              height: 70, // Adjust the height to make the logo smaller
            ),
            const SizedBox(height: 20), // Space between logo and buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/customer');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, // Set text color to black
                backgroundColor: MyApp.buttonColor,
              ),
              child: const Text('Customer'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/delivery');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, // Set text color to black
                backgroundColor: MyApp.buttonColor,
              ),
              child: const Text('Delivery'),
            ),
          ],
        ),
      ),
    );
  }
}

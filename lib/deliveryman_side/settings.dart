import 'package:biteproof/deliveryman_side/changepassword.dart';
import 'package:biteproof/deliveryman_side/orderscreen.dart';
import 'package:biteproof/deliveryman_side/profilepage.dart';
import 'package:biteproof/deliveryman_side/rateapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/default.png'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Divi Rai',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'raidivi952@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.black),
              title: const Text('My Profile',
                  style: TextStyle(color: Colors.black)),
              trailing:
                  const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyProfileScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.list, color: Colors.black),
              title: const Text('Order', style: TextStyle(color: Colors.black)),
              trailing:
                  const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrdersScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.black),
              title: const Text('Rate the App',
                  style: TextStyle(color: Colors.black)),
              trailing:
                  const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RateAppScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.black),
              title: const Text('Change Password',
                  style: TextStyle(color: Colors.black)),
              trailing:
                  const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

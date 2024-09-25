import 'package:flutter/material.dart';

class EarningsPaymentsBody extends StatefulWidget {
  const EarningsPaymentsBody({super.key});

  @override
  _EarningsPaymentsBodyState createState() => _EarningsPaymentsBodyState();
}

class _EarningsPaymentsBodyState extends State<EarningsPaymentsBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.blueGrey,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: const Column(
        children: <Widget>[
          EarningsSummary(),
          PaymentHistory(), // Removed StreamBuilder and Firebase Firestore usage
          //WithdrawEarningsButton(),
        ],
      ),
    );
  }
}

class EarningsSummary extends StatelessWidget {
  const EarningsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(10),
      color: Colors.blueGrey,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Earnings Summary',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            Divider(color: Colors.black),
            ListTile(
              title:
                  Text('Daily Earnings', style: TextStyle(color: Colors.black)),
              trailing: Text('\$100', style: TextStyle(color: Colors.black)),
            ),
            ListTile(
              title: Text('Weekly Earnings',
                  style: TextStyle(color: Colors.black)),
              trailing: Text('\$700', style: TextStyle(color: Colors.black)),
            ),
            ListTile(
              title: Text('Monthly Earnings',
                  style: TextStyle(color: Colors.black)),
              trailing: Text('\$3000', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentHistory extends StatelessWidget {
  const PaymentHistory({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulated data for Payment History
    List<Map<String, dynamic>> payments = [
      {
        'amount': 500,
        'date': DateTime.now().subtract(const Duration(days: 3)),
        'status': 'Paid'
      },
      {
        'amount': 800,
        'date': DateTime.now().subtract(const Duration(days: 10)),
        'status': 'Paid'
      },
      {
        'amount': 1200,
        'date': DateTime.now().subtract(const Duration(days: 25)),
        'status': 'Pending'
      },
    ];

    return Expanded(
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Payment History',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const Divider(color: Colors.black),
              Expanded(
                child: ListView.builder(
                  itemCount: payments.length,
                  itemBuilder: (context, index) {
                    var payment = payments[index];
                    return ListTile(
                      title: Text('Payment: \$${payment['amount']}',
                          style: const TextStyle(color: Colors.black)),
                      subtitle: Text(
                          'Date: ${payment['date'].toString().substring(0, 10)}',
                          style: const TextStyle(color: Colors.black)),
                      trailing: Text('Status: ${payment['status']}',
                          style: const TextStyle(color: Colors.black)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

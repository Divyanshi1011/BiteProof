import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> orders = [
    {
      'id': '123456',
      'location': '123 Main St',
      'status': 'Completed',
      'payment': 'UPI',
    },
    {
      'id': '234567',
      'location': '456 Elm St',
      'status': 'Ongoing',
      'payment': 'Cash',
    },
    {
      'id': '345678',
      'location': '789 Oak St',
      'status': 'Pending',
      'payment': 'Credit Card',
    },
    {
      'id': '456789',
      'location': '101 Pine St',
      'status': 'Cancelled',
      'payment': 'Debit Card',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Orders'),
      ),
      body: Container(
        color: Colors.grey[300],
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildOrderDetailRow('Order ID', order['id']!),
                            const SizedBox(height: 8),
                            _buildOrderDetailRow(
                                'Location', order['location']!),
                            const SizedBox(height: 8),
                            _buildOrderDetailRow('Payment', order['payment']!),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _getStatusColor(order['status']!),
                        ),
                        child: Text(order['status']!),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOrderDetailRow(String title, String value) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Ongoing':
        return Colors.orange;
      case 'Pending':
        return Colors.blue;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: OrdersScreen(),
  ));
}

import 'package:flutter/material.dart';
import 'order.dart'; // Import the Order class

class OrderDetailScreen extends StatelessWidget {
  final Order order;
  final Function(Order, String) onUpdateStatus;
  final Function(Order) onAccept;
  final Function(Order) onReject;

  const OrderDetailScreen({
    super.key,
    required this.order,
    required this.onUpdateStatus,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer: ${order.customerName}'),
            const SizedBox(height: 8),
            Text('Pickup Location: ${order.pickupLocation}'),
            const SizedBox(height: 8),
            Text('Drop-off Location: ${order.dropOffLocation}'),
            const SizedBox(height: 8),
            Text('Payment Info: ${order.paymentInfo}'),
            const SizedBox(height: 16),
            if (order.status == 'Pending') ...[
              ElevatedButton(
                onPressed: () {
                  onAccept(order);
                  Navigator.pop(context);
                },
                child: const Text('Accept Order'),
              ),
              ElevatedButton(
                onPressed: () {
                  onReject(order);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Reject Order'),
              ),
            ] else if (order.status == 'Accepted') ...[
              ElevatedButton(
                onPressed: () {
                  onUpdateStatus(order, 'Picked Up');
                  Navigator.pop(context);
                },
                child: const Text('Mark as Picked Up'),
              ),
            ] else if (order.status == 'Picked Up') ...[
              ElevatedButton(
                onPressed: () {
                  onUpdateStatus(order, 'Delivered');
                  Navigator.pop(context);
                },
                child: const Text('Mark as Delivered'),
              ),
            ],
            const SizedBox(height: 16),
            Text('Order Status: ${order.status}'),
          ],
        ),
      ),
    );
  }
}

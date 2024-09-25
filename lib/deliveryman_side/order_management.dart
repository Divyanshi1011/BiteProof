import 'package:flutter/material.dart';
import 'order.dart'; // Import the Order class
import 'order_detail.dart'; // Import the OrderDetailScreen

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  _OrderManagementScreenState createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  List<Order> activeOrders = [
    Order(
      id: 1,
      customerName: 'John Doe',
      pickupLocation: '123 Main St',
      dropOffLocation: '456 Elm St',
      paymentInfo: 'Paid via Credit Card',
      details: 'Order #1 details',
      status: 'Active',
    ),
  ];
  List<Order> completedOrders = [];
  List<Order> cancelledOrders = [];

  void _updateOrderStatus(Order order, String status) {
    setState(() {
      order.status = status;
      if (status == 'Completed') {
        completedOrders.add(order);
        activeOrders.remove(order);
      } else if (status == 'Cancelled') {
        cancelledOrders.add(order);
        activeOrders.remove(order);
      }
    });
  }

  void _acceptOrder(Order order) {
    setState(() {
      order.status = 'Accepted';
    });
  }

  void _rejectOrder(Order order) {
    _updateOrderStatus(order, 'Cancelled');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order Management'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrderList(activeOrders, true),
            _buildOrderList(completedOrders, false),
            _buildOrderList(cancelledOrders, false),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(List<Order> orders, bool isActive) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
              'Order #${orders[index].id} - ${orders[index].customerName}'),
          subtitle: Text(
              'Pickup: ${orders[index].pickupLocation} \nDrop-off: ${orders[index].dropOffLocation}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetailScreen(
                  order: orders[index],
                  onUpdateStatus: _updateOrderStatus,
                  onAccept: _acceptOrder,
                  onReject: _rejectOrder,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

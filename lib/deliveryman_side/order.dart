class Order {
  final int id;
  String customerName;
  String pickupLocation;
  String dropOffLocation;
  String paymentInfo;
  String status;
  String details;

  Order({
    required this.id,
    this.customerName = '',
    this.pickupLocation = '',
    this.dropOffLocation = '',
    this.paymentInfo = '',
    this.status = 'Pending',
    this.details = '',
  });
}

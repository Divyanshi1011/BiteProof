import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer Support Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomerSupportPage(),
    );
  }
}

class CustomerSupportPage extends StatefulWidget {
  @override
  _CustomerSupportPageState createState() => _CustomerSupportPageState();
}

class _CustomerSupportPageState extends State<CustomerSupportPage> {
  int _selectedIndex = 0;

  static const List<String> _pageTitles = [
    'Issue Raised',
    'Status',
  ];

  final _formKey = GlobalKey<FormState>();
  TextEditingController _orderIDController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  File? _issueImage;

  Future<void> _takeIssuePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _issueImage = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _issueImage != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Issue Reported Successfully!'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  _clearForm(); // Clear the form after submission
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _clearForm() {
    _orderIDController.clear();
    _descriptionController.clear();
    setState(() {
      _issueImage = null;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showResult(String status) {
    String title = 'Completion Result';
    String message;

    switch (status) {
      case 'Pending':
        message =
            'Progress: Your request is pending. Please wait for some time for the result.';
        break;
      case 'Ongoing':
        message =
            'Progress: Your request is being processed. We will let you know once it is completed.';
        break;
      case 'Completed - Wrong Claim':
        message = '80% matches: Customer claim is wrong.';
        break;
      case 'Completed - True Claim':
        message =
            '75% matches: Customer is telling the truth. Provide refund or reissue of food.';
        break;
      default:
        message = 'Unknown status';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Support'),
        backgroundColor: Colors.blue,
      ),
      body: _selectedIndex == 0 ? _buildIssueRaisedForm() : _buildStatusPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.error),
            label: 'Issue Raised',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Status',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildIssueRaisedForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Problem Raised',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _orderIDController,
                    decoration: InputDecoration(
                      labelText: 'Order ID',
                      hintText: 'Enter your order ID',
                      prefixIcon: Icon(Icons.shopping_cart),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Order ID';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter issue description',
                      prefixIcon: Icon(Icons.description),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Upload Photo:',
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () async {
                          await _takeIssuePicture();
                        },
                      ),
                    ],
                  ),
                  if (_issueImage != null) ...[
                    SizedBox(height: 16),
                    Image.file(
                      _issueImage!,
                      height: 200,
                    ),
                  ],
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Order Status',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                _buildStatusItem('Order ID: 12345', 'Pending'),
                SizedBox(height: 16.0), // Add space between items
                _buildStatusItem('Order ID: 67890', 'Ongoing'),
                SizedBox(height: 16.0), // Add space between items
                _buildStatusItem('Order ID: 54321', 'Completed - Wrong Claim'),
                SizedBox(height: 16.0), // Add space between items
                _buildStatusItem('Order ID: 98765', 'Completed - True Claim'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusItem(String orderId, String status) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(orderId),
        subtitle: Text('Status: $status'),
        trailing: ElevatedButton(
          onPressed: () {
            _showResult(status);
          },
          child: Text('Result'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        ),
      ),
    );
  }
}

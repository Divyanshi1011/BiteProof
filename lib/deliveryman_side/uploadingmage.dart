import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadImagePage extends StatefulWidget {
  const UploadImagePage({super.key});

  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  XFile? _image1;
  XFile? _image2;
  final ImagePicker _picker = ImagePicker();
  String status1 = 'Pending';
  String status2 = 'Pending';

  Future<void> _pickImage(int boxNumber) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (boxNumber == 1) {
        _image1 = image;
      } else {
        _image2 = image;
      }
    });
  }

  void _showSuccessMessage(int boxNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Photo successfully submitted!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  if (boxNumber == 1) {
                    status1 = 'Completed';
                  } else {
                    status2 = 'Completed';
                  }
                });
                Navigator.of(context).pop(); // Close the dialog
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
        title: const Text('Order Information'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildOrderCard(
              title: 'Restaurant',
              orderId: '123456',
              location: 'Restaurant A - 123 Main St, City, Country',
              status: status1,
              note: 'Photo must be from upside only',
              image: _image1,
              onCameraTap: () => _pickImage(1),
              onSubmit: () => _showSuccessMessage(1),
            ),
            const SizedBox(height: 20),
            _buildOrderCard(
              title: 'Restaurant',
              orderId: '678910',
              location: 'Restaurant B - 456 Elm St, City, Country',
              status: status2,
              note: 'Photo must be from upside only',
              image: _image2,
              onCameraTap: () => _pickImage(2),
              onSubmit: () => _showSuccessMessage(2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard({
    required String title,
    required String orderId,
    required String location,
    required String status,
    required String note,
    XFile? image,
    required VoidCallback onCameraTap,
    required VoidCallback onSubmit,
  }) {
    return Card(
      color: Colors.blueGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Order ID: $orderId',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              'Location: $location',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              'Status: $status',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              'Note: $note',
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 2, 82, 4),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                  ),
                  onPressed: onCameraTap,
                ),
                if (image != null) ...[
                  const SizedBox(width: 10),
                  Image.file(
                    File(image.path),
                    width: 50,
                    height: 50,
                  ),
                ],
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: onSubmit,
                  child: const Text('Submit/Confirm'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blueGrey,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

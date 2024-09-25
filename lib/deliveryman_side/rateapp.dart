import 'package:flutter/material.dart';

class RateAppScreen extends StatefulWidget {
  @override
  _RateAppScreenState createState() => _RateAppScreenState();
}

class _RateAppScreenState extends State<RateAppScreen> {
  int rating = 0;
  bool facingAppIssue = false;
  bool otherIssue = false;
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Rating', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Rate App',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildStarIcon(1),
                  buildStarIcon(2),
                  buildStarIcon(3),
                  buildStarIcon(4),
                  buildStarIcon(5),
                ],
              ),
              SizedBox(height: 16),
              CheckboxListTile(
                title: Text('Facing app issue'),
                value: facingAppIssue,
                onChanged: (value) {
                  setState(() {
                    facingAppIssue = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Other issue'),
                value: otherIssue,
                onChanged: (value) {
                  setState(() {
                    otherIssue = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (rating > 0) {
                    // Perform submit action
                    String description = descriptionController.text;
                    print('Rating: $rating');
                    print('Facing app issue: $facingAppIssue');
                    print('Other issue: $otherIssue');
                    print('Description: $description');

                    Navigator.pop(context); // Navigate back to previous screen
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please rate the app before submitting.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueGrey,
                  minimumSize: Size(150, 50),
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStarIcon(int index) {
    return IconButton(
      icon: Icon(
        index <= rating ? Icons.star : Icons.star_border,
        color: Colors.yellow,
        size: 36,
      ),
      onPressed: () {
        setState(() {
          rating = index;
        });
      },
    );
  }
}

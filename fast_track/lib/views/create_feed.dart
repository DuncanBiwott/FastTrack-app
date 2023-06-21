import 'package:flutter/material.dart';

class CreateFeedScreen extends StatefulWidget {
  @override
  _CreateFeedScreenState createState() => _CreateFeedScreenState();
}

class _CreateFeedScreenState extends State<CreateFeedScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Feed'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:Theme.of(context).primaryColor, // Set background color
              ),
              onPressed: () {
                String title = _titleController.text;
                String description = _descriptionController.text;

                // Handle feed submission
                // Show a success message to the user
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Feed Posted'),
                      content: Text('Your feed was posted successfully.'),
                      actions: [
                        TextButton(
                          onPressed: () {
// Close the dialog
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Post Feed'),
            ),
          ],
        ),
      ),
    );
  }
}

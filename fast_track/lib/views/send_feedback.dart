import 'package:fast_track/constants/constants.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _feedbackController = TextEditingController();

  void _submitFeedback() {
    String feedback = _feedbackController.text;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thank you!'),
          content: const Text('Your feedback has been submitted.'),
          actions: [
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: Constants().p_button_text),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Clear the feedback text field
                _feedbackController.clear();
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please provide your feedback:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _feedbackController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Enter your feedback',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: Text(
                  'Submit Feedback',
                  style: TextStyle(color: Constants().p_button_text),
                ),
                onPressed: _submitFeedback,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).primaryColor, // Set background color
                ),
              ),
              const SizedBox(height: 32.0),
              const Text(
                'Contact Support:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              const Text('Phone: 123-456-7890'),
              const Text('Email: support@example.com'),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: Text(
                  'Call Support',
                  style: TextStyle(color: Constants().p_button_text),
                ),
                onPressed: () {
                  // TODO: Implement call support functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).primaryColor, // Set background color
                ),
              ),
              ElevatedButton(
                child: Text(
                  'Email Support',
                  style: TextStyle(color: Constants().p_button_text),
                ),
                onPressed: () {
                  // TODO: Implement email support functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).primaryColor, // Set background color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
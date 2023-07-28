import 'package:fast_track/models/notification_response.dart';
import 'package:fast_track/services/api/user_request_services/incident_client.dart';
import 'package:fast_track/views/notification_icon.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool showFullMessage = false;
  String _truncateMessage(String message) {
    final int maxLength = 50; // Define your desired max length here
    if (message.length > maxLength) {
      return message.substring(0, maxLength) + '... Read More';
    }
    return message;
  }

  void _showFullMessageBottomSheet(BuildContext context, String message) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor:
              0.6, // Adjust this value to control the height of the bottom sheet
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Add a close button at the top right corner
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Full Message",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 2,
                    width: 50,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 16),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                  // You can add more content to the bottom sheet as needed
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: FutureBuilder<List<NotificationResponse>>(
        future: IncidentClient()
            .getAllNotifications(perpage: 10, page: 1, context: context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Error handling if API call fails
            return const Center(
              child: Text('Failed to load notifications'),
            );
          } else if (snapshot.hasData) {
            // Use the snapshot data to display the list of notifications
            final notifications = snapshot.data!;
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          _showFullMessageBottomSheet(
                              context, notifications[index].message);
                        },
                        child: Text(
                          showFullMessage
                              ? notifications[index].message
                              : _truncateMessage(notifications[index].message),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No notifications found'),
            );
          }
        },
      ),
    );
  }
}

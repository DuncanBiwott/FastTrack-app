import 'package:fast_track/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/notification_provider.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, _) {
          if (provider.notifications.isEmpty) {
            return const Center(
              child: Text('No New Notifications.'),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: provider.notifications.length,
              itemBuilder: (context, index) {
                final notification = provider.notifications[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Constants().green.withOpacity(0.1),
                  ),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          notification,
                          style: TextStyle(color: Constants().green),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          provider.removeNotification(index);
                    
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}


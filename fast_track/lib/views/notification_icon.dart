import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/notification_provider.dart';
import 'notification_screen.dart';

class NotificationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);
    int unreadNotificationsCount = notificationProvider.notifications.length;

    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.black, size: 24),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  NotificationScreen()),
            );
          },
        ),
        if (unreadNotificationsCount > 0)
          Positioned(
            top: 4,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Text(
                unreadNotificationsCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

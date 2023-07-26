import 'package:flutter/material.dart';

import 'notification_screen.dart';

class NotificationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    int unreadNotificationsCount = 3; 

    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications,color:Colors.white,size: 32,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationScreen()),
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
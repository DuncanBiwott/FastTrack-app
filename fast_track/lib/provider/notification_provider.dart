import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  List<String> notifications = [];

  void addNotification(String notification) {
    notifications.add(notification);
    notifyListeners();
  }

  void removeNotification(int index) {
    notifications.removeAt(index);
    notifyListeners();
  }

  void clearNotifications() {
    notifications.clear();
    notifyListeners();
  }
}


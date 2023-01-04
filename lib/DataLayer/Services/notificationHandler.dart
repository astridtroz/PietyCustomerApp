import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  FlutterLocalNotificationsPlugin? notification;
  AndroidInitializationSettings? androidSetting;
  DarwinInitializationSettings? iOSSetting;
  InitializationSettings? initializationSettings;

  NotificationHandler() {
    notification = FlutterLocalNotificationsPlugin();
    //TODO add notification icon
    androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    iOSSetting = DarwinInitializationSettings(
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(android: androidSetting, iOS: iOSSetting);
    _initialize();
    // _initializeChannelSpecific();
  }

  @deprecated
  AndroidNotificationDetails _androidNotificationDetails() {
    return AndroidNotificationDetails(
      '0',
      'Order',
      // 'Order related notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
  }

  @deprecated
  DarwinNotificationDetails _iOSNotificationDetails() {
    return DarwinNotificationDetails();
  }

  void showNotification({
    required String title,
    required String body,
    // @required platformChannelSpecifics,
  }) {
    notification!.show(
      0,
      "$title",
      "$body",
      _getChannelSpecific(),
    );
  }

  NotificationDetails _getChannelSpecific() {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '0',
      'Order',
      // 'Order related notifications',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      category: AndroidNotificationCategory.reminder,
      // sound: RawResourceAndroidNotificationSound("alarm_clock"),
    );
    DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    return notificationDetails;
  }

  void _initialize() async {
    await notification!.initialize(
      initializationSettings!,
      onSelectNotification: _onSelectNotification,
    );
  }

  Future _onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    //TODO: iOS notifcation implementation
  }
}


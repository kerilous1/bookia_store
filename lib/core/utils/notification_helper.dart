import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin= FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings=AndroidInitializationSettings('@mipmap/ic_launcher');

    //TODO ios drawing initial settings

    const InitializationSettings initSettings=InitializationSettings(
      android: androidSettings,
      //TODO ios
    );

    await _notificationsPlugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
      },
    );

    _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

  }

  static Future<void> showOrderNotification()async {
    const AndroidNotificationDetails androidDetails=AndroidNotificationDetails(
      'order_channel_id',
      'Orders Notifications',
      channelDescription: 'Notifications for successful orders',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      color: Color(0xFF7C3AED),
    );

    const NotificationDetails details = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      id: 0,
      title: 'Order Confirmed',
      body: 'We received your order. It will be delivered within 24 to 48 hours.',
      notificationDetails: details,
    );
  }
}
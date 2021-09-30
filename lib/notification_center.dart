import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationCenter {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;
  var initializationSettingsIOS;
  var initializationSettings;

  void setNotification(TimeOfDay time) async {
    await _dailyNotification(
        0, time, 'Habo', 'Do not forget to check your habits.');
  }

  void setHabitNotification(
      int id, TimeOfDay timeOfDay, String title, String desc) async {
    await _dailyNotification(id, timeOfDay, title, desc);
  }

  void disableNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> _dailyNotification(
      int id, TimeOfDay timeOfDay, String title, String desc) async {
    var time = Time(timeOfDay.hour, timeOfDay.minute, 0);
    await flutterLocalNotificationsPlugin.cancel(id);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'Habo: 0', 'Habo: Habo', 'Habo: Minimalistic habit tracker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        id, title, desc, time, platformChannelSpecifics);
  }

  void initDailyNotification() {
    initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    initializationSettingsIOS = new IOSInitializationSettings();
    initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: null);
  }
}

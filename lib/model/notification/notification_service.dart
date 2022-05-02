import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  int num = 1;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("logo");

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future instantNotification() async {
    print("Entered in instance");
    var android = const AndroidNotificationDetails("id", "channel",
        channelDescription: "description");
    print("Platform");

    var platform = NotificationDetails(
      android: android,
    );
    print("Calling method");
    await _flutterLocalNotificationsPlugin.show(
        num++, "Contest Alert!!!", "Your contest is about to start.", platform,
        payload: "Welcome to demo app");
  }

  Future scheduledNotification(String startTime, int time) async {
    tz.initializeTimeZones();
    var location = tz.local;
    DateTime scheduleTime;
    if (time == 60) {
      scheduleTime =
          DateTime.parse(startTime).subtract(const Duration(hours: 1));
    } else {
      scheduleTime =
          DateTime.parse(startTime).subtract(Duration(minutes: time));
    }

    if (scheduleTime.compareTo(DateTime.now()) < 0) {
      instantNotification();
    } else {
      var xTime = tz.TZDateTime.from(scheduleTime, location);
      var bigPicture = const BigPictureStyleInformation(
          DrawableResourceAndroidBitmap("logo"),
          contentTitle: "Contest Alert!!!",
          summaryText: "Your Contest is about to start.",
          htmlFormatContent: true,
          htmlFormatContentTitle: true);

      var android = AndroidNotificationDetails("id", "channel",
          channelDescription: "description",
          styleInformation: bigPicture,
          priority: Priority.high,
          visibility: NotificationVisibility.public);

      var platform = NotificationDetails(android: android);

      await _flutterLocalNotificationsPlugin.zonedSchedule(
          num++,
          "Contest Alert!!!",
          "Your Contest is about to start.",
          xTime,
          platform,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true);
      print("notification set.");
    }
  }

  Future cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}

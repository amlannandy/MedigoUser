import 'dart:io';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  static final androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    Platform.isAndroid ? 'com.complexity.medigo' : 'com.complexity.medigo',
    'MediGo',
    'Channel description',
    playSound: true,
    enableVibration: true,
    importance: Importance.Max,
    priority: Priority.High,
  );

  static final iOSPlatformChannelSpecifics = new IOSNotificationDetails();

  static final platformChannelSpecifics = new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

  void configLocalNotification() {
    var initializationSettingsAndroid =new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<dynamic> backgroundMessageHandler(Map<String, dynamic> message) async {

    if (message.containsKey('notification')) {
      final dynamic notification = message['notification'];
      if (notification['title'] != null) {
        await flutterLocalNotificationsPlugin.show(
          0,
          notification['title'].toString(),
          notification['body'].toString(),
          platformChannelSpecifics,
          payload: json.encode(notification)
        );
      }
    }
    if (message.containsKey('data')) {
      final dynamic data = message['data'];
      if (data['schedule'] == "true") {
        String messageTitle = data['title'].toString();
        String messageBody = data['body'].toString();
        String messageTime = data['time'];

        var scheduleTime = Timestamp(int.parse(messageTime), 0)
            .toDate()
            .subtract(Duration(minutes: 15));
        var endTime = Timestamp(int.parse(messageTime), 0)
            .toDate()
            .add(Duration(minutes: 55));
        //Notification before 15 min of Appointment
        scheduleNotification(messageTitle, messageBody, scheduleTime);
        //Notification before 5 min of End of Appointment
        scheduleNotification(messageTitle, "Appointment is ending after 5 minutes.", endTime);
        print("Acknowlegement Message : $messageTitle,$messageBody,$scheduleTime");
      }
    }
    return Future<void>.value();
  }

  void showNotification(message) async {
    if (message.containsKey('notification')) {
      final dynamic notification = message['notification'];
      if (notification['title'] != null) {
        await flutterLocalNotificationsPlugin.show(
          0,
          notification['title'].toString(),
          notification['body'].toString(),
          platformChannelSpecifics,
          payload: json.encode(notification)
        );
        print('${notification['title'].toString()} and ${notification['body'].toString()}');
      }
    }
    if (message.containsKey('data')) {
      final dynamic data = message['data'];
      if (data['schedule'] == "true") {
        String messageTitle = data['title'].toString();
        String messageBody = data['body'].toString();
        String messageTime = data['time'];
        var scheduleTime = Timestamp(int.parse(messageTime), 0)
            .toDate()
            .subtract(Duration(minutes: 15));
        scheduleNotification(messageTitle, messageBody, scheduleTime);
        print("Acknowlegement Message : $messageTitle,$messageBody,$scheduleTime");
      }
    }
  }

  void registerNotification(uid) {
    print("In register Notification");
    firebaseMessaging.requestNotificationPermissions();

    firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('onMessage: $message');
          Platform.isAndroid
              ? showNotification(message)
              : showNotification(message['aps']['alert']);
          return;
        },
        onBackgroundMessage: Platform.isIOS ? null : backgroundMessageHandler,
        onResume: (Map<String, dynamic> message) {
          print('onResume: $message');
          return;
        },
        onLaunch: (Map<String, dynamic> message) {
          print('onLaunch: $message');
          return;
        });

    firebaseMessaging.getToken().then((token) {
      print('token: $token');
      Firestore.instance
          .collection('users')
          .document(uid)
          .updateData({'pushToken': token});
    }).catchError((err) {
      Fluttertoast.showToast(msg: err.message.toString());
    });
  }

  void removeNotification(uid) {
    firebaseMessaging.getToken().then((token) {
      print('token: $token');
      Firestore.instance
          .collection('users')
          .document(uid)
          .updateData({'pushToken': FieldValue.delete()}).whenComplete(() {
        print('pushToken Deleted');
      });
    }).catchError((err) {
      Fluttertoast.showToast(msg: err.message.toString());
    });
  }

  static void scheduleNotification(
      String title, String body, DateTime scheduledNotificationDateTime) async {
    // var scheduledNotificationDateTime =
    //     DateTime.now().add(Duration(seconds: 5));

    await flutterLocalNotificationsPlugin
        .schedule(
          0,
          title,
          body,
          scheduledNotificationDateTime,
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
        )
        .whenComplete(() => {print("Message is Scheduled..")});
  }
}

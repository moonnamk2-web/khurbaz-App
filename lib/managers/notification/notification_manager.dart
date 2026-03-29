import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../models/notification.dart';
import '../../utils/network/network_routes.dart';
import '../../utils/resources/app_colors.dart';

@pragma('vm:entry-point')
class NotificationManager {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static NotificationDetails notificationDetails = const NotificationDetails();

  static Future<List<NotificationModel>> get({required int page}) async {
    final url = Uri.parse("'notificationApi'/get");
    final body = jsonEncode({"page": page, "user_id": ' AuthCubit.user!.id'});

    final response = await http.post(url, headers: headers, body: body);
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      print(data['notifications']['data']);
      print('تم   بنجاح');
      return NotificationModel.fromJsonList(data['notifications']['data']);
    } else {
      print('حدث خطأ: ${response.body}');
      throw (Exception());
    }
  }

  static Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            critical: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            critical: true,
          );
    } else if (Platform.isAndroid) {
      FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    print('------------------------------backnoti');

    // RemoteNotification? notification = message.notification;
    // AndroidNotification? android = message.notification?.android;
    // AppleNotification? apple = message.notification?.apple;
    String filePath = '';

    if (message.data['image_url'] != null) {
      final appDocDir = await getApplicationDocumentsDirectory();
      filePath = '${appDocDir.path}/images';
      final http.Response response = await http.get(
        Uri.parse(message.data['image_url'].toString()),
      );
      print(response.bodyBytes);
      print('-------------------------------------image');
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
    }
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      '2', // id
      'khurbaz-Background', // title
      importance: Importance.max,
      playSound: true,
    );
    var initializationSettingsAndroid = const AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    if ((message.data.isNotEmpty)) {
      flutterLocalNotificationsPlugin.show(
        DateTime.now().millisecond,
        message.data['title'],
        message.data['body'],
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            color: kMainColor,
            importance: Importance.max,
            playSound: true,
            styleInformation: message.data['image_url'] == null
                ? null
                : BigPictureStyleInformation(
                    FilePathAndroidBitmap(filePath),
                    largeIcon: FilePathAndroidBitmap(filePath),
                  ),
            icon: "@mipmap/ic_launcher",
            category: AndroidNotificationCategory.alarm,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
          macOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      );
    }
  }

  static Future<void> initNotification() async {
    _requestPermissions();

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );
    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    var initializationSettings = const InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
            print('-----------');
          },
    );

    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      '1', // id
      'khurbaz', // title
      importance: Importance.max,
      playSound: true,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(
        '-----------------------------------message.data.toString()--10000',
      );
      String filePath = '';

      if (message.data['image_url'] != null) {
        final appDocDir = await getApplicationDocumentsDirectory();
        filePath = '${appDocDir.path}/images';
        final http.Response response = await http.get(
          Uri.parse(message.data['image_url'].toString()),
        );
        print(response.bodyBytes);
        print('-------------------------------------image');
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
      }

      if ((message.data.isNotEmpty)) {
        flutterLocalNotificationsPlugin.show(
          DateTime.now().millisecond,
          message.data['title'],
          message.data['body'],
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: kMainColor,
              importance: Importance.max,
              playSound: true,
              styleInformation: message.data['image_url'] == null
                  ? null
                  : BigPictureStyleInformation(
                      FilePathAndroidBitmap(filePath),
                      largeIcon: FilePathAndroidBitmap(filePath),
                    ),
              icon: "@mipmap/ic_launcher",
              category: AndroidNotificationCategory.alarm,
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
            macOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

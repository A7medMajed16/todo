// import 'dart:developer';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   static final NotificationService _notificationsServices =
//       NotificationService._internal();

//   NotificationService._internal() {
//     _initializePlatformChannelSpecifics();
//   }
//   factory NotificationService() => _notificationsServices;

//   static NotificationService get instance => _notificationsServices;

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   final AndroidNotificationDetails _androidNotificationDetails =
//       const AndroidNotificationDetails(
//     'high_importance_channel',
//     'High Importance Notifications',
//     channelDescription: 'This channel is used for important notifications.',
//     importance: Importance.high,
//     priority: Priority.high,
//     playSound: true,
//     channelShowBadge: false,
//     enableVibration: true,
//   );

//   final DarwinNotificationDetails _iosNotificationDetails =
//       const DarwinNotificationDetails(
//     interruptionLevel: InterruptionLevel.critical,
//     presentBanner: true,
//     presentAlert: true,
//     presentBadge: true,
//     presentSound: true,
//     badgeNumber: 0,
//   );

//   late final NotificationDetails platformChannelSpecifics;
//   void _initializePlatformChannelSpecifics() {
//     platformChannelSpecifics = NotificationDetails(
//       android: _androidNotificationDetails,
//       iOS: _iosNotificationDetails,
//     );
//   }

//   Future<void> init() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');

//     const DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//       requestSoundPermission: true,
//       requestBadgePermission: true,
//       requestAlertPermission: true,
//       requestCriticalPermission: true,
//     );

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
//     );
//   }

//   void onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) {
//     // Handle iOS notification when app is in the foreground
//   }

//   void onDidReceiveNotificationResponse(NotificationResponse details) {
//     log("===================Taped======${details.payload!.contains("is_order")}===============");

//     if (details.payload != null && details.payload!.contains("is_order")) {}
//   }

//   Future<void> showNotifications(
//       int id, String? title, String? body, String? payload) async {
//     await flutterLocalNotificationsPlugin.show(
//       id,
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: payload ?? 'Notification Payload',
//     );
//   }

//   // Future<void> showNotificationWithImage(
//   //     int id, String? title, String? body, String imageUrl) async {
//   //   final ByteArrayAndroidBitmap largeIcon = await _getBitmapFromUrl(imageUrl);

//   //   final AndroidNotificationDetails androidPlatformChannelSpecifics =
//   //       AndroidNotificationDetails(
//   //     'your_channel_id',
//   //     'your_channel_name',
//   //     channelDescription: 'your_channel_description',
//   //     importance: Importance.max,
//   //     priority: Priority.high,
//   //     largeIcon: largeIcon,
//   //   );

//   //   final NotificationDetails platformChannelSpecifics =
//   //       NotificationDetails(android: androidPlatformChannelSpecifics);

//   //   await flutterLocalNotificationsPlugin.show(
//   //     id,
//   //     title,
//   //     body,
//   //     platformChannelSpecifics,
//   //   );
//   // }

//   // Future<ByteArrayAndroidBitmap> _getBitmapFromUrl(String url) async {
//   //   final http.Response response = await http.get(Uri.parse(url));
//   //   if (response.statusCode == 200) {
//   //     final Uint8List bytes = response.bodyBytes;
//   //     return ByteArrayAndroidBitmap(bytes);
//   //   } else {
//   //     throw Exception('Failed to load image');
//   //   }
//   // }
// }

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:chatapp/src/features/splash_screen/view/splash_screen.dart';
// import 'package:chatapp/src/my_app.dart';
//
// class NotificationService {
//   static Future<void> initializeNotification() async {
//     await AwesomeNotifications().initialize(
//       null,
//       [
//         NotificationChannel(
//           channelGroupKey: 'high_importance_channel',
//           channelKey: 'high_importance_channel',
//           channelName: 'Basic notifications',
//           channelDescription: 'Notification channel for basic tests',
//           defaultColor: const Color(0xFF9D50DD),
//           ledColor: Colors.white,
//           importance: NotificationImportance.Max,
//           channelShowBadge: true,
//           onlyAlertOnce: true,
//           playSound: true,
//           criticalAlerts: true,
//         )
//       ],
//       channelGroups: [
//         NotificationChannelGroup(
//           channelGroupkey: 'high_importance_channel_group',
//           channelGroupName: 'Group 1',
//         )
//       ],
//       debug: true,
//     );
//
//     await AwesomeNotifications().isNotificationAllowed().then(
//       (isAllowed) async {
//         if (!isAllowed) {
//           await AwesomeNotifications().requestPermissionToSendNotifications();
//         }
//       },
//     );
//
//     // await AwesomeNotifications().setListeners(
//     //   onActionReceivedMethod: onActionReceivedMethod,
//     // );
//   }
//
//   /// Use this method to detect when the user taps on a notification or action button
//   static Future<void> onActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     debugPrint('onActionReceivedMethod');
//     final payload = receivedAction.payload ?? {};
//     if (payload["navigate"] == "true") {
//       MyApp.navigatorKey.currentState?.push(
//         MaterialPageRoute(
//           builder: (context) {
//             return const SplashScreen();
//           },
//         ),
//       );
//     }
//   }
//
//   static Future<void> showNotification({
//     required final String title,
//     required final String body,
//     final String? summary,
//     final Map<String, String>? payload,
//     final ActionType actionType = ActionType.Default,
//     final NotificationLayout notificationLayout = NotificationLayout.Default,
//     final NotificationCategory? category,
//     final String? bigPicture,
//     final List<NotificationActionButton>? actionButtons,
//     final bool scheduled = false,
//     final int? interval,
//   }) async {
//     assert(!scheduled || (scheduled && interval != null));
//
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: -1,
//         channelKey: 'high_importance_channel',
//         title: title,
//         body: body,
//         actionType: actionType,
//         notificationLayout: notificationLayout,
//         summary: summary,
//         category: category,
//         payload: {...payload ?? {}},
//         // add 'to' to the payload map
//         bigPicture: bigPicture,
//       ),
//       actionButtons: actionButtons,
//       schedule: scheduled
//           ? NotificationInterval(
//               interval: interval,
//               timeZone:
//                   await AwesomeNotifications().getLocalTimeZoneIdentifier(),
//               preciseAlarm: true,
//             )
//           : null,
//     );
//   }
// }

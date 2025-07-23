import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'i_local_notification_service.dart';

/// Implementation of the local notification service.
/// Contains platform-specific settings for Android and iOS.
class LocalNotificationService implements ILocalNotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> initialize() async {
    try {
      tz.initializeTimeZones();
      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const DarwinInitializationSettings iosSettings =
          DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
          );
      final InitializationSettings settings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );
      await _notificationsPlugin.initialize(settings);
      // Runtime permission check for Android 13+
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        if (androidInfo.version.sdkInt >= 33) {
          final androidPlugin =
              _notificationsPlugin
                  .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin
                  >();
          final areEnabled = await androidPlugin?.areNotificationsEnabled();
          if (areEnabled == false) {
            // You may need to show a dialog or direct the user to settings to enable notifications.
          }
        }
        // Create notification channel
        final androidPlugin =
            _notificationsPlugin
                .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin
                >();
        await androidPlugin?.createNotificationChannel(
          const AndroidNotificationChannel(
            'default_channel_id',
            'Default Channel',
            description: 'Default channel for notifications',
            importance: Importance.max, // HIGH IMPORTANCE
          ),
        );
      }
    } catch (e) {
      throw Exception('Failed to initialize local notifications: $e');
    }
  }

  @override
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      // Android notification details
      final AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'default_channel_id',
            'Default Channel',
            channelDescription: 'Default channel for notifications',
            importance: Importance.max, // HIGH IMPORTANCE
            priority: Priority.high, // HIGH PRIORITY
          );

      // iOS notification details
      const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

      // Combine platform details
      final NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      // Show the notification
      await _notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payload,
      );
    } catch (e) {
      // Handle notification display errors
      throw Exception('Failed to show notification: $e');
    }
  }

  @override
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    try {
      // Android scheduled notification details
      final AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'default_channel_id',
            'Default Channel',
            channelDescription: 'Default channel for notifications',
            importance: Importance.max, // HIGH IMPORTANCE
            priority: Priority.high, // HIGH PRIORITY
          );

      // iOS scheduled notification details
      const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

      // Combine platform details
      final NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      // Convert DateTime to TZDateTime (local time zone)
      final tz.TZDateTime tzScheduledDate = tz.TZDateTime.from(
        scheduledDate,
        tz.local,
      );

      // Schedule the notification
      await _notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tzScheduledDate,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: payload,
      );
    } catch (e) {
      // Handle scheduling errors
      throw Exception('Failed to schedule notification: $e');
    }
  }

  @override
  Future<void> cancelNotification(int id) async {
    try {
      // Cancel the notification with the given ID
      await _notificationsPlugin.cancel(id);
    } catch (e) {
      // Handle cancellation errors
      throw Exception('Failed to cancel notification: $e');
    }
  }
}

/// Interface for the local notification service.
/// Provides a platform-independent, testable, and extensible structure.
abstract class ILocalNotificationService {
  /// Initializes the notification service with platform-specific configurations.
  /// Should be called once during application startup.
  Future<void> initialize();

  /// Shows an immediate notification.
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  });

  /// Schedules a notification for future display.
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  });

  /// Cancels a scheduled notification by its ID.
  Future<void> cancelNotification(int id);
}

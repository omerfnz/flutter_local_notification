import 'package:flutter_test/flutter_test.dart';
import 'package:local_notification/local_notification.dart';

void main() {
  late ILocalNotificationService notificationService;

  setUp(() {
    notificationService = LocalNotificationService();
  });

  test('initialize does not throw', () async {
    expect(notificationService.initialize(), completes);
  });

  test('showNotification does not throw', () async {
    await notificationService.initialize();
    expect(
      notificationService.showNotification(
        id: 1,
        title: 'Test',
        body: 'Test body',
      ),
      completes,
    );
  });

  test('scheduleNotification does not throw', () async {
    await notificationService.initialize();
    expect(
      notificationService.scheduleNotification(
        id: 2,
        title: 'Scheduled',
        body: 'Scheduled body',
        scheduledDate: DateTime.now().add(Duration(minutes: 1)),
      ),
      completes,
    );
  });

  test('cancelNotification does not throw', () async {
    await notificationService.initialize();
    expect(notificationService.cancelNotification(1), completes);
  });
}

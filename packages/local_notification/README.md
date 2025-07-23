# local_notification

A modular, reusable, and testable local notification package for Flutter. This package provides a clean interface and implementation for scheduling and displaying local notifications on both Android and iOS, following clean architecture and SOLID principles.

## Features
- Platform-agnostic notification service interface
- Android and iOS support
- Immediate and scheduled notifications
- Dependency injection ready (GetIt)
- Easy to mock for testing
- Error handling and logging
- Clean, extensible architecture

## Architecture

This package follows clean architecture and the repository pattern:

```
Main Application
    ↓ (DI Container)
ILocalNotificationService (Interface)
    ↓ (Implementation)
LocalNotificationService (Concrete)
    ↓ (External Dependency)
flutter_local_notifications (Plugin)
    ↓ (Platform Channels)
Native Platform APIs
```

- **Interface-based:** Easy to mock and test
- **Dependency injection:** Use with GetIt or any DI framework
- **Platform abstraction:** Android/iOS handled internally

## Installation
Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  local_notification:
    path: packages/local_notification
```

Add required dependencies to your main app:
```yaml
dependencies:
  flutter_local_notifications: ^19.3.1
  device_info_plus: ^11.5.0
  timezone: ^0.10.1
  permission_handler: ^11.3.0
```

## Usage

1. **Register the service in your DI container (e.g., GetIt):**

```dart
GetIt.I.registerLazySingleton<ILocalNotificationService>(
  () => LocalNotificationService(),
);
```

2. **Initialize the service at app startup:**

```dart
await GetIt.I<ILocalNotificationService>().initialize();
```

3. **Show a notification:**

```dart
await GetIt.I<ILocalNotificationService>().showNotification(
  id: 1,
  title: 'Hello',
  body: 'This is a test notification.',
);
```

4. **Schedule a notification:**

```dart
await GetIt.I<ILocalNotificationService>().scheduleNotification(
  id: 2,
  title: 'Reminder',
  body: 'This is a scheduled notification.',
  scheduledDate: DateTime.now().add(Duration(hours: 1)),
);
```

5. **Cancel a notification:**

```dart
await GetIt.I<ILocalNotificationService>().cancelNotification(1);
```

## Platform-specific setup
- **Android:** Ensure you have the `POST_NOTIFICATIONS` permission in your `AndroidManifest.xml` for Android 13+.
- **iOS:** The service requests permissions automatically.

## Testing
- The interface can be easily mocked for unit tests.
- Implementation can be tested with a mocked `FlutterLocalNotificationsPlugin`.
- See the `test/` directory for examples.

## Contributing
Pull requests and issues are welcome! For major changes, please open an issue first to discuss what you would like to change.

## License
MIT

---

GitHub: [omerfnz](https://github.com/omerfnz)

# flutter_local_notification

A sample Flutter application demonstrating the use of a modular local notification package (`local_notification`). This project shows how to integrate, initialize, and use local notifications in a clean, testable, and scalable way for both Android and iOS.

## Project Structure

```
flutter_local_notification/
├── lib/
│   └── main.dart
├── packages/
│   └── local_notification/
│       ├── lib/
│       ├── test/
│       └── README.md
├── android/
├── ios/
├── ...
```

## Getting Started

1. **Clone the repository:**
   ```sh
   git clone https://github.com/omerfnz/flutter_local_notification.git
   cd flutter_local_notification
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Run the app:**
   ```sh
   flutter run
   ```

## Features
- Modular local notification package (`local_notification`)
- Clean architecture and SOLID principles
- Android & iOS support
- Immediate and scheduled notifications
- Dependency injection (GetIt)
- Easy to mock and test

## Usage Example

See [`lib/main.dart`](lib/main.dart) for a complete example. Key steps:

```dart
// Register the notification service
GetIt.I.registerLazySingleton<ILocalNotificationService>(
  () => LocalNotificationService(),
);

// Initialize the service
await GetIt.I<ILocalNotificationService>().initialize();

// Show a notification
await GetIt.I<ILocalNotificationService>().showNotification(
  id: 1,
  title: 'Hello',
  body: 'This is a test notification.',
);
```

## Platform-specific Setup
- **Android:**
  - Add `android.permission.POST_NOTIFICATIONS` to `AndroidManifest.xml` for Android 13+.
- **iOS:**
  - Permissions are requested automatically by the package.

## About the Package

The local notification logic is implemented as a reusable package in [`packages/local_notification`](packages/local_notification/README.md). See its README for detailed documentation, features, and API reference.

## Contributing
Pull requests and issues are welcome! For major changes, please open an issue first to discuss what you would like to change.

## License
MIT

---

GitHub: [omerfnz](https://github.com/omerfnz)

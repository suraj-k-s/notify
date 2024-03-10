import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'home_page.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService notificationService = NotificationService();
  await notificationService.init();
  await notificationService.requestIOSPermissions();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> requestPermissions() async {
    // Check for notification permission first
    var status = await Permission.notification.status;
    if (status != PermissionStatus.granted) {
      // If not granted, request it
      status = await Permission.notification.request();
    }

    // Handle the permission request result
    if (status == PermissionStatus.granted) {
      // Permission granted, proceed with notification actions
      notificationService.init(); // Initialize notification service
    } else {
      // Permission denied, handle accordingly (e.g., display an error message)
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Local Notifications Example',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomePage(),
    );
  }
}

// main.dart
import 'package:flutter/material.dart';
import 'screens/input_name_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/news_screen.dart';
import 'screens/splash_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/inputName': (context) => const InputNameScreen(),
        '/notification': (context) => const NotificationScreen(firstName: '', lastName: ''),
        '/news': (context) => const NewsScreen(userName: 'User'),
      },
    );
  }
}

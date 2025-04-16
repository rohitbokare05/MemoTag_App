import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_dashboard_screen.dart';
import 'screens/patient_detail_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/home_wrapper.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
void main() {
  runApp(const MemoTagApp());
}

class MemoTagApp extends StatelessWidget {
  const MemoTagApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'MemoTag',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: const Color(0xFF0057FF),
            hoverColor: Colors.white,
            primaryColorLight: Colors.white,
            primaryColorDark: Colors.black,
            scaffoldBackgroundColor: const Color(0xFFF7F9FA),
            textTheme: const TextTheme(
              titleLarge: TextStyle(
                color: Color(0xFF2D2D2D),
                fontWeight: FontWeight.bold,
              ),
              bodyMedium: TextStyle(
                color: Color(0xFF4A4A4A),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B5FFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            hoverColor: Colors.white,
            primaryColorLight: const Color.fromARGB(255, 52, 52, 52),
            primaryColorDark: Colors.white,
            primaryColor: const Color(0xFF0057FF),
            scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
            textTheme: const TextTheme(
              titleLarge: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              bodyMedium: TextStyle(
                color: Colors.white70,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B5FFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          themeMode: currentMode,
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginScreen(),
            '/dashboard': (context) => const HomeWrapper(),
            '/patient_detail': (context) => const PatientDetailScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/notifications': (context) => const NotificationsScreen(),
          },
        );
      },
    );
  }
}

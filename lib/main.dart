import 'package:flutter/material.dart';
import 'firstpage.dart';
import 'yoon_lib/outline.dart';
import 'jung_lib/screens/kiosk_screen.dart';
import 'hong_lib/screens/first_screen.dart';
import 'jang_lib/screens/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Firstpage(),
        '/yoon': (context) => CivilServiceMachine(),
        '/jung': (context) => KioskScreen(),
        '/hong': (context) => Mainscreen(),
        '/jang': (context)  => HomeScreen()
      },
    );
  }
}
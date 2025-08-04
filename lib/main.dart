import 'package:flutter/material.dart';
import '/jung_lib/main.dart';
import 'firstpage.dart';
import 'yoon_lib/outline.dart';
import 'hong_lib/first_screen.dart';
import 'jang_lib/screens/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Firstpage(),
        '/yoon': (context) => CivilServiceMachine(),
        '/jung': (context) => MyApp(),
        '/hong': (context) => Mainscreen(),
        '/jang': (context)  => HomeScreen()
      },
    );
  }
}
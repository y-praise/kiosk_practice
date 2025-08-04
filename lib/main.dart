import 'package:flutter/material.dart';
import 'firstpage.dart';
import 'food_lib/main.dart';
import 'civil_service_lib/outline.dart';
import 'airport_lib/main.dart';
import 'table_lib/main.dart';

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
        '/civil_service': (context) => CivilServiceMachine(),
        '/food': (context) => FoodMain(),
        '/airport': (context) => AirportMain(),
        '/table': (context)  => TableMain()
      },
    );
  }
}
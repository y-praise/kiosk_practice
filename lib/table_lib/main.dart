import 'package:flutter/material.dart';
import 'screens/kiosk_screen.dart';
import 'package:provider/provider.dart';
import 'providers/provider.dart';
import 'theme/colors.dart';

class TableMain extends StatelessWidget {
  const TableMain({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return MaterialApp(
            title: '키오스크 앱',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: primaryColor,
              scaffoldBackgroundColor: backgroundColor,
              fontFamily: 'Pretendard',
              textTheme: Theme.of(context).textTheme.apply(
                fontSizeFactor: settings.fontScale,
                bodyColor: textColor,
                displayColor: textColor,
              ),
            ),
            home: const OrderScreen(),
          );
        },
      ),
    );
  }
}

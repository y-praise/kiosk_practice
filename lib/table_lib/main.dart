import 'package:flutter/material.dart';
import 'screens/kiosk_screen.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart'; // Provider 패키지 import
import 'providers/provider.dart'; // SettingsProvider import
import 'theme/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // 앱 전체에서 SettingsProvider를 사용할 수 있도록 설정
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider를 통해 글꼴 크기 변경을 감지하고 UI를 다시 빌드
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        return MaterialApp(
          title: '키오스크 앱',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: primaryColor,
            scaffoldBackgroundColor: backgroundColor,
            fontFamily: 'Pretendard',
            // 앱 전체의 기본 텍스트 테마에 글꼴 크기 조절 적용
            textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: settings.fontScale,
              bodyColor: textColor,
              displayColor: textColor,
            ),
          ),
          home: const OrderScreen(),
        );
      },
    );
  }
}

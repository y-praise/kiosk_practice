import 'package:flutter/material.dart';

//앱의 전역 설정을 관리하는 클래스 (글꼴 크기 등)
class SettingsProvider with ChangeNotifier {
  double _fontScale = 1.0; // 1.0 = 기본, 1.2 = 크게, 1.4 = 아주 크게

  double get fontScale => _fontScale;

  void setFontScale(double scale) {
    _fontScale = scale;
    notifyListeners(); // 변경 사항을 모든 위젯에 알림
  }
}

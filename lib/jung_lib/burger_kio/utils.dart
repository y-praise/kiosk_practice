// lib/utils.dart
import 'package:flutter/material.dart';

// 화면 가로 세로 기준값 (iPhone 12 Pro 기준, 디자인 툴에서 사용한 기준에 맞춰야 함)
// 이 값은 main.dart에서 LayoutBuilder를 통해 실제 화면 크기에 맞게 조정됩니다.
const double baseScreenWidth = 450;
const double baseScreenHeight = 900;

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double _blockSizeHorizontal;
  static late double _blockSizeVertical;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  // 실제 앱이 차지하는 가상 공간의 너비와 높이
  // 이 값들이 모든 페이지의 w, h, sp 계산의 기준이 됩니다.
  static late double actualAppWidth;
  static late double actualAppHeight;

  // 초기화되었는지 여부를 확인하는 플래그
  static bool _isInitialized = false;

  void init(BuildContext context, {Size? actualAppSize}) {
    if (_isInitialized && actualAppSize == null) {
      // 이미 초기화되었고, 새로운 actualAppSize가 제공되지 않았다면 다시 초기화하지 않습니다.
      return;
    }

    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    _blockSizeHorizontal = screenWidth / 100;
    _blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    // 만약 actualAppSize가 제공되면 그 값을 사용하고, 그렇지 않으면 기본값을 사용합니다.
    // main.dart에서 명시적으로 appWidth, appHeight를 전달할 때 이 경로를 사용합니다.
    if (actualAppSize != null) {
      actualAppWidth = actualAppSize.width;
      actualAppHeight = actualAppSize.height;
    } else {
      // 실제 앱의 가상 너비/높이를 현재 화면의 100%로 설정 (Fallback 또는 기본값)
      // 이 부분은 main.dart의 LayoutBuilder에 의해 오버라이드될 것입니다.
      actualAppWidth = screenWidth;
      actualAppHeight = screenHeight;
    }

    _isInitialized = true; // 초기화 완료 플래그 설정
  }
}

extension SizeExtension on num {
  // width based on the actual app width
  double get w {
    return (this / baseScreenWidth) * SizeConfig.actualAppWidth;
  }

  // height based on the actual app height
  double get h {
    return (this / baseScreenHeight) * SizeConfig.actualAppHeight;
  }

  // text size based on average of width and height scaled
  double get sp {
    // 텍스트 크기는 일반적으로 너비에만 의존하는 것이 좋습니다 (줄바꿈 때문에)
    // 하지만 현재 SizeConfig가 높이도 함께 사용하고 있으므로, 기존 로직을 따릅니다.
    // 폰트 스케일링을 더 정밀하게 제어하려면 MediaQuery.textScaleFactor를 고려할 수 있습니다.
    return (this / baseScreenWidth) * SizeConfig.actualAppWidth;
    // 또는 기존 방식처럼 평균을 사용할 수도 있습니다.
    // return ((this / baseScreenWidth) * SizeConfig.actualAppWidth + (this / baseScreenHeight) * SizeConfig.actualAppHeight) / 2;
  }
}
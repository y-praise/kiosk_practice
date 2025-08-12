import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'car/car_pages.dart';
import 'common_pages/common_pages.dart';
import 'employment/employment_pages.dart';
import 'expulsion/expulsion_pages.dart';
import 'family/family_pages.dart';
import 'health/health_pages.dart';
import 'military/military_pages.dart';
import 'real_estate/real_estate_pages.dart';
import 'registration/registration_pages.dart';
import 'tax/tax_pages.dart';
import 'traffic/traffic_pages.dart';
import 'welfare/welfare_pages.dart';

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

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
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


Widget buttonWidget(BuildContext context, VoidCallback onPressedCallback, String text,) {
  return Expanded(
    child: ElevatedButton(
      onPressed: onPressedCallback,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 48, 48, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(2),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 25),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

Widget buildHelpBubble({required String text, double? top, double? bottom, double? right, double? left}) {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> _speak() async {
    await flutterTts.setLanguage("ko-KR");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text.replaceAll('\n', ' '));
  }

  _speak();

  return Positioned(
    top: top,
    bottom: bottom,
    left: right,
    right: left,
    child: Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
      ),
    ),
  );
}

Widget showHelpBubble({Widget? page}) {
  if (page.runtimeType == MainPage) {     //common_page help comments
    return buildHelpBubble(text: '발급을 원하는 항목의 \n버튼을 눌러보세요', top: 340.h, right: 105);
  } else if (page.runtimeType == FingerprintPage) {
    return buildHelpBubble(text: '오른쪽의 지문인식기 버튼을 \n눌러보세요', top: 520.h, right: 90);
  } else if (page.runtimeType == LastPage) {
    return Stack(children: [
        buildHelpBubble(text: '\'처음화면\' 버튼을 눌러\n처음 화면으로 돌아가세요', top: 320.h, right: 45),
        buildHelpBubble(text: '아래에 출력된 증명서를 눌러 보세요', top: 660.h, right: 15),],);
  } else if (page.runtimeType == MobileIdPage) {
    return buildHelpBubble(text: '오른쪽의 휴대폰을 \n눌러보세요', top: 500.h, right: 50);
  } else if (page.runtimeType == NotExistPage) {
    return buildHelpBubble(text: '\'처음화면\' 버튼을 눌러보세요', top: 300.h);
  } else if (page.runtimeType == PrintConfirm) {
    return buildHelpBubble(text: '\'확인\' 버튼을 눌러보세요', top: 350.h, right: 50);
  } else if (page.runtimeType == NumberPage) {
    return buildHelpBubble(text: '주민번호 입력 후 \n\'확인\' 버튼을 눌러보세요', top: 350.h, right: 60);
  } else if (page.runtimeType == VertificationMethodPage) {
    return buildHelpBubble(text: '원하는 본인 인증 \n버튼을 눌러보세요', top: 300.h, right: 60);
  } else if (page.runtimeType == LoadingPage) {
    return buildHelpBubble(text: '잠시만 기다려주세요', top: 300.h, right: 60);
  } 
  else if (page.runtimeType == CarMainPage) {    //car help comments
    return buildHelpBubble(text: '원하는 항목의 버튼을 눌러보세요', top: 320.h, right: 20);
  } else if (page.runtimeType == CarAnnouncement) {
    return buildHelpBubble(text: '안내사항 확인 후\n\'확인\' 버튼을 눌러보세요', top: 300.h, right: 50);
  } else if (page.runtimeType == CarCirculationPage) {
    return buildHelpBubble(text: '몇장을 출력할 지 선택 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 10);
  } else if (page.runtimeType == CarSelectionPage) {
    return buildHelpBubble(text: '화면을 내리며 필요한 사항을 누른 후\n확인을 눌러보세요', top: 420.h, right: 10);
  } else if (page.runtimeType == CarSelectionPage2) {
    return buildHelpBubble(text: '필요한 사항을 선택한 후\n확인을 눌러보세요', top: 420.h, right: 50);
  } 
  else if (page.runtimeType == EmploymentMainPage) {      //employment help comments
    return buildHelpBubble(text: '원하는 항목의 버튼을 눌러보세요', top: 320.h, right: 20);
  } else if (page.runtimeType == EmploymentAnnouncement) {
    return buildHelpBubble(text: '안내사항 확인 후\n\'확인\' 버튼을 눌러보세요', top: 300.h, right: 50);
  } else if (page.runtimeType == EmploymentCirculationPage) {
    return buildHelpBubble(text: '몇장을 출력할 지 선택 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 10);
  } else if (page.runtimeType == EmploymentSelectionPage) {
    return buildHelpBubble(text: '필요한 사항을 선택한 후\n확인을 눌러보세요', top: 420.h, right: 50);
  } else if (page.runtimeType == EmploymentSelectionPage2) {
    return buildHelpBubble(text: '필요한 사항을 선택한 후\n확인을 눌러보세요', top: 420.h, right: 50);
  } else if (page.runtimeType == EmploymentSelectionPage3) {
    return buildHelpBubble(text: '필요한 사항을 선택한 후\n확인을 눌러보세요', top: 420.h, right: 50);
  } 
  else if (page.runtimeType == ExpulsionMainPage) {      //expulsion help comments
    return buildHelpBubble(text: '원하는 항목의 버튼을 눌러보세요', top: 320.h, right: 20);
  } else if (page.runtimeType == ExpulsionAnnouncement) {
    return buildHelpBubble(text: '안내사항 확인 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 50);
  } else if (page.runtimeType == ExpulsionCirculationPage) {
    return buildHelpBubble(text: '몇장을 출력할 지 선택 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 10);
  } else if (page.runtimeType == ExpulsionSelectionPage) {
    return buildHelpBubble(text: '필요한 사항을 선택한 후\n확인을 눌러보세요', top: 420.h, right: 50);
  } 
  else if (page.runtimeType == FamilyMainPage) {      //family help comments
    return buildHelpBubble(text: '원하는 항목의 버튼을 눌러보세요', top: 320.h, right: 20);
  } else if (page.runtimeType == FamilyAnnouncement) {
    return buildHelpBubble(text: '안내사항 확인 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 50);
  } else if (page.runtimeType == FamilyCirculationPage) {
    return buildHelpBubble(text: '몇장을 출력할 지 선택 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 10);
  } else if (page.runtimeType == FamilySelectionPage) {
    return buildHelpBubble(text: '필요한 사항을 선택한 후\n확인을 눌러보세요', top: 420.h, right: 50);
  } 
  else if (page.runtimeType == HealthMainPage) {      //health help comments
    return buildHelpBubble(text: '원하는 항목의 버튼을 눌러보세요', top: 320.h, right: 20);
  } else if (page.runtimeType == HealthAnnouncement) {
    return buildHelpBubble(text: '안내사항 확인 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 50);
  } else if (page.runtimeType == HealthCirculationPage) {
    return buildHelpBubble(text: '몇장을 출력할 지 선택 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 10);
  } else if (page.runtimeType == HealthSelectionPage) {
    return buildHelpBubble(text: '필요한 사항을 선택한 후\n확인을 눌러보세요', top: 420.h, right: 50);
  } else if (page.runtimeType == HealthSelectionPage2) {
    return buildHelpBubble(text: '필요한 사항을 선택한 후\n확인을 눌러보세요', top: 420.h, right: 50);
  } 
  else if (page.runtimeType == MilitaryAnnouncement) {      //military help comments
    return buildHelpBubble(text: '안내사항 확인 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 50);
  } else if (page.runtimeType == MilitaryCirculationPage) {
    return buildHelpBubble(text: '몇장을 출력할 지 선택 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 10);
  } else if (page.runtimeType == MilitarySelectionPage) {
    return buildHelpBubble(text: '화면을 내리며 필요한 사항을 선택한 후\n확인을 눌러보세요', top: 420.h, right: 50);
  }
  else if (page.runtimeType == RealEstateAnnouncement) {      //real_estate help comments
    return buildHelpBubble(text: '안내사항 확인 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 50);
  } else if (page.runtimeType == RealEstateCirculationPage) {
    return buildHelpBubble(text: '몇장을 출력할 지 선택 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 10);
  } else if (page.runtimeType == RealEstateSelectionPage) {
    return buildHelpBubble(text: '필요한 사항을 선택한 후\n확인을 눌러보세요', top: 420.h, right: 50);
  }
  else if (page.runtimeType == RegistrationMainPage) {      //registration help comments
    return buildHelpBubble(text: '원하는 항목의 버튼을 눌러보세요', top: 300.h, right: 20);
  } else if (page.runtimeType == RegistrationAnnouncement) {
    return buildHelpBubble(text: '안내사항 확인 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 50);
  } else if (page.runtimeType == CirculationPage) {
    return buildHelpBubble(text: '몇장을 출력할 지 선택 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 10);
  } else if (page.runtimeType == SelectionPage) {
    return buildHelpBubble(text: '화면을 내리며 필요한 사항을 누른 후\n확인을 눌러보세요', top: 420.h, right: 10);
  } 
  else if (page.runtimeType == TaxAnnouncement) {      //tax help comments
    return buildHelpBubble(text: '안내사항 확인 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 50);
  } else if (page.runtimeType == TaxCirculationPage) {
    return buildHelpBubble(text: '몇장을 출력할 지 선택 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 10);
  } else if (page.runtimeType == TaxSelectionPage) {
    return buildHelpBubble(text: '필요한 사항을 선택한 후\n확인을 눌러보세요', top: 420.h, right: 50);
  } 
  else if (page.runtimeType == TrafficMainPage) {      //traffic help comments
    return buildHelpBubble(text: '원하는 항목의 버튼을 눌러보세요', top: 320.h, right: 20);
  } else if (page.runtimeType == TrafficAnnouncement) {
    return buildHelpBubble(text: '안내사항 확인 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 50);
  } else if (page.runtimeType == TrafficCirculationPage) {
    return buildHelpBubble(text: '몇장을 출력할 지 선택 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 10);
  } else if (page.runtimeType == TrafficSelectionPage) {
    return buildHelpBubble(text: '필요한 사항을 선택한 후\n확인을 눌러보세요', top: 420.h, right: 50);
  } else if (page.runtimeType == TrafficSelectionPage2) {
    return buildHelpBubble(text: '필요한 사항을 선택한 후\n확인을 눌러보세요', top: 420.h, right: 50);
  } 
  else if (page.runtimeType == WelfareMainPage) {      //welfare help comments
    return buildHelpBubble(text: '원하는 항목의 버튼을 눌러보세요', top: 320.h, right: 20);
  } else if (page.runtimeType == WelfareAnnouncement) {
    return buildHelpBubble(text: '안내사항 확인 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 50);
  } else if (page.runtimeType == WelfareCirculationPage) {
    return buildHelpBubble(text: '몇장을 출력할 지 선택 후\n\'확인\' 버튼을 눌러보세요', top: 340.h, right: 10);
  } else if (page.runtimeType == WelfareSelectionPage) {
    return buildHelpBubble(text: '화면을 내리며 필요한 사항을 누른 후\n확인을 눌러보세요', top: 420.h, right: 10);
  } else if (page.runtimeType == WelfareSelectionPage2) {
    return buildHelpBubble(text: '필요한 사항을 선택한 후\n확인을 눌러보세요', top: 420.h, right: 50);
  } else if (page.runtimeType == WelfareSelectionPage3) {
    return buildHelpBubble(text: '필요한 사항을 선택한 후\n확인을 눌러보세요', top: 420.h, right: 50);
  } 
  else {    //unexpected page help comments
    return buildHelpBubble(text: '유효하지 않은 페이지 설명');
  }
}
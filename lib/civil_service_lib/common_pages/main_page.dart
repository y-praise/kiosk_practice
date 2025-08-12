import 'package:flutter/material.dart';
import '../employment/employment_main.dart';
import '../health/health_announcement.dart';
import '../health/health_main.dart';
import '../passport/passport_main.dart';
import '../pension/pension_main.dart';
import '../traffic/traffic_main.dart';
import '../expulsion/expulsion_main.dart';
import '../family/family_main.dart';
import '../registration/registration_main.dart';
import '../car/car_main.dart';
import '../welfare/welfare_main.dart';
import 'registration_number.dart';
import 'not_exist.dart';
import '../widgets.dart';

class MainPage extends StatelessWidget {
  final Function(Widget, double) switchPageCallback;

  const MainPage({Key? key, required this.switchPageCallback})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '발급을 원하시는 증명서를 선택하십시오.',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  children: [
                    buttonWidget(
                      context,
                      () => switchPageCallback(
                        RegistrationMainPage(switchPageCallback: switchPageCallback),
                        1.0
                      ),
                      '주민등록',
                    ),
                    SizedBox(width: 10),
                    buttonWidget(
                      context,
                      () => switchPageCallback(
                        CarMainPage(switchPageCallback: switchPageCallback), 
                        2.0
                      ),
                      '차량',
                    ),
                    SizedBox(width: 10),
                    buttonWidget(
                      context,
                      () => switchPageCallback(
                        WelfareMainPage(switchPageCallback: switchPageCallback),
                        3.0
                      ),
                      '보건복지',
                    ),
                  ],
                ),

                SizedBox(height: 10),
                Row(
                  children: [
                    buttonWidget(
                      context,
                      () => switchPageCallback(
                        FamilyMainPage(switchPageCallback: switchPageCallback),
                        4.0
                      ),
                      '가족관계등록부',
                    ),
                    SizedBox(width: 10),
                    buttonWidget(
                      context,
                      () => switchPageCallback(
                        ExpulsionMainPage(switchPageCallback: switchPageCallback),
                        5.0
                      ),
                      '제적부',
                    ),
                    SizedBox(width: 10),
                    buttonWidget(
                      context,
                      () => switchPageCallback(
                        NumberPage(switchPageCallback: switchPageCallback, page_number: 6.0,),
                        6.0
                      ),
                      '병적증명서',
                    ),
                  ],
                ),

                SizedBox(height: 10),
                Row(
                  children: [
                    buttonWidget(
                      context,
                      () => switchPageCallback(
                        NumberPage(switchPageCallback: switchPageCallback, page_number: 7.0,),
                        7.0
                      ),
                      '지방세',
                    ),

                    SizedBox(width: 10),
                    buttonWidget(
                      context,
                      () => switchPageCallback(
                        NumberPage(switchPageCallback: switchPageCallback, page_number: 8.0,),
                        8.0
                      ),
                      '부동산등기사항증명서',
                    ),
                    SizedBox(width: 10),
                    buttonWidget(
                      context,
                      () => switchPageCallback(
                        TrafficMainPage(switchPageCallback: switchPageCallback,),
                        9.0
                      ),
                      '교통(경찰청)',
                    ),
                  ],
                ),

                SizedBox(height: 10),
                Row(
                  children: [
                    buttonWidget(
                      context,
                      () => switchPageCallback(
                        HealthMainPage(switchPageCallback: switchPageCallback),
                        10.0
                      ),
                      '건강보험',
                    ),
                    SizedBox(width: 10),
                    buttonWidget(
                      context,
                      () => switchPageCallback(
                        EmploymentMainPage(switchPageCallback: switchPageCallback),
                        11.0
                      ),
                      '고용,산재보험\n(근로복지공단)',
                    ),
                    SizedBox(width: 10),
                    buttonWidget(
                      context,
                      () => switchPageCallback(
                        PassportMainPage(switchPageCallback: switchPageCallback),
                        12.0
                      ),
                      '여권',
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    buttonWidget(
                      context,
                      () => switchPageCallback(
                        PensionMainPage(switchPageCallback: switchPageCallback),
                        13.0
                      ),
                      '국민연금',
                    ),
                    SizedBox(width: 10),
                    const Expanded(child: SizedBox()),
                    SizedBox(width: 10),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.red),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(50),
            margin: EdgeInsets.fromLTRB(10, 50, 10, 0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '서비스 연결 중입니다.\n잠시만 기다려 주십시오.',
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

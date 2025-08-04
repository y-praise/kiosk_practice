import 'package:flutter/material.dart';
import '../common_pages/main_page.dart';
import '../widgets.dart';
import 'health_selection.dart';
import '../common_pages/registration_number.dart';
import 'health_announcement.dart';

class HealthMainPage extends StatelessWidget {
  final Function(Widget, double) switchPageCallback;
  const HealthMainPage({Key? key, required this.switchPageCallback})
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
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: buttonWidget(
                    context,
                    () => switchPageCallback(
                      NumberPage(switchPageCallback: switchPageCallback, page_number: 10.1,), 
                      10.1
                    ),
                    '4대사회보험 가입자 가입내역 확인서(개인)',
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  child: buttonWidget(
                    context,
                    () => switchPageCallback(
                      NumberPage(switchPageCallback: switchPageCallback, page_number: 10.2,), 
                      10.2
                    ),
                    '건강보험 자격득실확인서',
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  child: buttonWidget(
                    context,
                    () => switchPageCallback(
                      NumberPage(switchPageCallback: switchPageCallback, page_number: 10.3,), 
                      10.3
                    ),
                    '건강보험증 재발급',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

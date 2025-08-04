import 'package:flutter/material.dart';
import '../common_pages/main_page.dart';
import '../widgets.dart';
import 'employment_selection.dart';
import '../common_pages/registration_number.dart';
import 'employment_announcement.dart';

class EmploymentMainPage extends StatelessWidget {
  final Function(Widget, double) switchPageCallback;
  const EmploymentMainPage({Key? key, required this.switchPageCallback})
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
                      NumberPage(switchPageCallback: switchPageCallback, page_number: 11.1,), 
                      11.1
                    ),
                    '고용보험 자격이력내역서',
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  child: buttonWidget(
                    context,
                    () => switchPageCallback(
                      NumberPage(switchPageCallback: switchPageCallback, page_number: 11.2,), 
                      11.2
                    ),
                    '보험 가입 증명원',
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  child: buttonWidget(
                    context,
                    () => switchPageCallback(
                      NumberPage(switchPageCallback: switchPageCallback, page_number: 11.3,), 
                      11.3
                    ),
                    '보험료 완납 증명원',
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

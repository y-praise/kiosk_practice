import 'package:flutter/material.dart';
import '../common_pages/main_page.dart';
import '../widgets.dart';
import 'expulsion_selection.dart';
import '../common_pages/registration_number.dart';
import 'expulsion_announcement.dart';

class ExpulsionMainPage extends StatelessWidget {
  final Function(Widget, double) switchPageCallback;
  const ExpulsionMainPage({Key? key, required this.switchPageCallback})
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
                      NumberPage(switchPageCallback: switchPageCallback, page_number: 5.1,), 
                      5.1
                    ),
                    '제적등본',
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  child: buttonWidget(
                    context,
                    () => switchPageCallback(
                      NumberPage(switchPageCallback: switchPageCallback, page_number: 5.2,), 
                      5.2
                    ),
                    '제적초본',
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

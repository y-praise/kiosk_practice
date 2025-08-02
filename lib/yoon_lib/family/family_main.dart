import 'package:flutter/material.dart';
import '../common_pages/main_page.dart';
import '../widgets.dart';
import '../common_pages/registration_number.dart';

class FamilyMainPage extends StatelessWidget {
  final Function(Widget, double) switchPageCallback;
  const FamilyMainPage({Key? key, required this.switchPageCallback})
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
                      NumberPage(switchPageCallback: switchPageCallback, page_number: 4.1,), 
                      4.1
                    ),
                    '가족관계증명서',
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  child: buttonWidget(
                    context,
                    () => switchPageCallback(
                      NumberPage(switchPageCallback: switchPageCallback, page_number: 4.2,), 
                      4.2
                    ),
                    '기본증면서',
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  child: buttonWidget(
                    context,
                    () => switchPageCallback(
                      NumberPage(switchPageCallback: switchPageCallback, page_number: 4.3,), 
                      4.3
                    ),
                    '혼인관계증명서',
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  child: buttonWidget(
                    context,
                    () => switchPageCallback(
                      NumberPage(switchPageCallback: switchPageCallback, page_number: 4.4,), 
                      4.4
                    ),
                    '입양증명서',
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  child: buttonWidget(
                    context,
                    () => switchPageCallback(
                      NumberPage(switchPageCallback: switchPageCallback, page_number: 4.5,), 
                      4.5
                    ),
                    '친양자입양관계증명서',
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

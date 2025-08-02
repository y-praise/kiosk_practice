import 'package:flutter/material.dart';
import '../registration/registration_selection.dart';
import '../widgets.dart';
import 'registration_selection.dart';

class RegistrationAnnouncement extends StatelessWidget {
  final Function(Widget, double)switchPageCallback; // switchPageCallback을 생성자로 받음
  final double pageNum;

  const RegistrationAnnouncement({Key? key, required this.switchPageCallback, required this.pageNum})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text('[ 안 내 ]', style: TextStyle(fontSize: 30)),
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
            child: Center(
              child: Column(
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('주민등록 발급 시 선택사항에 대해'),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '법원, 교육기관, 공공기관, 부동산계약, 금융·병원 제출용',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('5가지 선택사항으로 발급을 도와 드리겠습니다.'),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        '%다른 용도로 발급을 원하시는 경우 개별항목을 선택하여 발급 가능%',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('계속 진행하시려면 확인을 눌러 주십시오'),
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: 50,
                    child: buttonWidget(
                      context,
                      () => switchPageCallback(
                        SelectionPage(switchPageCallback: switchPageCallback, page_num: pageNum,),
                        pageNum,
                      ),
                      '확인',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

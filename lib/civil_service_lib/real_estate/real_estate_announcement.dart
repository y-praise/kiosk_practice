import 'package:flutter/material.dart';
import 'real_estate_selection.dart';
import '../widgets.dart';

class RealEstateAnnouncement extends StatelessWidget {
  final Function(Widget, double)
  switchPageCallback; // switchPageCallback을 생성자로 받음
  final double page_num;

  const RealEstateAnnouncement({
    Key? key,
    required this.switchPageCallback,
    required this.page_num,
  }) : super(key: key);

  Widget _next_page() {
    return RealEstateSelectionPage(
      switchPageCallback: switchPageCallback,
      page_num: page_num,
    );
  }

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
                    child: Text('부동산 등기부등본 발급 안내입니다.'),
                  ),
                  SizedBox(height: 20),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '부동산의 권리관계 및 현황을 확인할 수 있는\n등기부등본을 발급받으실 수 있습니다.',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 20),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('계속 진행하시려면 \'확인\' 버튼을 눌러주세요.'),
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: 50,
                    child: buttonWidget(
                      context,
                      () => switchPageCallback(_next_page(), 99.0),
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

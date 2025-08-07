import 'package:flutter/material.dart';
import 'health_circulation.dart';
import '../widgets.dart';

class HealthSelectionPage2 extends StatefulWidget {
  final Function(Widget, double)
  switchPageCallback; // switchPageCallback을 생성자로 받음4
  final double page_num;

  const HealthSelectionPage2({
    Key? key,
    required this.switchPageCallback,
    required this.page_num,
  }) : super(key: key);

  @override
  State createState() => SelectionPage2State();
}

class SelectionPage2State extends State<HealthSelectionPage2> {
  List<String?> selectedOption = ['', '', '', ''];

  Widget _radioButton(String text, String option1, String option2, int n) {
    return Row(
      children: [
        Text(text),
        Spacer(),
        Column(
          children: [
            Text(option1),
            Radio(
              value: option1,
              groupValue: selectedOption[n],
              onChanged: (String? value) {
                setState(() {
                  selectedOption[n] = value;
                });
              },
            ),
          ],
        ),
        SizedBox(width: 10),
        Column(
          children: [
            Text(option2),
            Radio(
              value: option2,
              groupValue: selectedOption[n],
              onChanged: (String? value) {
                setState(() {
                  selectedOption[n] = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _radioButton2(String text, String option1, String option2, String option3,  int n) {
    return Row(
      children: [
        Text(text),
        Spacer(),
        Column(
          children: [
            Text(option1),
            Radio(
              value: option1,
              groupValue: selectedOption[n],
              onChanged: (String? value) {
                setState(() {
                  selectedOption[n] = value;
                });
              },
            ),
          ],
        ),
        SizedBox(width: 10),
        Column(
          children: [
            Text(option2),
            Radio(
              value: option2,
              groupValue: selectedOption[n],
              onChanged: (String? value) {
                setState(() {
                  selectedOption[n] = value;
                });
              },
            ),
          ],
        ),
        SizedBox(width: 10),
        Column(
          children: [
            Text(option3),
            Radio(
              value: option3,
              groupValue: selectedOption[n],
              onChanged: (String? value) {
                setState(() {
                  selectedOption[n] = value;
                });
              },
            ),
          ],
        ),
      ],
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
            child: Text(
              '개인정보 보호를 위해 아래의 등본 사항 중 필요한 사항을 선택하신 후 확인 버튼을 누르십시오.',
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
                Row(children: [Text('약관동의')]),
                _radioButton('개인정보 수집 \n및 동의 약관', '동의하지 않음', '동의함', 0),
                _radioButton('고유식별정보 수집 \n및 이용 동의', '동의하지 않음', '동의함', 1),
                SizedBox(height: 50,),
                _radioButton2('재발급사유', '분실', '훼손', '기타', 2),
                _radioButton2('발송지구분', '가입자주소', '사업장주소', '수령자주소', 3),

                Row(
                  children: [
                    Text('휴대전화번호'),
                    Spacer(),
                    Container(width: 50, child: TextField()),
                    Text('-'),
                    Container(width: 50, child: TextField()),
                    Text('-'),
                    Container(width: 50, child: TextField()),
                  ],
                ),
                
                Row(
                  children: [
                    Text('이메일'),
                    Spacer(),
                    Container(width: 70, child: TextField()),
                    Text('@'),
                    Container(width: 70, child: TextField()),
                  ],
                ),
                Spacer(),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 50,
                      alignment: Alignment.bottomRight,
                      child: buttonWidget(
                        context,
                        () => widget.switchPageCallback(
                          HealthCirculationPage(
                            switchPageCallback: widget.switchPageCallback,
                            page_num: widget.page_num,
                          ),
                          99.0,
                        ),
                        '확인',
                      ),
                    ),
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

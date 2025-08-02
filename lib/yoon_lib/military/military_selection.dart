import 'package:flutter/material.dart';
import 'military_circulation.dart';
import '../widgets.dart';

class MilitarySelectionPage extends StatefulWidget {
  final Function(Widget, double)
  switchPageCallback; // switchPageCallback을 생성자로 받음4
  final double page_num;

  const MilitarySelectionPage({
    Key? key,
    required this.switchPageCallback,
    required this.page_num,
  }) : super(key: key);

  @override
  State createState() => SelectionPageState();
}

class SelectionPageState extends State<MilitarySelectionPage> {
  List<String?> selectedOption = ['', '', '', '', '', '', '', '', '', '', ''];
  List<String> purpose = ['취업', '공직자 등 신고', '경력확인', '시험응시', '보훈대상자 등록', '기타'];
  String? selectedItem = '';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
          Container(
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
                    Text('휴대전화번호'),
                    Spacer(),
                    Container(width: 50, child: TextField()),
                    Text('-'),
                    Container(width: 50, child: TextField()),
                    Text('-'),
                    Container(width: 50, child: TextField()),
                  ],
                ),
                _radioButton(
                  '군(대체) 복무 상태',
                  '복무를 마친 사람',
                  '복무를 마치지 않은 사람\n(최근 1개월 이내 전역자 포함)',
                  0,
                ),
                _radioButton('언어구분', '국문', '영문', 1),
                Row(
                  children: [
                    Text('발급용도'),
                    Spacer(),
                    Text('${selectedItem}'),
                    DropdownButton(
                      items: purpose.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newString) {
                        setState(() {
                          selectedItem = newString;
                        });
                      },
                    ),
                  ],
                ),
                _radioButton('군별', '기재', '미기재', 2),
                _radioButton('역종', '기재', '미기재', 3),
                _radioButton('계급', '기재', '미기재', 4),
                _radioButton('병과(특기)', '기재', '미기재', 5),
                _radioButton('복무분야', '기재', '미기재', 6),
                _radioButton('복무계급', '기재', '미기재', 7),
                _radioButton('군번', '기재', '미기재', 8),
                _radioButton('전역 사유 구분', '기재', '미기재', 9),
                _radioButton('그 외 발급 요구사항', '있음', '없음', 10),
                SizedBox(height: 50),
                Center(
                  child: Container(
                    height: 50,
                    alignment: Alignment.bottomRight,
                    child: buttonWidget(
                      context,
                      () => widget.switchPageCallback(
                        MilitaryCirculationPage(
                          switchPageCallback: widget.switchPageCallback,
                          page_num: widget.page_num,
                        ),
                        99.0,
                      ),
                      '확인',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

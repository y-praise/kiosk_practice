import 'package:flutter/material.dart';
import 'welfare_circulation.dart';
import '../widgets.dart';

class WelfareSelectionPage extends StatefulWidget {
  final Function(Widget, double)
  switchPageCallback; // switchPageCallback을 생성자로 받음4
  final double page_num;

  const WelfareSelectionPage({
    Key? key,
    required this.switchPageCallback,
    required this.page_num,
  }) : super(key: key);

  @override
  State createState() => SelectionPageState();
}

class SelectionPageState extends State<WelfareSelectionPage> {
  List<String?> selectedOption = ['', '', '', ''];
  List<String> relationship = ['본인','배우자','부모','사위, 자부','손사위, 손자부','손이하','시부모','시조부모이상','자','조부모이상','처부모','처조부모','형제자매',];
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
                Row(
                  children: [
                    Text('성명'),
                    Spacer(),
                    Container(width: 100, child: TextField()),
                  ],
                ),
                Row(
                  children: [
                    Text('생년월일'),
                    Spacer(),
                    Container(width: 100, child: TextField()),
                  ],
                ),
                Row(
                  children: [
                    Text('주소'),
                    Spacer(),
                    Container(width: 100, child: TextField()),
                  ],
                ),
                Row(
                  children: [
                    Text('세대주 성명'),
                    Spacer(),
                    Container(width: 100, child: TextField()),
                  ],
                ),
                Row(
                  children: [
                    Text('세대주와의 관계'),
                    Spacer(),
                    Text('${selectedItem}'),
                    DropdownButton(
                      items: relationship.map((String item) {
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
                Row(
                  children: [
                    Text('용도'),
                    Spacer(),
                    Container(width: 100, child: TextField()),
                  ],
                ),
                Row(
                  children: [
                    Text('제출처'),
                    Spacer(),
                    Container(width: 100, child: TextField()),
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
                          WelfareCirculationPage(
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

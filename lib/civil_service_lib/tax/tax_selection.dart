import 'package:flutter/material.dart';
import 'tax_circulation.dart';
import '../widgets.dart';

class TaxSelectionPage extends StatefulWidget {
  final Function(Widget, double)
  switchPageCallback; // switchPageCallback을 생성자로 받음4
  final double page_num;

  const TaxSelectionPage({
    Key? key,
    required this.switchPageCallback,
    required this.page_num,
  }) : super(key: key);

  @override
  State createState() => SelectionPageState();
}

class SelectionPageState extends State<TaxSelectionPage> {
  List<String?> selectedOption = [''];
  List<String> purpose = ['대금수령', '해외이주', '부동산 신탁등기', '기타'];
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
                _radioButton('주민등록번호\n표기 방법', '전체표기', '일부 표기', 0,),
                Row(
                  children: [
                    Text('주소(영업소)'),
                    Spacer(),
                    Container(width: 100, child: TextField()),
                  ],
                ),
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
                    Text('증명서 사용목적'),
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
                Row(
                  children: [
                    Text('대금지급자'),
                    Spacer(),
                    Container(width: 70, child: TextField()),
                  ],
                ),
                SizedBox(height: 50),
                Center(
                  child: Container(
                    height: 50,
                    alignment: Alignment.bottomRight,
                    child: buttonWidget(
                      context,
                      () => widget.switchPageCallback(
                        TaxCirculationPage(
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

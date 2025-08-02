import 'package:flutter/material.dart';
import '../widgets.dart';
import 'expulsion_circulation.dart';

class ExpulsionSelectionPage extends StatefulWidget {
  final Function(Widget, double)
  switchPageCallback; // switchPageCallback을 생성자로 받음4
  final double page_num;

  const ExpulsionSelectionPage({
    Key? key,
    required this.switchPageCallback,
    required this.page_num,
  }) : super(key: key);

  @override
  State createState() => SelectionPageState();
}

class SelectionPageState extends State<ExpulsionSelectionPage> {
  List<String> purpose = ['개인 신분 또는 가족관계증명', '국내 기관 제출', '연말정산', '해외 제출', '본인 확인 등 기타'];
  List<String?> selectedOption = ['', '', '', ''];
  String? selectedItem = '';

  Widget _radioButton(String option, int n) {
    return Column(
      children: [
        Text(option),
        Radio(
          value: option,
          groupValue: selectedOption[n],
          onChanged: (String? value) {
            setState(() {
              selectedOption[n] = value;
            });
          },
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
                    Text('주민등록번호\n(뒷보분 6자리)\n공개 여부'),
                    Spacer(),
                    _radioButton('전부 공개', 0),
                    SizedBox(width: 10,),
                    _radioButton('전부 비공개', 0),
                    SizedBox(width: 10,),
                    _radioButton('신청대상자\n본인만 공개', 0),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Text('신청사유'),
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
                Spacer(),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 50,
                      alignment: Alignment.bottomRight,
                      child: buttonWidget(
                        context,
                        () => widget.switchPageCallback(
                          ExpulsionCirculationPage(
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

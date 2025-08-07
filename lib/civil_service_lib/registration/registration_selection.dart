import 'package:flutter/material.dart';
import 'announcement.dart';
import 'registration_circulation.dart';
import '../widgets.dart';

class SelectionPage extends StatefulWidget {
  final Function(Widget, double) switchPageCallback; // switchPageCallback을 생성자로 받음
  final double page_num;

  const SelectionPage({Key? key, required this.switchPageCallback, required this.page_num})
    : super(key: key);

  @override
  State createState() => SelectionPageState();
}

class SelectionPageState extends State<SelectionPage> {
  List<bool> isChecked = [true, true, true, true, true, true, true, true, true, ];

  void _onCheckboxChanged(int index, bool? newValue) {
    setState(() {
      isChecked[index] = newValue!;
    });
  }

  Widget _checkList(String value, int num) {
    return Row(
      children: [
        Text(value),
        Spacer(),
        Checkbox(
          value: isChecked[num],
          onChanged: (bool? newValue) {
            _onCheckboxChanged(num, newValue);
          },
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
                _checkList('1. 과거 주소 변동 사항', 0),
                _checkList('2. 세대 구성 사유', 1),
                _checkList('3. 세대 구성 일자', 2),
                _checkList('4. 발생일/신고일', 3),
                _checkList('5. 변동 사유', 4),
                _checkList('6. 교부 대상자 외 \n세대주, 세대원, 외국인 등의 이름', 5),
                _checkList('7. 주민등록번호 뒷자리', 6),
                _checkList('8. 세대원의 세대주와의 관계', 7),
                _checkList('9. 동거인', 8),
                
                SizedBox(height: 50),
                Center(
                  child: Container(
                    height: 50,
                    alignment: Alignment.bottomRight,
                    child: buttonWidget(
                      context,
                      () => widget.switchPageCallback(
                        CirculationPage(
                          switchPageCallback: widget.switchPageCallback,
                          page_num: widget.page_num,
                        ), 
                        99.0
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

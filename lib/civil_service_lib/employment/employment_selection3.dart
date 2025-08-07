import 'package:flutter/material.dart';
import 'employment_circulation.dart';
import '../widgets.dart';

class EmploymentSelectionPage3 extends StatefulWidget {
  final Function(Widget, double)
  switchPageCallback; // switchPageCallback을 생성자로 받음4
  final double page_num;

  const EmploymentSelectionPage3({
    Key? key,
    required this.switchPageCallback,
    required this.page_num,
  }) : super(key: key);

  @override
  State createState() => SelectionPage3State();
}

class SelectionPage3State extends State<EmploymentSelectionPage3> {
  List<String> relationship = ['본인','배우자','부모','사위, 자부','손사위, 손자부','손이하','시부모','시조부모이상','자','조부모이상','처부모','처조부모','형제자매',];
  List<String> purpose = ['법원 제출용', '교육기관 제출용', '공공기관 제출용', '부동산 계약', '금융·병원 제출용', '기타'];
  String? selectedItem = '';
  String? selectedItem2 = '';

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
                    Text('발급사유'),
                    Spacer(),
                    Text('${selectedItem2}'),
                    DropdownButton(
                  items: purpose.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newString) {
                    setState(() {
                      selectedItem2 = newString;
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
                          EmploymentCirculationPage(
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

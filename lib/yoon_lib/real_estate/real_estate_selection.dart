import 'package:flutter/material.dart';
import 'real_estate_circulation.dart';
import '../widgets.dart';

class RealEstateSelectionPage extends StatefulWidget {
  final Function(Widget, double)
  switchPageCallback; // switchPageCallback을 생성자로 받음4
  final double page_num;

  const RealEstateSelectionPage({
    Key? key,
    required this.switchPageCallback,
    required this.page_num,
  }) : super(key: key);

  @override
  State createState() => SelectionPageState();
}

class SelectionPageState extends State<RealEstateSelectionPage> {
  List<bool> isChecked = [false, false];
  List<String?> selectedOption = ['', '', ''];
  List<String> purpose = ['대금수령', '해외이주', '부동산 신탁등기', '기타'];
  List<String> list1 = ['말소사항 포함', '현재유효사항'];
  List<String> list2 = ['현재소유현황', '특정인지분', '지분취득이력'];
  String? selectedItem = '';
  late List<String> selectedList;

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
                  if (selectedOption[n] == '전부') {
                    selectedList = list1;
                    selectedItem = '';
                  } else {
                    selectedList = list2;
                  }
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  void _onCheckboxChanged(int index, bool? newValue) {
    setState(() {
      isChecked[index] = newValue!;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedList = list1;
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
                    Text('주소'),
                    Spacer(),
                    Container(width: 100, child: TextField()),
                  ],
                ),
                SizedBox(height: 10,),
                _radioButton('용도', '열람', '발급(출력)', 0),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('추가사항'),
                    Spacer(),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text('공동담보/전세목록'),
                            Checkbox(
                              value: isChecked[0],
                              onChanged: (bool? newValue) {
                                _onCheckboxChanged(0, newValue);
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('매매목록록'),
                            Checkbox(
                              value: isChecked[1],
                              onChanged: (bool? newValue) {
                                _onCheckboxChanged(1, newValue);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                _radioButton('등기기록유형', '전부', '일부', 1),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Spacer(),
                    Text('${selectedItem}'),
                    DropdownButton(
                      items: selectedList.map((String item) {
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
                SizedBox(height: 10,),
                _radioButton('주민등록번호 공개 여부', '미공개', '공개', 2),
                SizedBox(height: 10,),
                SizedBox(height: 50),
                Center(
                  child: Container(
                    height: 50,
                    alignment: Alignment.bottomRight,
                    child: buttonWidget(
                      context,
                      () => widget.switchPageCallback(
                        RealEstateCirculationPage(
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

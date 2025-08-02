import 'package:flutter/material.dart';
import '../registration/announcement.dart';
import '../common_pages/main_page.dart';
import '../registration/registration_main.dart';
import '../widgets.dart';
import 'vertification.dart';

class NumberPage extends StatefulWidget {
  final Function(Widget, double)
  switchPageCallback; // switchPageCallback을 생성자로 받음
  final double page_number;

  const NumberPage({Key? key, required this.switchPageCallback, required this.page_number})
    : super(key: key);

  @override
  State createState() => NumberPageState();
}

class NumberPageState extends State<NumberPage> {
  List<String> registerationID = ['*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*'];
  int sequence = 0;

  void inputID(String num) {
    setState(() {
      if (num == 'delete') {
        if (sequence >= 1) {
          sequence--;
          registerationID[sequence] = '*';
        }
      } else if (num == 'confirm') {
        if (registerationID[12] != '*') {
          widget.switchPageCallback(
            VertificationMethodPage(
              switchPageCallback: widget.switchPageCallback,
              page_number: widget.page_number,
            ),
            widget.page_number,
          );
        }
      } else {
        if (sequence <= 12) {
          registerationID[sequence] = num;
          sequence++;
        }
      }
    });
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
              '주민등록번호를 입력한 후 확인을 누르십시오.',
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  child: Text(
                    '${registerationID[0]} ${registerationID[1]} ${registerationID[2]} ${registerationID[3]} ${registerationID[4]} ${registerationID[5]} - ${registerationID[6]} ${registerationID[7]} ${registerationID[8]} ${registerationID[9]} ${registerationID[10]} ${registerationID[11]} ${registerationID[12]} ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Row(
                  children: [
                    buttonWidget(context, () => inputID('1'), '1'),
                    SizedBox(width: 10),
                    buttonWidget(context, () => inputID('2'), '2'),
                    SizedBox(width: 10),
                    buttonWidget(context, () => inputID('3'), '3'),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    buttonWidget(context, () => inputID('4'), '4'),
                    SizedBox(width: 10),
                    buttonWidget(context, () => inputID('5'), '5'),
                    SizedBox(width: 10),
                    buttonWidget(context, () => inputID('6'), '6'),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    buttonWidget(context, () => inputID('7'), '7'),
                    SizedBox(width: 10),
                    buttonWidget(context, () => inputID('8'), '8'),
                    SizedBox(width: 10),
                    buttonWidget(context, () => inputID('9'), '9'),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    buttonWidget(context, () => inputID('delete'), '←'),
                    SizedBox(width: 10),
                    buttonWidget(context, () => inputID('0'), '0'),
                    SizedBox(width: 10),
                    buttonWidget(context, () => inputID('confirm'), '확인'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

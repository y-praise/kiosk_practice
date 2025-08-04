import 'package:flutter/material.dart';
import '../widgets.dart';
import '../common_pages/print_confirm.dart';

class FamilyCirculationPage extends StatefulWidget {
  final Function(Widget, double)
  switchPageCallback; // switchPageCallback을 생성자로 받음
  final double page_num;

  const FamilyCirculationPage({
    Key? key,
    required this.switchPageCallback,
    required this.page_num,
  }) : super(key: key);

  State createState() => FamilyCirculationPageState();
}

class FamilyCirculationPageState extends State<FamilyCirculationPage> {
  int circulation = 1;
  late String page_name;

  void setCirculation(int count) {
    setState(() {
      circulation = count;
    });
  }

  @override
  void initState() {
    super.initState();

    switch (widget.page_num) {
      case 4.1:
        page_name = '가족관계증명서';
        break;

      case 4.2:
        page_name = '기본증명서';
        break;

      case 4.3:
        page_name = '혼인관계증명서';
        break;
      
      case 4.4:
        page_name = '입양관계증명서';
        break;
      
      case 4.5:
        page_name = '친양자입양관계증명서';
        break;
    }
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
              '발급할 부수를 입력한 후 확인을 눌러 주십시오.',
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  child: Text(
                    '${circulation}',
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                ),
                Row(
                  children: [
                    buttonWidget(context, () => setCirculation(1), '1'),
                    SizedBox(width: 10),
                    buttonWidget(context, () => setCirculation(2), '2'),
                    SizedBox(width: 10),
                    buttonWidget(context, () => setCirculation(3), '3'),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    buttonWidget(context, () => setCirculation(4), '4'),
                    SizedBox(width: 10),
                    buttonWidget(context, () => setCirculation(5), '5'),
                    SizedBox(width: 10),
                    buttonWidget(context, () => setCirculation(6), '6'),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    buttonWidget(context, () => setCirculation(7), '7'),
                    SizedBox(width: 10),
                    buttonWidget(context, () => setCirculation(8), '8'),
                    SizedBox(width: 10),
                    buttonWidget(context, () => setCirculation(9), '9'),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  alignment: Alignment.bottomRight,
                  child: buttonWidget(
                    context,
                    () => widget.switchPageCallback(
                      PrintConfirm(
                        switchPageCallback: widget.switchPageCallback,
                        doc_name: page_name,
                        count: circulation,
                        fee: 1000 * circulation,
                      ),
                      99.0,
                    ),
                    '확인',
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

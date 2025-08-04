import 'package:flutter/material.dart';
import 'last_page.dart';
import '../widgets.dart';

class PrintConfirm extends StatelessWidget {
  final Function(Widget, double) switchPageCallback; // switchPageCallback을 생성자로 받음
  final String doc_name;
  final int count;
  final int fee;

  const PrintConfirm({
    Key? key,
    required this.switchPageCallback,
    required this.count,
    required this.doc_name,
    required this.fee
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text('[ 안 내 ]', style: TextStyle(fontSize: 30)),
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
            child: Center(
              child: Column(
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('신청 증명서: ${doc_name}'),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '신 청 부 수: ${count}',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('수수료: ${fee}원'),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        '%다른 용도로 발급을 원하시는 경우 개별항목을 선택하여 발급 가능%',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('계속 진행하시려면 확인을 눌러 주십시오'),
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: 50,
                    child: buttonWidget(
                      context,
                      () => switchPageCallback(
                        LastPage(switchPageCallback: switchPageCallback),
                        99.0
                      ),
                      '확인',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'main_page.dart';
import '../widgets.dart';


class LastPage extends StatelessWidget {
  final Function(Widget, double) switchPageCallback; // switchPageCallback을 생성자로 받음

  const LastPage({Key? key, required this.switchPageCallback})
    : super(key: key);

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
                FittedBox(fit: BoxFit.scaleDown, child: Text('증명서 발급이 완료되었습니다.')),
                FittedBox(fit: BoxFit.scaleDown, child: Text('증명서를 수령하십시오.', style: TextStyle(color: Colors.blue),)),
                FittedBox(fit: BoxFit.scaleDown, child: Container(margin: EdgeInsets.fromLTRB(0, 20, 0, 20), child: Text('소지품을 두고 가시는 일이 없도록 주의하시기 바랍니다.', style: TextStyle(color: Colors.red),))),
                SizedBox(height: 50,),
                Container(height: 50, child: buttonWidget(context, () => switchPageCallback(MainPage(switchPageCallback: switchPageCallback), 0.0), '처음 화면'))
              ],
            ),
          ),
        ),
      ),
    ],
  );
  }
}
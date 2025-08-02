import 'package:flutter/material.dart';
import '../common_pages/main_page.dart';
import '../widgets.dart';

class NotExistPage extends StatelessWidget {
  final Function(Widget, double) switchPageCallback; // switchPageCallback을 생성자로 받음

  const NotExistPage({
    Key? key,
    required this.switchPageCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.all(50),
            child: Text('구현 중 입니다.', style: TextStyle(fontSize: 40),),
          ),
        ),
        Center(
          child: buttonWidget(
            context, 
            () => switchPageCallback(MainPage(switchPageCallback:switchPageCallback), 0.0), 
            '처음 화면'),
        )
      ],
    );
  }
}

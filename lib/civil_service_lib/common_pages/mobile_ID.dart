import 'package:flutter/material.dart';
import 'main_page.dart';
import 'vertification.dart';
import '../widgets.dart';
import 'registration_number.dart';

class MobileIdPage extends StatefulWidget {
  final bool vertification = false;
  final Function(Widget, double) switchPageCallback;

  const MobileIdPage({Key? key, required this.switchPageCallback})
    : super(key: key);

  @override
  State createState() => MobileIdPageState();
}

class MobileIdPageState extends State<MobileIdPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '휴대폰에서 인증을 진행해주세요.',
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
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red
                        )
                      ),
                      height: 220,
                      child: Image.asset(
                        'assets/images/mobileID.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red
                        )
                      ),
                      height: 220,
                      child: Image.asset(
                        'assets/images/mobileID2.png',
                        fit: BoxFit.fill,
                      ),
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

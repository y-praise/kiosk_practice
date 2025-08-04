import 'package:flutter/material.dart';
import 'fingerprint.dart';
import '../widgets.dart';
import 'registration_number.dart';
import 'mobile_ID.dart';

class VertificationMethodPage extends StatelessWidget {
  final Function(Widget, double) switchPageCallback;
  final double page_number;

  const VertificationMethodPage({Key? key, required this.switchPageCallback, required this.page_number})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '증명서 발급을 위한 인증 방법을 선택하여 주십시오.',
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
            child: Center(
              child: Row(
                children: [
                  buttonWidget(
                    context,
                    () => switchPageCallback(
                      FingerprintPage(switchPageCallback: switchPageCallback),
                      page_number,
                    ),
                    '지문',
                  ),
                  SizedBox(width: 30),
                  buttonWidget(
                    context,
                    () => switchPageCallback(
                      MobileIdPage(switchPageCallback: switchPageCallback),
                      page_number,
                    ),
                    '모바일 신분증',
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

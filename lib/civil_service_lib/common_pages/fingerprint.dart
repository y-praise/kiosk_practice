import 'package:flutter/material.dart';
import 'main_page.dart';
import 'vertification.dart';
import '../widgets.dart';
import 'registration_number.dart';

class FingerprintPage extends StatefulWidget {
  final bool vertification = false;
  final Function(Widget, double) switchPageCallback;

  const FingerprintPage({Key? key, required this.switchPageCallback})
    : super(key: key);

  @override
  State createState() => FingerprintPageState();
}

class FingerprintPageState extends State<FingerprintPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '지문인식기에 온른손 엄지손가락을 올려주세요.',
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
                      height: 250,
                      child: Image.asset(
                        'assets/images/fingerprint_help_image.png',
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
                      height: 250,
                      child: Image.asset(
                        'assets/images/fingerprint_help_image2.png',
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

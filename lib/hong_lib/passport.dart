import 'package:flutter/material.dart';
import './information.dart';

class Passport extends StatefulWidget {
  const Passport({super.key});

  @override
  State<Passport> createState() => _PassportState();
}

class _PassportState extends State<Passport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('여권스캔'), backgroundColor: Colors.indigo),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: -85,
            child: Image.asset(
              "assets/images/flight2.png",
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: 45,
            left: -85,
            child: Image.asset(
              "assets/images/passport.png",
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: 350,
            left: 330,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Information()),
                );
              },
              child: Container(
                width: 110,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 12, 205, 170),
                ),
                child: Text(
                  "다음단계 ->",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 420,
            left: 15,
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text(
                '여권 스캔 방법 확인 후 다음단계 버튼을 눌러주세요',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import './flight.dart';

class Caution extends StatefulWidget {
  const Caution({super.key});

  @override
  State<Caution> createState() => _CautionState();
}

class _CautionState extends State<Caution> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('주의사항'), backgroundColor: Colors.indigo),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/caution.png'),
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: 330,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Flight()),
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
          Container(
            margin: EdgeInsets.only(top: 350, left: 40),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Text(
              '주의사항을 읽고 다음단계 버튼을 눌러주세요',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import './language.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainScreenState();
}

bool qvisible = false;

class _MainScreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('공항 키오스크'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, size: 28, color: Colors.black),
            // 버튼 클릭 시 _showHelpOverlay 상태를 토글
            onPressed: () {
              setState(() {
                qvisible = !qvisible;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.fitWidth,
            ),
          ),
          //배경
          Positioned(
            top: 60,
            left: 200,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Language()),
                );
              },
              child: Image.asset("assets/images/airportA.png"),
            ),
          ),

          Positioned(
            top: 155,
            left: 100,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Language()),
                );
              },
              child: Image.asset("assets/images/airportB.png"),
            ),
          ),

          Positioned(
            top: 160,
            left: 270,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Language()),
                );
              },
              child: Image.asset("assets/images/airportC.png"),
            ),
          ),

          Positioned(
            top: 350,
            left: 130,
            child: Visibility(
              visible: qvisible,
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  '원하는 항공사를 눌러주세요',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

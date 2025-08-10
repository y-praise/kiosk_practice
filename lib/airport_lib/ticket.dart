import 'package:flutter/material.dart';
import './flight.dart';
import './seat.dart';
import './first_screen.dart';

class Ticket extends StatefulWidget {
  const Ticket({super.key});

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('티켓발급'),
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
              "assets/images/flight4.png",
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            child: Image.asset(
              "assets/images/information1.png",
              width: 300,
              height: 200,
            ),
          ),
          Positioned(
            top: 50,
            left: 220,
            child: Image.asset(
              "assets/images/information2.png",
              width: 300,
              height: 200,
            ),
          ),
          Positioned(
            top: 70,
            left: 346,
            child: Container(
              width: 50,
              height: 20,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 243, 243, 243),
              ),
              child: Text(
                inf.country,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            top: 115,
            left: 346,
            child: Container(
              width: 50,
              height: 20,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 243, 243, 243),
              ),
              child: Text(
                inf.destination,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            top: 167,
            left: 385,
            child: Container(
              width: 50,
              height: 20,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Text(
                inf.flnumber,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
            ),
          ),
          Positioned(
            top: 185,
            left: 385,
            child: Container(
              width: 50,
              height: 20,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Text(
                inf.flnumber,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
            ),
          ),
          Positioned(
            top: 77,
            left: 260,
            child: Text(
              seat,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ),
          Positioned(
            top: 280,
            left: 330,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Mainscreen()),
                ); //마지막 화면 버튼
              },
              child: Container(
                width: 110,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 235, 38, 153),
                ),
                child: Text(
                  "탑승권 발행",
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
            top: 350,
            left: 50,
            child: Visibility(
              visible: qvisible,
              child: Container(
                width: 330,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  '수고하셨습니다 탑승권 발행을 누르면 처음 화면으로 돌아갑니다',
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

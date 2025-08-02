import 'package:flutter/material.dart';
import 'flight.dart';
import 'seat.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('탑승객 정보'),
        backgroundColor: Colors.indigo,
      ),
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
            top: 280,
            left: 330,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Seat()),
                );
              },
              child: Container(
                width: 110,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 235, 38, 153),
                ),
                child: Text(
                  "좌석선택",
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
        ],
      ),
    );
  }
}

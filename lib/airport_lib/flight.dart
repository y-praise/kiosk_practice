import 'package:flutter/material.dart';
import './first_screen.dart';
import './passport.dart';
import './flightselect.dart';

flightmenu inf = flightmenu(country: "선택", destination: "선택", flnumber: "선택");

class Flight extends StatefulWidget {
  const Flight({super.key});

  @override
  State<Flight> createState() => _FlihgtState();
}

class _FlihgtState extends State<Flight> {
  bool avisible = false;
  bool bvisible = false;
  bool nvisible = false;

  Color abutton = Colors.white;
  Color atext = Colors.black;
  Color bbutton = Colors.white;
  Color btext = Colors.black;
  //국가 버튼색
  Color cbutton = Colors.white;
  Color ctext = Colors.black;
  Color dbutton = Colors.white;
  Color dtext = Colors.black;
  Color ebutton = Colors.white;
  Color etext = Colors.black;
  //도착지 버튼색
  Color fbutton = Colors.white;
  Color ftext = Colors.black;
  Color gbutton = Colors.white;
  Color gtext = Colors.black;
  Color hbutton = Colors.white;
  Color htext = Colors.black;
  //편명 버튼색

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('항공편 선택'),
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
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/flight1.png",
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            child: Image.asset("assets/images/finf.png", fit: BoxFit.fitWidth),
          ),
          Positioned(
            top: 85,
            left: 0,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      avisible = true;
                      abutton = const Color.fromARGB(255, 1, 139, 125);
                      bbutton = Colors.white;
                      atext = Colors.white;
                      btext = Colors.black;
                      inf.country = "일본";
                    });
                  },
                  child: Container(
                    width: 150,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(color: abutton),
                    child: Text(
                      "일본",
                      style: TextStyle(
                        color: atext,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      avisible = true;
                      bbutton = const Color.fromARGB(255, 1, 139, 125);
                      abutton = Colors.white;
                      btext = Colors.white;
                      atext = Colors.black;
                      inf.country = "아시아";
                    });
                  },
                  child: Container(
                    width: 150,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(color: bbutton),
                    child: Text(
                      "아시아",
                      style: TextStyle(
                        color: btext,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 85,
            left: 151,
            child: Column(
              children: [
                Visibility(
                  visible: avisible,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        bvisible = true;
                        cbutton = const Color.fromARGB(255, 1, 139, 125);
                        dbutton = Colors.white;
                        ebutton = Colors.white;
                        ctext = Colors.white;
                        dtext = Colors.black;
                        etext = Colors.black;
                        inf.destination = "오사카";
                      });
                    },
                    child: Container(
                      width: 150,
                      height: 40,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(color: cbutton),
                      child: Text(
                        "오사카",
                        style: TextStyle(
                          color: ctext,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: avisible,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        bvisible = true;
                        dbutton = const Color.fromARGB(255, 1, 139, 125);
                        cbutton = Colors.white;
                        ebutton = Colors.white;
                        dtext = Colors.white;
                        ctext = Colors.black;
                        etext = Colors.black;
                        inf.destination = "도쿄";
                      });
                    },
                    child: Container(
                      width: 150,
                      height: 40,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(color: dbutton),
                      child: Text(
                        "도쿄",
                        style: TextStyle(
                          color: dtext,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: avisible,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        bvisible = true;
                        ebutton = const Color.fromARGB(255, 1, 139, 125);
                        cbutton = Colors.white;
                        dbutton = Colors.white;
                        etext = Colors.white;
                        ctext = Colors.black;
                        dtext = Colors.black;
                        inf.destination = "나고야";
                      });
                    },
                    child: Container(
                      width: 150,
                      height: 40,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(color: ebutton),
                      child: Text(
                        "나고야",
                        style: TextStyle(
                          color: etext,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 85,
            left: 302,
            child: Column(
              children: [
                Visibility(
                  visible: bvisible,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        fbutton = const Color.fromARGB(255, 1, 139, 125);
                        gbutton = Colors.white;
                        hbutton = Colors.white;
                        ftext = Colors.white;
                        gtext = Colors.black;
                        htext = Colors.black;
                        inf.flnumber = "10:00";
                        nvisible = true;
                      });
                    },
                    child: Container(
                      width: 140,
                      height: 40,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(color: fbutton),
                      child: Text(
                        "10:00",
                        style: TextStyle(
                          color: ftext,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: bvisible,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        gbutton = const Color.fromARGB(255, 1, 139, 125);
                        fbutton = Colors.white;
                        hbutton = Colors.white;
                        gtext = Colors.white;
                        ftext = Colors.black;
                        htext = Colors.black;
                        inf.flnumber = "12:00";
                        nvisible = true;
                      });
                    },
                    child: Container(
                      width: 140,
                      height: 40,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(color: gbutton),
                      child: Text(
                        "12:00",
                        style: TextStyle(
                          color: gtext,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: bvisible,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        hbutton = const Color.fromARGB(255, 1, 139, 125);
                        gbutton = Colors.white;
                        fbutton = Colors.white;
                        htext = Colors.white;
                        gtext = Colors.black;
                        ftext = Colors.black;
                        inf.flnumber = "14:00";
                        nvisible = true;
                      });
                    },
                    child: Container(
                      width: 140,
                      height: 40,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(color: hbutton),
                      child: Text(
                        "14:00",
                        style: TextStyle(
                          color: htext,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 250,
            left: 370,
            child: Visibility(
              visible: nvisible,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Passport()),
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
          ),
          Positioned(
            top: 300,
            left: 15,
            child: Visibility(
              visible: qvisible,
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  '국가 도착지 편명을 선택하고 다음단계 버튼을 눌러주세요',
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

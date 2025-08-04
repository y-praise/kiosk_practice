import 'package:flutter/material.dart';
import 'pension/pension_announcement.dart';
import 'employment/employment_announcement.dart';
import 'passport/passport_announcement.dart';
import 'health/health_announcement.dart';
import 'traffic/traffic_announcement.dart';
import 'real_estate/real_estate_announcement.dart';
import 'tax/tax_announcement.dart';
import 'expulsion/expulsion_announcement.dart';
import 'family/family_announcement.dart';
import 'military/military_announcement.dart';
import 'common_pages/mobile_ID.dart';
import 'common_pages/main_page.dart';
import 'common_pages/fingerprint.dart';
import 'registration/announcement.dart';
import 'car/car_announcement.dart';
import 'welfare/welfare_announcement.dart';
import 'widgets.dart';
import 'dart:math';

class CivilServiceMachine extends StatefulWidget {
  @override
  State createState() => CivilServiceMachineState();
}

class CivilServiceMachineState extends State<CivilServiceMachine> {
  late Widget _page;
  double page_number = 0.0;
  late String instruction;
  int cash = 0;
  bool vertification = false;

  @override
  void initState() {
    super.initState();
    _page = MainPage(switchPageCallback: _switch_page);
  }

  void _switch_page(Widget newPage, double new_page_num) {
    setState(() {
      _page = LoadingPage();
      page_number = new_page_num;
    });

    int randomNumber = Random().nextInt(5);
    Future.delayed(Duration(seconds: randomNumber), () {
      setState(() {
        _page = newPage;
      });
    });
  }

  void _return_cash() {
    setState(() {
      cash = 0;
    });
  }

  void _insert_cash() {
    setState(() {
      cash += 1000;
    });
  }

  void _insert_coin() {
    setState(() {
      cash += 100;
    });
  }

  void _vertification() {
    print(page_number);
    setState(() {
      if (_page.runtimeType == FingerprintPage ||
          _page.runtimeType == MobileIdPage) {
        vertification = true;
        switch (page_number) {
          case 1.1:
          case 1.2:
            _switch_page(
              RegistrationAnnouncement(
                switchPageCallback: _switch_page,
                pageNum: page_number,
              ),
              page_number,
            );
            break;

          case 2.1:
          case 2.2:
            _switch_page(
              CarAnnouncement(
                switchPageCallback: _switch_page,
                page_num: page_number,
              ),
              page_number,
            );
            break;

          case 3.1:
          case 3.2:
          case 3.3:
            _switch_page(
              WelfareAnnouncement(
                switchPageCallback: _switch_page,
                page_num: page_number,
              ),
              page_number,
            );
            break;

          case 4.1:
          case 4.2:
          case 4.3:
          case 4.4:
          case 4.5:
            _switch_page(
              FamilyAnnouncement(
                switchPageCallback: _switch_page,
                page_num: page_number,
              ),
              page_number,
            );
            break;

          case 5.1:
          case 5.2:
            _switch_page(
              ExpulsionAnnouncement(
                switchPageCallback: _switch_page,
                page_num: page_number,
              ),
              page_number,
            );
            break;

          case 6.0:
            _switch_page(
              MilitaryAnnouncement(
                switchPageCallback: _switch_page,
                page_num: page_number,
              ),
              page_number,
            );
            break;

          case 7.0:
            _switch_page(
              TaxAnnouncement(
                switchPageCallback: _switch_page,
                page_num: page_number,
              ),
              page_number,
            );
            break;

          case 8.0:
            _switch_page(
              RealEstateAnnouncement(
                switchPageCallback: _switch_page,
                page_num: page_number,
              ),
              page_number,
            );
            break;

          case 9.1:
          case 9.2:
            _switch_page(
              TrafficAnnouncement(
                switchPageCallback: _switch_page,
                page_num: page_number,
              ),
              page_number,
            );
            break;

          case 10.1:
          case 10.2:
          case 10.3:
            _switch_page(
              HealthAnnouncement(
                switchPageCallback: _switch_page,
                page_num: page_number,
              ),
              page_number,
            );
            break;

          case 11.1:
          case 11.2:
          case 11.3:
            _switch_page(
              EmploymentAnnouncement(
                switchPageCallback: _switch_page,
                page_num: page_number,
              ),
              page_number,
            );
            break;

          case 12.1:
          case 12.2:
          case 12.3:
            _switch_page(
              PassportAnnouncement(
                switchPageCallback: _switch_page,
                page_num: page_number,
              ),
              page_number,
            );
            break;
          
          case 13.1:
          case 13.2:
          case 13.3:
            _switch_page(
              PensionAnnouncement(
                switchPageCallback: _switch_page,
                page_num: page_number,
              ),
              page_number,
            );
            break;
        }
      } else
        vertification = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('무인민원발급창구'),),
      backgroundColor: const Color.fromARGB(255, 182, 232, 255),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3, //Display 가로 비율
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(width: 2)),
                    padding: EdgeInsets.fromLTRB(3, 20, 3, 20),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 10),
                            ),
                            child: Column(
                              children: [
                                Expanded(flex: 6, child: _page),
                                Expanded(
                                  flex: 1,
                                  child: buttonWidget(
                                    context,
                                    () => _switch_page(
                                      MainPage(
                                        switchPageCallback: _switch_page,
                                      ),
                                      0.0,
                                    ),
                                    '처음 화면',
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    width: double.infinity,
                                    child: Image.asset(
                                      'assets/images/mobile_ID.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              Container(
                                color: Colors.black,
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  '증명서 나오는 곳',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Container(
                                width: 200,
                                height: 5,
                                color: Colors.black,
                                margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  flex: 1, //오른쪽 박스
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(width: 1)),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 9,
                          child: Container(
                            color: const Color.fromARGB(255, 36, 36, 36),
                            margin: EdgeInsets.all(3),
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.white,
                                  width: 80,
                                  height: 60,
                                  margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  child: Container(
                                    color: Colors.red,
                                    margin: EdgeInsets.all(5),
                                    child: Text(
                                      '🚓',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.black,
                                  width: 80,
                                  height: 60,
                                  margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  padding: EdgeInsets.all(4),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(1),
                                        child: Image.asset(
                                          'assets/images/j-dragon.png',
                                          height: 35,
                                        ),
                                      ),
                                      Text(
                                        '경보시스템 작동중',
                                        style: TextStyle(
                                          color: Colors.yellow,
                                          fontSize: 8,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.black,
                                  width: 80,
                                  height: 40,
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Text(
                                        '$cash',
                                        style: TextStyle(color: Colors.red),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        '현재금액',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 20, 1, 20),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            color: Colors.black,
                                            margin: EdgeInsets.all(5),
                                            padding: EdgeInsets.all(3),
                                            child: Text(
                                              '반환버튼',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: _return_cash,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                              shape: const CircleBorder(),
                                            ),
                                            child: Text(''),
                                          ),

                                          SizedBox(height: 15),
                                          Container(
                                            color: Colors.black,
                                            margin: EdgeInsets.all(5),
                                            padding: EdgeInsets.all(3),
                                            child: Text(
                                              '지폐 넣는 곳',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                            height: 20,
                                            color: Colors.yellow,
                                            padding: EdgeInsets.fromLTRB(
                                              2,
                                              0,
                                              2,
                                              4,
                                            ),
                                            child: Container(
                                              child: ElevatedButton(
                                                onPressed: _insert_cash,
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          0,
                                                        ),
                                                  ),
                                                  backgroundColor: Colors.black,
                                                ),
                                                child: Text(''),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Container(
                                            color: Colors.black,
                                            margin: EdgeInsets.all(5),
                                            padding: EdgeInsets.all(3),
                                            child: Text(
                                              '동전 \n넣는 곳',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Container(
                                            width: 7,
                                            height: 50,
                                            child: ElevatedButton(
                                              onPressed: _insert_coin,
                                              style: ElevatedButton.styleFrom(),
                                              child: Text(''),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.fromLTRB(1, 20, 1, 20),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            color: Colors.black,
                                            margin: EdgeInsets.all(5),
                                            padding: EdgeInsets.all(3),
                                            child: Text(
                                              '지문인식기',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 30,
                                            height: 60,
                                            color: const Color.fromARGB(
                                              255,
                                              139,
                                              139,
                                              139,
                                            ),
                                            padding: EdgeInsets.fromLTRB(
                                              2,
                                              2,
                                              2,
                                              30,
                                            ),
                                            child: Container(
                                              child: ElevatedButton(
                                                onPressed: _vertification,
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          0,
                                                        ),
                                                  ),
                                                  backgroundColor: Colors.black,
                                                ),
                                                child: Text(''),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Container(
                                            color: Colors.black,
                                            margin: EdgeInsets.all(5),
                                            padding: EdgeInsets.all(3),
                                            child: Text(
                                              '신용카드',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                            height: 35,
                                            color: const Color.fromARGB(
                                              255,
                                              219,
                                              219,
                                              219,
                                            ),
                                            padding: EdgeInsets.fromLTRB(
                                              2,
                                              15,
                                              2,
                                              15,
                                            ),
                                            child: Container(
                                              child: ElevatedButton(
                                                onPressed: _insert_cash,
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          0,
                                                        ),
                                                  ),
                                                  backgroundColor: Colors.black,
                                                ),
                                                child: Text(''),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  child: Text('도움말 보기'),
                                  onPressed: () {
                                    final snackBar = SnackBar(
                                      content: const Text(''),
                                      action: SnackBarAction(
                                        label: '도움말 닫기',
                                        onPressed: () {},
                                      ),
                                    );
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(snackBar);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Container(
                                color: Colors.black,
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  '영수증',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Container(
                                width: 70,
                                height: 5,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
